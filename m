From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 08/14] power: pwrseq: simple: Add support for regulators and
 generic property
Date: Thu, 09 Jun 2016 11:44:25 +0200
Message-ID: <1465465471-28740-9-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Some devices need real hard-reset by cutting the power.  During power
sequence turn off and on all of provided regulators.

Additionally add support for instantiating the pwrseq-simple device on a
generic property 'power-sequence'.  The device will attach itself to the
node containing the property and parse the node's properties like
reset-gpios, supplies etc.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../bindings/power/pwrseq/pwrseq-simple.txt        |  30 +++++-
 drivers/power/pwrseq/pwrseq_simple.c               | 113 ++++++++++++++++++++-
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
index ce0e76749671..7e5a414a67fc 100644
--- a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
@@ -1,11 +1,18 @@
-* The simple MMC power sequence provider
+* The simple power sequence provider
 
-The purpose of the simple MMC power sequence provider is to supports a set of
+The purpose of the simple power sequence provider is to supports a set of
 common properties between various SOC designs. It thus enables us to use the
 same provider for several SOC designs.
 
-Required properties:
-- compatible : contains "mmc-pwrseq-simple".
+The driver supports two types of bindings:
+1. Property for any node
+   Required properties:
+   - power-sequence
+
+2. Separate node (not recommended for new users)
+   Required properties:
+   - compatible : contains "mmc-pwrseq-simple".
+
 
 Optional properties:
 - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
@@ -16,6 +23,8 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- *-supply : If supplies are provided, the driver will enable and disable
+             them during power sequence.
 
 Example:
 
@@ -25,3 +34,16 @@ Example:
 		clocks = <&clk_32768_ck>;
 		clock-names = "ext_clock";
 	}
+
+	usb3503@08 {
+		compatible = "smsc,usb3503";
+		reg = <0x08>;
+
+		intn-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
+		connect-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
+		initial-mode = <1>;
+
+		power-sequence;
+		vdd-supply = <&buck8_reg>;
+	};
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index 93807a6ef162..f70e207f994b 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -1,12 +1,15 @@
 /*
- *  Copyright (C) 2014 Linaro Ltd
+ * Copyright (C) 2014 Linaro Ltd
+ * Copyright (C) 2016 Samsung Electronics
  *
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *         Krzysztof Kozlowski <k.kozlowski@samsung.com>
  *
  * License terms: GNU General Public License (GPL) version 2
  *
  *  Simple MMC power sequence management
  */
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -16,13 +19,25 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/pwrseq.h>
+#include <linux/delay.h>
+
+static LIST_HEAD(mmc_pwrseq_devs);
+
+struct mmc_pwrseq_dev {
+	struct platform_device *pdev;
+	struct list_head entry;
+};
 
 struct mmc_pwrseq_simple {
 	struct pwrseq pwrseq;
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	unsigned int regulator_count;
+	struct regulator_bulk_data *regulators;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
@@ -60,6 +75,14 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
+	if (pwrseq->regulators) {
+		int err;
+
+		err = regulator_bulk_enable(pwrseq->regulator_count,
+					    pwrseq->regulators);
+		WARN_ON_ONCE(err);
+	}
+
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
@@ -73,6 +96,14 @@ static void mmc_pwrseq_simple_power_off(struct pwrseq *_pwrseq)
 		clk_disable_unprepare(pwrseq->ext_clk);
 		pwrseq->clk_enabled = false;
 	}
+
+	if (pwrseq->regulators) {
+		int err;
+
+		err = regulator_bulk_disable(pwrseq->regulator_count,
+					     pwrseq->regulators);
+		WARN_ON_ONCE(err);
+	}
 }
 
 static const struct pwrseq_ops mmc_pwrseq_simple_ops = {
@@ -91,6 +122,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
 	struct device *dev = &pdev->dev;
+	int err;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
@@ -100,12 +132,39 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return PTR_ERR(pwrseq->ext_clk);
 
+	err = devm_of_regulator_all_get(dev, &pwrseq->regulator_count,
+					&pwrseq->regulators);
+	if (err)
+		return err;
+
+	if (pwrseq->regulators) {
+		/*
+		 * Be sure that regulator is off, before the driver will start
+		 * power sequence. It is likely that regulator is on by default
+		 * and it without toggling it here, it would be disabled much
+		 * later by the core.
+		 */
+		err = regulator_bulk_enable(pwrseq->regulator_count,
+					    pwrseq->regulators);
+		WARN_ON_ONCE(err);
+
+		err = regulator_bulk_disable(pwrseq->regulator_count,
+					     pwrseq->regulators);
+		WARN_ON_ONCE(err);
+	}
+
 	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
 							GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
-		return PTR_ERR(pwrseq->reset_gpios);
+		/*
+		 * Don't care about errors. If this pwrseq device was added
+		 * to node with existing reset-gpios, then the GPIO reset will
+		 * be handled by other device.
+		 */
+		dev_warn(dev, "Cannot get reset gpio: %ld\n",
+			 PTR_ERR(pwrseq->reset_gpios));
 	}
 
 	pwrseq->pwrseq.dev = dev;
@@ -122,6 +181,14 @@ static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
 
 	pwrseq_unregister(&pwrseq->pwrseq);
 
+	if (pwrseq->regulators) {
+		int err;
+
+		err = regulator_bulk_disable(pwrseq->regulator_count,
+					     pwrseq->regulators);
+		WARN_ON_ONCE(err);
+	}
+
 	return 0;
 }
 
@@ -134,5 +201,45 @@ static struct platform_driver mmc_pwrseq_simple_driver = {
 	},
 };
 
-module_platform_driver(mmc_pwrseq_simple_driver);
+static int __init mmc_pwrseq_simple_driver_init(void)
+{
+	struct mmc_pwrseq_dev *pwrseq_dev;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	for_each_node_with_property(np, "power-sequence") {
+		pdev = platform_device_register_simple("pwrseq_simple",
+						       PLATFORM_DEVID_AUTO,
+						       NULL, 0);
+		if (IS_ERR(pdev))
+			continue;
+
+		pwrseq_dev = kzalloc(sizeof(*pwrseq_dev), GFP_KERNEL);
+		if (!pwrseq_dev)
+			continue;
+
+		of_node_get(np);
+		pdev->dev.of_node = np;
+		pwrseq_dev->pdev = pdev;
+		list_add(&pwrseq_dev->entry, &mmc_pwrseq_devs);
+	}
+
+	return platform_driver_register(&mmc_pwrseq_simple_driver);
+}
+module_init(mmc_pwrseq_simple_driver_init);
+
+static void __exit mmc_pwrseq_simple_driver_exit(void)
+{
+	struct mmc_pwrseq_dev *pwrseq_dev, *tmp;
+
+	list_for_each_entry_safe(pwrseq_dev, tmp, &mmc_pwrseq_devs, entry) {
+		list_del(&pwrseq_dev->entry);
+		of_node_put(pwrseq_dev->pdev->dev.of_node);
+		platform_device_unregister(pwrseq_dev->pdev);
+		kfree(pwrseq_dev);
+	}
+
+	platform_driver_unregister(&mmc_pwrseq_simple_driver);
+}
+module_exit(mmc_pwrseq_simple_driver_exit);
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
