From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend 1/2] mmc: sdhci-spear: add device tree bindings
Date: Fri, 28 Sep 2012 15:29:51 +0530
Message-ID: <CAOh2x==YUrjA0xXP+npBUM1vkZ1pG0nunXqc5jwrxntiP0OvMw@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
	<87lifuv7rm.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56281 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2I1J7w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 05:59:52 -0400
Received: by oagh16 with SMTP id h16so2765169oag.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 02:59:52 -0700 (PDT)
In-Reply-To: <87lifuv7rm.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de

On Fri, Sep 28, 2012 at 2:33 PM, Chris Ball <cjb@laptop.org> wrote:
> You don't have to mention reg/interrupts, because they're already
> covered in mmc.txt.

> power-gpio should be "power-gpios" (even though there's only one), and
> power_always_enb should use hyphens instead of underscores

Hi Chris,

I have fixed above two for now, please apply below if it looks fine to you:


From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 26 Mar 2012 15:05:14 +0530
Subject: [PATCH V2 1/2] mmc: sdhci-spear: add device tree bindings

This adds simple DT bindings for SDHCI SPEAr controller. It uses cd-gpios from
common mmc bindings.

This also fixes spear300-evb.dts with correct name for card detect binding.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-spear.txt        | 24 ++++++++
 arch/arm/boot/dts/spear300-evb.dts                 |  4 +-
 arch/arm/boot/dts/spear320-evb.dts                 |  4 +-
 drivers/mmc/host/sdhci-spear.c                     | 71 +++++++++++++++++++++-
 4 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-spear.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
new file mode 100644
index 0000000..5d9be8b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
@@ -0,0 +1,24 @@
+* SPEAr SDHCI Controller
+
+Required properties:
+- compatible : "st,spear300-sdhci"
+
+Optional Properties:
+- cd-gpios: card detect gpio, with zero flags.
+- power-gpios: specifies the power gpio pin with flags: active low:1, active
+  high:0
+- power-always-enb: power should be on before inserting the card and
so can't be
+  switched off. Only valid when power gpio is supported.
+
+If your board don't support these gpios then don't pass the entry.
+
+Example:
+
+	sdhci@fc000000 {
+		compatible = "st,spear300-sdhci";
+		reg = <0xfc000000 0x1000>;
+
+		power-gpios = <&gpio0 5 0>
+		power-always-enb;
+		cd-gpios = <&gpio0 6 0>
+	};
diff --git a/arch/arm/boot/dts/spear300-evb.dts
b/arch/arm/boot/dts/spear300-evb.dts
index d71b8d5..a26abed 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -80,8 +80,8 @@
 		};

 		sdhci@70000000 {
-			int-gpio = <&gpio1 0 0>;
-			power-gpio = <&gpio1 2 1>;
+			cd-gpios = <&gpio1 0 0>;
+			power-gpios = <&gpio1 2 1>;
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/spear320-evb.dts
b/arch/arm/boot/dts/spear320-evb.dts
index e4e912f..490c85a 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -103,8 +103,8 @@
 		};

 		sdhci@70000000 {
-			power-gpio = <&gpio0 2 1>;
-			power_always_enb;
+			power-gpios = <&gpio0 2 1>;
+			power-always-enb;
 			status = "okay";
 		};

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 423da81..854f7e9 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -68,8 +70,56 @@ static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

+#ifdef CONFIG_OF
+static struct sdhci_plat_data * __devinit
+sdhci_probe_config_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_plat_data *pdata = NULL;
+	enum of_gpio_flags flags;
+	int pgpio, igpio;
+
+	pgpio = of_get_named_gpio_flags(np, "power-gpios", 0, &flags);
+	if (!gpio_is_valid(pgpio))
+		pgpio = -1;
+
+	igpio = of_get_named_gpio(np, "cd-gpios", 0);
+	if (!gpio_is_valid(igpio))
+		igpio = -1;
+
+	/* If pdata is required */
+	if ((pgpio != -1) || (igpio != -1)) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "DT: kzalloc failed\n");
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	/* if power gpio is supported */
+	if (pgpio != -1) {
+		pdata->power_active_high = (flags != OF_GPIO_ACTIVE_LOW);
+
+		if (of_property_read_bool(np, "power-always-enb"))
+			pdata->power_always_enb = true;
+	}
+
+	pdata->card_power_gpio = pgpio;
+	pdata->card_int_gpio = igpio;
+
+	return pdata;
+}
+#else
+static struct sdhci_plat_data * __devinit
+sdhci_probe_config_dt(struct platform_device *pdev)
+{
+	return ERR_PTR(-ENOSYS);
+}
+#endif
+
 static int __devinit sdhci_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct spear_sdhci *sdhci;
@@ -110,8 +160,16 @@ static int __devinit sdhci_probe(struct
platform_device *pdev)
 		goto put_clk;
 	}

-	/* overwrite platform_data */
-	sdhci->data = dev_get_platdata(&pdev->dev);
+	if (np) {
+		sdhci->data = sdhci_probe_config_dt(pdev);
+		if (IS_ERR(sdhci->data)) {
+			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
+			return -ENODEV;
+		}
+	} else {
+		sdhci->data = dev_get_platdata(&pdev->dev);
+	}
+
 	pdev->dev.platform_data = sdhci;

 	if (pdev->dev.parent)
@@ -276,11 +334,20 @@ static int sdhci_resume(struct device *dev)

 static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);

+#ifdef CONFIG_OF
+static const struct of_device_id sdhci_spear_id_table[] = {
+	{ .compatible = "st,spear300-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_spear_id_table);
+#endif
+
 static struct platform_driver sdhci_driver = {
 	.driver = {
 		.name	= "sdhci",
 		.owner	= THIS_MODULE,
 		.pm	= &sdhci_pm_ops,
+		.of_match_table = of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		= sdhci_probe,
 	.remove		= __devexit_p(sdhci_remove),
