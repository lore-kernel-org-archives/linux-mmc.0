From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Tue, 12 Jun 2012 15:05:03 -0400
Message-ID: <8762aw1hcw.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56246 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117Ab2FLTFL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Jun 2012 15:05:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

Tested on an OLPC XO-1.75.  (MMP2, sdhci-pxav3, CONFIG_MACH_MMP2_DT=y)

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 .../devicetree/bindings/mmc/sdhci-pxa.txt          |   21 ++++++++
 drivers/mmc/host/sdhci-pxav2.c                     |   52 ++++++++++++++++++++
 drivers/mmc/host/sdhci-pxav3.c                     |   50 +++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
new file mode 100644
index 0000000..5896c24
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -0,0 +1,21 @@
+* Marvell sdhci-pxa v2/v3 controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
+
+Required properties:
+- compatible: Should be "mrvl,pxav2-mmc" or "mrvl,pxav3-mmc".
+
+Optional properties:
+- clk-delay-cycles: Specify a number of cycles to delay for tuning.
+
+Example:
+
+sdhci@d4280800 {
+	compatible = "mrvl,pxav3-mmc";
+	reg = <0xd4280800 0x800>;
+	interrupts = <27>;
+	bus-width = <8>;
+	clk-delay-cycles = <31>;
+	non-removable;
+};
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index dbb75bf..b4b1c1d 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -28,6 +28,9 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_data/pxa_sdhci.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
@@ -121,6 +124,48 @@ static struct sdhci_ops pxav2_sdhci_ops = {
 	.platform_8bit_width = pxav2_mmc_set_width,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id sdhci_pxav2_of_match[] = {
+	{
+		.compatible = "mrvl,pxav2-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
+
+static struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device *dev)
+{
+	struct sdhci_pxa_platdata *pdata;
+	struct device_node *np = dev->of_node;
+	u32 bus_width;
+	u32 clk_delay_cycles;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	if (of_find_property(np, "non-removable", NULL))
+		pdata->flags |= PXA_FLAG_CARD_PERMANENT;
+
+	of_property_read_u32(np, "bus-width", &bus_width);
+	if (bus_width == 8)
+		pdata->flags |= PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;
+
+	of_property_read_u32(np, "clk-delay-cycles", &clk_delay_cycles);
+	if (clk_delay_cycles > 0) {
+		pdata->clk_delay_sel = 1;
+		pdata->clk_delay_cycles = clk_delay_cycles;
+	}
+
+	return pdata;
+}
+#else
+static inline struct sdhci_pxa_platdata pxav2_get_mmc_pdata(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -128,6 +173,8 @@ static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
+	const struct of_device_id *match;
+
 	int ret;
 	struct clk *clk;
 
@@ -156,6 +203,10 @@ static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 
+	match = of_match_device(of_match_ptr(sdhci_pxav2_of_match), &pdev->dev);
+	if (match) {
+		pdata = pxav2_get_mmc_pdata(dev);
+	}
 	if (pdata) {
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
 			/* on-chip device */
@@ -218,6 +269,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav2",
 		.owner	= THIS_MODULE,
+		.of_match_table = sdhci_pxav2_of_match,
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_pxav2_probe,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f296956..1835c94 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -28,6 +28,9 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
@@ -164,6 +167,46 @@ static struct sdhci_ops pxav3_sdhci_ops = {
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id sdhci_pxav3_of_match[] = {
+	{
+		.compatible = "mrvl,pxav3-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_pxav3_of_match);
+
+static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
+{
+	struct sdhci_pxa_platdata *pdata;
+	struct device_node *np = dev->of_node;
+	u32 bus_width;
+	u32 clk_delay_cycles;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	if (of_find_property(np, "non-removable", NULL))
+		pdata->flags |= PXA_FLAG_CARD_PERMANENT;
+
+	of_property_read_u32(np, "bus-width", &bus_width);
+	if (bus_width == 8)
+		pdata->flags |= PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;
+
+	of_property_read_u32(np, "clk-delay-cycles", &clk_delay_cycles);
+	if (clk_delay_cycles > 0)
+		pdata->clk_delay_cycles = clk_delay_cycles;
+
+	return pdata;
+}
+#else
+static inline struct sdhci_pxa_platdata pxav3_get_mmc_pdata(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -171,6 +214,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
+	const struct of_device_id *match;
+
 	int ret;
 	struct clk *clk;
 
@@ -202,6 +247,10 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
+	if (match)
+		pdata = pxav3_get_mmc_pdata(dev);
+
 	if (pdata) {
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
 			/* on-chip device */
@@ -263,6 +312,7 @@ static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
 static struct platform_driver sdhci_pxav3_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav3",
+		.of_match_table = sdhci_pxav3_of_match,
 		.owner	= THIS_MODULE,
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
