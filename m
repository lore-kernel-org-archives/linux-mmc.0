From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/4] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
Date: Thu, 17 Oct 2013 15:19:44 +0800
Message-ID: <1381994387-9656-2-git-send-email-shawn.guo@linaro.org>
References: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:36509
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863Ab3JQHTS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 03:19:18 -0400
In-Reply-To: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

Just like the use of the flag ESDHC_FLAG_MULTIBLK_NO_INT, let's add
another flag ESDHC_FLAG_ENGCM07207 to enable the workaround for errata
ENGcm07207 and set the flag for i.MX25 and i.MX35 ESDHC.

While at it, let's use BIT() macro for ESDHC_FLAG_MULTIBLK_NO_INT as
well.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..d844be8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -83,7 +83,12 @@
  * As a result, the TC flag is not asserted and SW  received timeout
  * exeception. Bit1 of Vendor Spec registor is used to fix it.
  */
-#define ESDHC_FLAG_MULTIBLK_NO_INT	(1 << 1)
+#define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
+/*
+ * The flag enables the workaround for ESDHC errata ENGcm07207 which
+ * affects i.MX25 and i.MX35.
+ */
+#define ESDHC_FLAG_ENGCM07207		BIT(2)
 
 enum imx_esdhc_type {
 	IMX25_ESDHC,
@@ -857,6 +862,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->devtype = pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
+	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
+		imx_data->flags |= ESDHC_FLAG_ENGCM07207;
+
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
@@ -897,7 +905,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
+	if (imx_data->flags & ESDHC_FLAG_ENGCM07207)
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
-- 
1.7.9.5


