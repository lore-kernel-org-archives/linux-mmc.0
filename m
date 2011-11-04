From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 4 Nov 2011 17:20:39 +0530
Message-ID: <1320407441-29697-3-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

Define dt bindings for the ti-omap-hsmmc, and adapt
the driver to extract data (which was earlier passed as
platform_data) from device tree node.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++++++++
 drivers/mmc/host/omap_hsmmc.c                      |  117 ++++++++++++++++++++
 2 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
new file mode 100644
index 0000000..370af1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -0,0 +1,50 @@
+* TI Highspeed MMC host controller for OMAP
+
+The Highspeed MMC Host Controller on TI OMAP family
+provides an interface for MMC, SD, and SDIO types of memory cards.
+
+Required properties:
+- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap2-hsmmc";
+n is controller instance starting 0, for OMAP2/3 controllers
+- compatible: Should be "ti,omap-hsmmc<n>", "ti,omap4-hsmmc";
+n is controller instance starting 0, for OMAP4 controllers
+- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
+- reg : should contain hsmmc registers location and length
+
+Optional properties:
+ti,hsmmc-supports-dual-volt: boolean, supports dual voltage cards
+ti,hsmmc-nr-slots: Number of mmc slots
+<supply-name>-supply: phandle to the regulator device tree node
+"supply-name" examples are "vmmc", "vmmc_aux" etc
+ti,hsmmc-has-pbias: Has PBIAS cell support
+ti,hsmmc-has-special-reset: Requires a special softreset sequence
+
+For every supported slot a slot node can be defined
+with the following optional properties
+
+ti,hsmmc-slot-name: Name assocaited to the mmc slot
+ti,hsmmc-gpio-cd: gpio for card detect
+ti,hsmmc-gpio-wp: gpio for write protect
+ti,hsmmc-ocr-mask: mmc/sd/sdio ocr mask
+ti,hsmmc-non-removable: non-removable slot (like eMMC)
+
+One or more of the linux specific mmc host bindings can also be used.
+See Documentation/devicetree/bindings/mmc/linux-mmc-host.txt for all the
+linux mmc host controller specific bindings.
+
+Example:
+	mmc1: mmc@0x4809c000 {
+		compatible = "ti,omap-hsmmc0", "ti,omap4-hsmmc";
+		reg = <0x4809c000 0x400>;
+		ti,hwmods = "mmc1";
+		ti,hsmmc-supports-dual-volt;
+		ti,hsmmc-nr-slots = <1>;
+		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		slot@1 {
+			ti,hsmmc-slot-name = "wlan";
+			linux,mmc_cap_4_bit_data;
+			linux,mmc_cap_power_off_card;
+			ti,hsmmc-ocr-mask = <0x80>;
+			ti,hsmmc-nonremovable;
+		};
+	};
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21e4a79..90b4a61 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -27,6 +27,9 @@
 #include <linux/workqueue.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
@@ -117,6 +120,7 @@
 #define OMAP_MMC3_DEVID		2
 #define OMAP_MMC4_DEVID		3
 #define OMAP_MMC5_DEVID		4
+#define OMAP_MMC_DEV_MAX	5
 
 #define MMC_AUTOSUSPEND_DELAY	100
 #define MMC_TIMEOUT_MS		20
@@ -1862,6 +1866,90 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 
 #endif
 
