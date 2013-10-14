From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 5/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Mon, 14 Oct 2013 16:23:44 +0800
Message-ID: <1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:5403
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab3JNIXU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 04:23:20 -0400
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

We now have 'flags' in struct pltfm_imx_data to identify the features
and quirks for ESDHC variants running on different i.MX SoCs.  The enum
imx_esdhc_type can be eliminated by interpreting the ESDHC variants with
the ESDHC_FLAG_* flags.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   52 +++++-------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f1e1385..f2cd5b0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -100,18 +100,15 @@
  */
 #define ESDHC_FLAG_USDHC		BIT(3)
 
-enum imx_esdhc_type {
-	IMX25_ESDHC,
-	IMX35_ESDHC,
-	IMX51_ESDHC,
-	IMX53_ESDHC,
-	IMX6Q_USDHC,
-};
+#define IMX25_ESDHC	(ESDHC_FLAG_NO_DMAS_BITS | ESDHC_FLAG_ENGCM07207)
+#define IMX35_ESDHC	(ESDHC_FLAG_ENGCM07207)
+#define IMX51_ESDHC	(0)
+#define IMX53_ESDHC	(ESDHC_FLAG_MULTIBLK_NO_INT)
+#define IMX6Q_USDHC	(ESDHC_FLAG_USDHC)
 
 struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
-	enum imx_esdhc_type devtype;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_100mhz;
@@ -154,31 +151,6 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
-static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
-{
-	return data->devtype == IMX25_ESDHC;
-}
-
-static inline int is_imx35_esdhc(struct pltfm_imx_data *data)
-{
-	return data->devtype == IMX35_ESDHC;
-}
-
-static inline int is_imx51_esdhc(struct pltfm_imx_data *data)
-{
-	return data->devtype == IMX51_ESDHC;
-}
-
-static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-{
-	return data->devtype == IMX53_ESDHC;
-}
-
-static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
-{
-	return data->devtype == IMX6Q_USDHC;
-}
-
 static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 {
 	return !!(data->flags & ESDHC_FLAG_USDHC);
@@ -866,19 +838,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto free_sdhci;
 	}
 
-	imx_data->devtype = of_id ? (enum imx_esdhc_type) of_id->data :
+	imx_data->flags = of_id ? (int) of_id->data :
 				    pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
-	if (is_imx25_esdhc(imx_data))
-		imx_data->flags |= ESDHC_FLAG_NO_DMAS_BITS;
-
-	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
-		imx_data->flags |= ESDHC_FLAG_ENGCM07207;
-
-	if (is_imx6q_usdhc(imx_data))
-		imx_data->flags |= ESDHC_FLAG_USDHC;
-
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
@@ -924,9 +887,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (is_imx53_esdhc(imx_data))
-		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
-
 	/*
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
-- 
1.7.9.5


