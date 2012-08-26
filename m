From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v4 6/9] mmc: dw_mmc: add device tree support
Date: Sun, 26 Aug 2012 17:22:04 +0530
Message-ID: <1345981927-26359-7-git-send-email-thomas.abraham@linaro.org>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Add device tree based discovery support.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   90 ++++++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c                    |    9 ++
 drivers/mmc/host/dw_mmc.c                          |  130 ++++++++++++++++++-
 3 files changed, 222 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
new file mode 100644
index 0000000..790b1bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
@@ -0,0 +1,90 @@
+* Synopsis Designware Mobile Storage Host Controller
+
+The Synopsis designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core mmc properties described by mmc.txt and the
+properties used by the Synopsis Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
+* #address-cells: should be 1.
+* #size-cells: should be 0.
+
+# Slots: The slot specific information are contained within child-nodes with
+  each child-node representing a supported slot. There should be atleast one
+  child node representing a card slot. The name of the child node representing
+  the slot is recommended to be slot@n where n is the unique number of the slot
+  connnected to the controller. The following are optional properties which
+  can be included in the slot child node.
+
+	* reg: specifies the physical slot number. The valid values of this
+	  property is 0 to (num-slots -1), where num-slots is the value
+	  specified by the num-slots property.
+
+	* bus-width: as documented in mmc core bindings.
+
+	* wp-gpios: specifies the write protect gpio line. The format of the
+	  gpio specifier depends on the gpio controller. If the write-protect
+	  line is not available, this property is optional.
+
+	* gpios: specifies a list of gpios used for command, clock and data
+	  bus. The first gpio is the command line and the second gpio is the
+	  clock line. The rest of the gpios (depending on the bus-width
+	  property) are the data lines in no particular order. The format of
+	  the gpio specifier depends on the gpio controller.
+
+Optional properties:
+
+* num-slots: specifies the number of slots supported by the controller.
+  The number of physical slots actually used could be equal or less than the
+  value specified by num-slots. If this property is not specified, the value
+  of num-slot property is assumed to be 1.
+
+* fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
+  specified, the default value of the fifo size is determined from the
+  controller registers.
+
+* card-detect-delay: Delay in milli-seconds before detecting card after card
+  insert event. The default value is 0.
+
+* supports-highspeed: Enables support for high speed cards (upto 50MHz)
+
+* broken-cd: as documented in mmc core bindings.
+
+Aliases:
+
+- All the MSHC controller nodes should be represented in the aliases node using
+  the following format 'mshc{n}' where n is a unique number for the alias.
+
+Example:
+
+The MSHC controller node can be split into two portions, SoC specific and
+board specific portions as listed below.
+
+	dwmmc0@12200000 {
+		compatible = "snps,dw-mshc";
+		reg = <0x12200000 0x1000>;
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc0@12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <8>;
+			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
+				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
+				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
+				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
+				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
+		};
+	};
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 1488b17..25c5f11 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -19,6 +19,8 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/dw_mmc.h>
+#include <linux/of.h>
+
 #include "dw_mmc.h"
 
 static int dw_mci_pltfm_probe(struct platform_device *pdev)
@@ -94,10 +96,17 @@ static int dw_mci_pltfm_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
 
+static const struct of_device_id dw_mci_pltfm_match[] = {
+	{ .compatible = "snps,dw-mshc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
+
 static struct platform_driver dw_mci_pltfm_driver = {
 	.remove		= __exit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dw_mmc",
+		.of_match_table	= of_match_ptr(dw_mci_pltfm_match),
 		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 075f89d..b8ec067 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -33,6 +33,7 @@
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
 #include <linux/workqueue.h>
+#include <linux/of.h>
 
 #include "dw_mmc.h"
 
@@ -1762,10 +1763,57 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 	}
 }
 
+#ifdef CONFIG_OF
+/* given a slot id, find out the device node representing that slot */
+static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
+{
+	struct device_node *np;
+	const __be32 *addr;
+	int len;
+
+	if (!dev || !dev->of_node)
+		return NULL;
+
+	for_each_child_of_node(dev->of_node, np) {
+		addr = of_get_property(np, "reg", &len);
+		if (!addr || (len < sizeof(int)))
+			continue;
+		if (be32_to_cpup(addr) == slot)
+			return np;
+	}
+	return NULL;
+}
+
+/* find out bus-width for a given slot */
+static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
+{
+	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
+	u32 bus_wd = 1;
+
+	if (!np)
+		return 1;
+
+	if (of_property_read_u32(np, "bus-width", &bus_wd))
+		dev_err(dev, "bus-width property not found, assuming width"
+			       " as 1\n");
+	return bus_wd;
+}
+#else /* CONFIG_OF */
+static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
+{
+	return 1;
+}
+static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
+	u8 bus_width;
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
 	if (!mmc)
@@ -1775,6 +1823,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->id = id;
 	slot->mmc = mmc;
 	slot->host = host;
+	host->slot[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510);
@@ -1799,8 +1848,18 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->caps2 = host->pdata->caps2;
 
 	if (host->pdata->get_bus_wd)
-		if (host->pdata->get_bus_wd(slot->id) >= 4)
-			mmc->caps |= MMC_CAP_4_BIT_DATA;
+		bus_width = host->pdata->get_bus_wd(slot->id);
+	else if (host->dev->of_node)
+		bus_width = dw_mci_of_get_bus_wd(host->dev, slot->id);
+	else
+		bus_width = 1;
+
+	switch (bus_width) {
+	case 8:
+		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	case 4:
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
@@ -1845,7 +1904,6 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	else
 		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 
-	host->slot[id] = slot;
 	mmc_add_host(mmc);
 
 #if defined(CONFIG_DEBUG_FS)
@@ -1937,16 +1995,74 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
 	return false;
 }
 
+#ifdef CONFIG_OF
+static struct dw_mci_of_quirks {
+	char *quirk;
+	int id;
+} of_quirks[] = {
+	{
+		.quirk	= "supports-highspeed",
+		.id	= DW_MCI_QUIRK_HIGHSPEED,
+	}, {
+		.quirk	= "broken-cd",
+		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	},
+};
+
+static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_board *pdata;
+	struct device *dev = host->dev;
+	struct device_node *np = dev->of_node;
+	int idx;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "could not allocate memory for pdata\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* find out number of slots supported */
+	if (of_property_read_u32(dev->of_node, "num-slots",
+				&pdata->num_slots)) {
+		dev_info(dev, "num-slots property not found, "
+				"assuming 1 slot is available\n");
+		pdata->num_slots = 1;
+	}
+
+	/* get quirks */
+	for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
+		if (of_get_property(np, of_quirks[idx].quirk, NULL))
+			pdata->quirks |= of_quirks[idx].id;
+
+	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
+		dev_info(dev, "fifo-depth property not found, using "
+				"value of FIFOTH register as default\n");
+
+	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
+
+	return pdata;
+}
+
+#else /* CONFIG_OF */
+static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /* CONFIG_OF */
+
 int dw_mci_probe(struct dw_mci *host)
 {
 	int width, i, ret = 0;
 	u32 fifo_size;
 	int init_slots = 0;
 
-	if (!host->pdata || !host->pdata->init) {
-		dev_err(host->dev,
-			"Platform data must supply init function\n");
-		return -ENODEV;
+	if (!host->pdata) {
+		host->pdata = dw_mci_parse_dt(host);
+		if (IS_ERR(host->pdata)) {
+			dev_err(host->dev, "platform data not available\n");
+			return -EINVAL;
+		}
 	}
 
 	if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
-- 
1.6.6.rc2