+#ifdef CONFIG_OF
+static unsigned int of_get_hsmmc_instance(struct device_node *np)
+{
+	int i;
+	char comp[32];
+
+	for (; i < OMAP_MMC_DEV_MAX; i++) {
+		snprintf(comp, 32, "ti,omap-hsmmc%d", i);
+		if (of_device_is_compatible(np, comp))
+			break;
+	}
+	return i;
+}
+
+static void of_get_hsmmc_slot_data(struct device_node *np,
+			struct omap_mmc_platform_data **pdata)
+{
+	struct device_node *child;
+	int i = 0;
+	unsigned long *caps;
+
+	for_each_child_of_node(np, child) {
+		(*pdata)->slots[i].switch_pin =
+			of_get_named_gpio(child, "ti,hsmmc-gpio-cd", 0);
+		(*pdata)->slots[i].gpio_wp =
+			of_get_named_gpio(child, "ti,hsmmc-gpio-wp", 0);
+		(*pdata)->slots[i].name = of_get_property(child,
+					"ti,hsmmc-slot-name", NULL);
+		if (of_find_property(child, "ti,hsmmc-nonremovable", NULL))
+			(*pdata)->slots[i].nonremovable = true;
+		if (of_find_property(child, "ti,hsmmc-has-pbias", NULL))
+			(*pdata)->slots[i].features |= HSMMC_HAS_PBIAS;
+		if (of_find_property(child, "ti,hsmmc-has-special-reset", NULL))
+			(*pdata)->slots[i].features |= HSMMC_HAS_UPDATED_RESET;
+		of_property_read_u32(child, "ti,hsmmc-ocr-mask",
+					&(*pdata)->slots[i].ocr_mask);
+		caps = (unsigned long *)&(*pdata)->slots[i].caps;
+		mmc_of_parse_host_caps(child, caps);
+		i++;
+	}
+}
+
+static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
+{
+	struct omap_mmc_platform_data *pdata;
+	const __be32 *nr_slots;
+	const __be64 *dma_mask;
+	struct device_node *np = dev->of_node;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL; /* out of memory */
+
+	nr_slots = of_get_property(np, "ti,hsmmc-nr-slots", NULL);
+	if (nr_slots) {
+		pdata->nr_slots = be32_to_cpu(*nr_slots);
+		of_get_hsmmc_slot_data(np, &pdata);
+	}
+
+	dma_mask = of_get_property(np, "ti,hsmmc-dma-mask", NULL);
+	if (dma_mask)
+		pdata->dma_mask = be64_to_cpu(*dma_mask);
+	if (of_find_property(np, "ti,hsmmc-supports-dual-volt", NULL))
+		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
+
+	return pdata;
+}
+#else
+static inline void of_get_hsmmc_slot_data(struct device_node *np,
+			struct omap_mmc_platform_data **pdata)
+{}
+static inline struct omap_mmc_platform_data
+			*of_get_hsmmc_pdata(struct device *dev)
+{
+	return NULL;
+}
+static inline unsigned int of_get_hsmmc_instance(struct device_node *np)
+{
+	return -1;
+}
+#endif
+
+static const struct of_device_id omap_mmc_of_match[];
+
 static int __init omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -1869,6 +1957,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
 	int ret, irq;
+	const struct of_device_id *match;
+
+	match = of_match_device(omap_mmc_of_match, &pdev->dev);
+	if (match) {
+		pdata = of_get_hsmmc_pdata(&pdev->dev);
+		if (match->data)
+			pdata->reg_offset = *(u16 *)match->data;
+	}
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
@@ -1910,6 +2006,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->id	= pdev->id;
+	if (pdev->dev.of_node)
+		host->id = of_get_hsmmc_instance(pdev->dev.of_node);
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
@@ -2269,12 +2367,31 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.runtime_resume = omap_hsmmc_runtime_resume,
 };
 
+#if defined(CONFIG_OF)
+static u16 omap4_reg_offset = 0x100;
+
+static const struct of_device_id omap_mmc_of_match[] = {
+	{
+		.compatible = "ti,omap2-hsmmc",
+	},
+	{
+		.compatible = "ti,omap4-hsmmc",
+		.data = &omap4_reg_offset,
+	},
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
+#else
+#define omap_mmc_of_match NULL
+#endif
+
 static struct platform_driver omap_hsmmc_driver = {
 	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 		.pm = &omap_hsmmc_dev_pm_ops,
+		.of_match_table = omap_mmc_of_match,
 	},
 };
 
-- 
1.7.1

