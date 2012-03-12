From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device tree
Date: Mon, 12 Mar 2012 20:32:37 +0530
Message-ID: <1331564560-23276-2-git-send-email-rnayak@ti.com>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: robherring2@gmail.com, grant.likely@secretlab.ca, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

Define dt bindings for the ti-omap-hsmmc, and adapt
the driver to extract data (which was earlier passed as
platform_data) from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   33 +++++++++
 drivers/mmc/host/omap_hsmmc.c                      |   73 ++++++++++++++++++++
 2 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
new file mode 100644
index 0000000..dbd4368
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -0,0 +1,33 @@
+* TI Highspeed MMC host controller for OMAP
+
+The Highspeed MMC Host Controller on TI OMAP family
+provides an interface for MMC, SD, and SDIO types of memory cards.
+
+Required properties:
+- compatible:
+ Should be "ti,omap2-hsmmc", for OMAP2 controllers
+ Should be "ti,omap3-hsmmc", for OMAP3 controllers
+ Should be "ti,omap4-hsmmc", for OMAP4 controllers
+- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
+- reg : should contain hsmmc registers location and length
+
+Optional properties:
+ti,dual-volt: boolean, supports dual voltage cards
+<supply-name>-supply: phandle to the regulator device tree node
+"supply-name" examples are "vmmc", "vmmc_aux" etc
+ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
+cd-gpios: GPIOs for card detection
+wp-gpios: GPIOs for write protection
+ti,non-removable: non-removable slot (like eMMC)
+ti,needs-special-reset: Requires a special softreset sequence
+
+Example:
+	mmc1: mmc@0x4809c000 {
+		compatible = "ti,omap4-hsmmc";
+		reg = <0x4809c000 0x400>;
+		ti,hwmods = "mmc1";
+		ti,dual-volt;
+		ti,bus-width = <4>;
+		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		ti,non-removable;
+	};
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 82583bf..38ae8c0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -26,6 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
@@ -1690,6 +1693,65 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 
 #endif
 
+#ifdef CONFIG_OF
+static u16 omap4_reg_offset = 0x100;
+
+static const struct of_device_id omap_mmc_of_match[] = {
+	{
+		.compatible = "ti,omap2-hsmmc",
+	},
+	{
+		.compatible = "ti,omap3-hsmmc",
+	},
+	{
+		.compatible = "ti,omap4-hsmmc",
+		.data = &omap4_reg_offset,
+	},
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
+
+static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
+{
+	struct omap_mmc_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	u32 bus_width;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL; /* out of memory */
+
+	if (of_find_property(np, "ti,dual-volt", NULL))
+		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
+
+	/* This driver only supports 1 slot */
+	pdata->nr_slots = 1;
+	pdata->slots[0].switch_pin = of_get_named_gpio(np, "cd-gpios", 0);
+	pdata->slots[0].gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
+
+	if (of_find_property(np, "ti,non-removable", NULL)) {
+		pdata->slots[0].nonremovable = true;
+		pdata->slots[0].no_regulator_off_init = true;
+	}
+	of_property_read_u32(np, "ti,bus-width", &bus_width);
+	if (bus_width == 4)
+		pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
+	else if (bus_width == 8)
+		pdata->slots[0].caps |= MMC_CAP_8_BIT_DATA;
+
+	if (of_find_property(np, "ti,needs-special-reset", NULL))
+		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+
+	return pdata;
+}
+#else
+static inline struct omap_mmc_platform_data
+			*of_get_hsmmc_pdata(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __init omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -1697,6 +1759,16 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
 	int ret, irq;
+	const struct of_device_id *match;
+
+	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
+	if (match) {
+		pdata = of_get_hsmmc_pdata(&pdev->dev);
+		if (match->data) {
+			u16 *offsetp = match->data;
+			pdata->reg_offset = *offsetp;
+		}
+	}
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
@@ -2102,6 +2174,7 @@ static struct platform_driver omap_hsmmc_driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 		.pm = &omap_hsmmc_dev_pm_ops,
+		.of_match_table = of_match_ptr(omap_mmc_of_match),
 	},
 };
 
-- 
1.7.1

