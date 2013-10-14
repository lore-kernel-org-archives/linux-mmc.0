From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/5] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
Date: Mon, 14 Oct 2013 16:23:41 +0800
Message-ID: <1381739024-24924-3-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:50135
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab3JNIXO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 04:23:14 -0400
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Add flag ESDHC_FLAG_ENGCM07207 for enabling the workaround for errata
ENGcm07207 and set the flag for i.MX25 and i.MX35 ESDHC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e046917..a5d7d15 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -89,6 +89,11 @@
  * exeception. Bit1 of Vendor Spec registor is used to fix it.
  */
 #define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
+/*
+ * The flag enables the workaround for ESDHC errata ENGcm07207 which
+ * presents on i.MX25 and i.MX35.
+ */
+#define ESDHC_FLAG_ENGCM07207		BIT(2)
 
 enum imx_esdhc_type {
 	IMX25_ESDHC,
@@ -865,6 +870,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (is_imx25_esdhc(imx_data))
 		imx_data->flags |= ESDHC_FLAG_NO_DMAS_BITS;
 
+	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
+		imx_data->flags |= ESDHC_FLAG_ENGCM07207;
+
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
@@ -905,7 +913,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
+	if (imx_data->flags & ESDHC_FLAG_ENGCM07207)
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
-- 
1.7.9.5


