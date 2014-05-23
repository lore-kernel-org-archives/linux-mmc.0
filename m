From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/5] mmc: sdhci-esdhc-imx: introduce function for parsing platform_data
Date: Fri, 23 May 2014 14:33:01 +0200
Message-ID: <1400848384-3226-3-git-send-email-s.hauer@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43512 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaEWMdQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 08:33:16 -0400
In-Reply-To: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

As a first step to separate the platform_data code from the
devicetree code add a function to parse the boarddata. Also
change the argument of the dt probe function from
struct esdhc_platform_data * to struct pltfm_imx_data *imx_data
which makes it possible to get struct esdhc_platform_data out
of the devicetree probing path.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d530820..f6f7a45 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -901,8 +901,9 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 #ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct esdhc_platform_data *boarddata)
+			 struct pltfm_imx_data *imx_data)
 {
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	struct device_node *np = pdev->dev.of_node;
 
 	if (!np)
@@ -942,12 +943,28 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 #else
 static inline int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct esdhc_platform_data *boarddata)
+			 struct pltfm_imx_data *imx_data)
 {
 	return -ENODEV;
 }
 #endif
 
+static int
+sdhci_esdhc_imx_probe_boarddata(struct platform_device *pdev,
+			 struct pltfm_imx_data *imx_data)
+{
+	struct esdhc_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no boarddata\n");
+		return -EINVAL;
+	}
+
+	imx_data->boarddata = *pdata;
+
+	return 0;
+}
+
 static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -1037,14 +1054,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			host->ioaddr + ESDHC_TUNING_CTRL);
 
 	boarddata = &imx_data->boarddata;
-	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
-		if (!host->mmc->parent->platform_data) {
-			dev_err(mmc_dev(host->mmc), "no board data!\n");
-			err = -EINVAL;
+	if (sdhci_esdhc_imx_probe_dt(pdev, imx_data) < 0) {
+		err = sdhci_esdhc_imx_probe_boarddata(pdev, imx_data);
+		if (err)
 			goto disable_clk;
-		}
-		imx_data->boarddata = *((struct esdhc_platform_data *)
-					host->mmc->parent->platform_data);
 	}
 
 	imx_data->f_max = clk_get_rate(imx_data->clk_per);
-- 
2.0.0.rc0

