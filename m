From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 2/3] mmc: sdhci-of-esdhc: get SOC version and revision from GUTS_SVR
Date: Thu, 27 Aug 2015 17:29:02 +0800
Message-ID: <1440667742-25424-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:22715
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751368AbbH0Jej (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Aug 2015 05:34:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Freescale QorIQ SOCs have the SVR(System version register) containing
the system version number for the device. Sometimes the eSDHC driver
needs to know this information for some errata workaround. So, we read
SVR from the global utilities block of the chip.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index e26e7b3..20e0b9a 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -24,6 +25,16 @@
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
+
+/* Global Utility Registers */
+#define GUTS_SVR		0xa4	/* System Version Register */
+/* SOC version definition */
+#define SVR_T4240		0x824000
+/* SOC version */
+static u32 soc_ver;
+/* SOC revision */
+static u8 soc_rev;
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
@@ -354,10 +365,26 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
+/*
+ * Table for matching compatible strings, for device tree
+ * guts node, for Freescale QorIQ SOCs.
+ * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
+ * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
+ * string would be used.
+ */
+static const struct of_device_id guts_device_ids[] = {
+	{ .compatible = "fsl,qoriq-device-config-1.0", },
+	{ .compatible = "fsl,qoriq-device-config-2.0", },
+	{}
+};
+
 static void esdhc_get_property(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *guts_node;
+	void __iomem *guts_base;
+	u32 svr;
 
 	sdhci_get_of_property(pdev);
 
@@ -365,6 +392,19 @@ static void esdhc_get_property(struct platform_device *pdev)
 	mmc_of_parse(host->mmc);
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
+	/* Get SVR */
+	guts_node = of_find_matching_node(NULL, guts_device_ids);
+	if (guts_node) {
+		guts_base = of_iomap(guts_node, 0);
+		of_node_put(guts_node);
+		if (guts_base) {
+			svr = in_be32(guts_base + GUTS_SVR);
+			soc_ver = (svr >> 8) & 0xfff7ff;
+			soc_rev = svr & 0xff;
+			iounmap(guts_base);
+		}
+	}
+
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
-- 
2.1.0.27.g96db324

