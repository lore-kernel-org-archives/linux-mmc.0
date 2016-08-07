From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] mmc: pwrseq-simple: Add an optional post-power-on-delay
Date: Sun,  7 Aug 2016 21:02:38 +0200
Message-ID: <1470596558-23195-2-git-send-email-hdegoede@redhat.com>
References: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some devices need a while to boot their firmware after providing clks /
de-asserting resets before they are ready to receive sdio commands.

This commits adds a post-power-on-delay-ms devicetree property to
mmc-pwrseq-simple for use with such devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index ce0e767..e254368 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -16,6 +16,8 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- post-power-on-delay-ms : Delay in ms after powering the card and
+	de-asserting the reset-gpios (if any)
 
 Example:
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 450d907..1304160 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/property.h>
 
 #include <linux/mmc/host.h>
 
@@ -24,6 +26,7 @@
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
+	u32 post_power_on_delay_ms;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
 };
@@ -64,6 +67,9 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
+
+	if (pwrseq->post_power_on_delay_ms)
+		msleep(pwrseq->post_power_on_delay_ms);
 }
 
 static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
@@ -111,6 +117,9 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpios);
 	}
 
+	device_property_read_u32(dev, "post-power-on-delay-ms",
+				 &pwrseq->post_power_on_delay_ms);
+
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
-- 
2.7.4
