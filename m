From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 3/3] mmc: sdhci-spear: add device tree bindings
Date: Tue, 27 Mar 2012 08:40:36 +0530
Message-ID: <7ff0c6ac151a5d88293fb8ec261c130c2c875f33.1332817654.git.viresh.kumar@st.com>
References: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:46529 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755541Ab2C0D1r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 23:27:47 -0400
In-Reply-To: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

This adds simple DT bindings for SDHCI SPEAr controller.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 .../devicetree/bindings/mmc/sdhci-spear.txt        |   29 ++++++++
 drivers/mmc/host/sdhci-spear.c                     |   71 +++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-spear.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-spear.txt b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
new file mode 100644
index 0000000..4edc11a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
@@ -0,0 +1,29 @@
+* SPEAr SDHCI Controller
+
+Required properties:
+- compatible : "st,spear300-sdhci"
+- reg : Address range of the sdhci registers
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupt: Should contain the sdhci interrupt number
+
+Optional Properties:
+- power-gpio: specifies the power gpio pin with flags: active low:1, active
+  high:0
+- int-gpio: card detect interrupt gpio, with zero flags.
+
+  If your board don't support these gpios then don't pass the entry.
+
+- power_always_enb: power should be on before inserting the card and so can't be
+  switched off. Only valid when power gpio is supported.
+
+Example:
+
+	sdhci@fc000000 {
+		compatible = "st,spear300-sdhci";
+		reg = <0xfc000000 0x1000>;
+
+		power-gpio = <&gpio0 5 0>
+		int-gpio = <&gpio0 6 0>
+		power_always_enb;
+	};
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 1fe32df..62c9730 100644
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
+	pgpio = of_get_named_gpio_flags(np, "power-gpio", 0, &flags);
+	if (!gpio_is_valid(pgpio))
+		pgpio = -1;
+
+	igpio = of_get_named_gpio(np, "int-gpio", 0);
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
+		if (of_property_read_bool(np, "power_always_enb"))
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
@@ -110,8 +160,16 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
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
-- 
1.7.10.rc2.10.gb47606

