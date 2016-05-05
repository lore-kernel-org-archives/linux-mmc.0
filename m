From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2 07/13] power: pwrseq: simple: Add support for toggling
 regulator
Date: Thu, 05 May 2016 14:34:20 +0200
Message-ID: <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

Some devices need real hard-reset by cutting the power.  During power
sequence turn off and on the regulator, if it is provided.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 +
 drivers/power/pwrseq/pwrseq_simple.c               | 50 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index ce0e76749671..176ff831e7f1 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -16,6 +16,7 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- ext-supply : External regulator supply
 
 Example:
 
@@ -24,4 +25,5 @@ Example:
 		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		clocks = <&clk_32768_ck>;
 		clock-names = "ext_clock";
+		ext-supply = <&buck8>;
 	}
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index ab0098412690..4d5ea53d3ead 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -16,7 +16,9 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/pwrseq.h>
+#include <linux/delay.h>
 
 #include <linux/mmc/host.h>
 
@@ -25,6 +27,7 @@ struct mmc_pwrseq_simple {
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct regulator *ext_reg;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
@@ -62,6 +65,13 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_enable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
@@ -75,6 +85,13 @@ static void mmc_pwrseq_simple_power_off(struct pwrseq *_pwrseq)
 		clk_disable_unprepare(pwrseq->ext_clk);
 		pwrseq->clk_enabled = false;
 	}
+
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
 }
 
 static const struct pwrseq_ops mmc_pwrseq_simple_ops = {
@@ -102,6 +119,32 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return PTR_ERR(pwrseq->ext_clk);
 
+	/* FIXME: regulator_get_exclusive? */
+	pwrseq->ext_reg = devm_regulator_get_optional(dev, "ext");
+	if (IS_ERR(pwrseq->ext_reg)) {
+		if (PTR_ERR(pwrseq->ext_reg) == -ENODEV)
+			pwrseq->ext_reg = NULL;
+		else
+			return PTR_ERR(pwrseq->ext_reg);
+	} else {
+		int err;
+		/*
+		 * Be sure that regulator is off, before the driver will start
+		 * power sequence. It is likely that regulator is on by default
+		 * and it without toggling it here, it would be disabled much
+		 * later by the core.
+		 */
+
+		err = regulator_enable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+
+		/* FIXME: handle this in a more sensible way */
+		mdelay(10);
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
 							GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
@@ -124,6 +167,13 @@ static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
 
 	pwrseq_unregister(&pwrseq->pwrseq);
 
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
