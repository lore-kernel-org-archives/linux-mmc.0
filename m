From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 1/3] mmc: sdhci-of-esdhc: convert to use esdhc_get_property()
Date: Thu, 27 Aug 2015 17:28:43 +0800
Message-ID: <1440667723-25376-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:2752
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750982AbbH0Je1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Aug 2015 05:34:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Move getting property code from sdhci_esdhc_probe() into
esdhc_get_property().

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- get SVR from GUTS block instead of dts
---
 drivers/mmc/host/sdhci-of-esdhc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 653f335..e26e7b3 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -354,19 +354,17 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static int sdhci_esdhc_probe(struct platform_device *pdev)
+static void esdhc_get_property(struct platform_device *pdev)
 {
-	struct sdhci_host *host;
-	struct device_node *np;
-	int ret;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 
 	sdhci_get_of_property(pdev);
 
-	np = pdev->dev.of_node;
+	/* call to generic mmc_of_parse to support additional capabilities */
+	mmc_of_parse(host->mmc);
+	mmc_of_parse_voltage(np, &host->ocr_mask);
+
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
@@ -381,13 +379,18 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		 */
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
+}
 
-	/* call to generic mmc_of_parse to support additional capabilities */
-	ret = mmc_of_parse(host->mmc);
-	if (ret)
-		goto err;
+static int sdhci_esdhc_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	int ret;
 
-	mmc_of_parse_voltage(np, &host->ocr_mask);
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	esdhc_get_property(pdev);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
2.1.0.27.g96db324

