From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] mmc: sdhci-esdhc-imx: support voltage-range property
Date: Tue, 24 Mar 2015 14:45:04 +0100
Message-ID: <1427204704-17569-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39237 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbCXNpI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2015 09:45:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                      | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 9046ba06c47a..415c5575cbf7 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -17,6 +17,10 @@ Optional properties:
   to select a proper data sampling window in case the clock quality is not good
   due to signal path is too long on the board. Please refer to eSDHC/uSDHC
   chapter, DLL (Delay Line) section in RM for details.
+- voltage-ranges : Specify the voltage range in case there are software
+  transparent level shifters on the outputs of the controller. Two cells are
+  required, first cell specifies minimum slot voltage (mV), second cell
+  specifies maximum slot voltage (mV). Several ranges could be specified.
 
 Examples:
 
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 10ef8244a239..a85fb3181ded 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -864,6 +864,7 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 #ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
+			 struct sdhci_host *host,
 			 struct esdhc_platform_data *boarddata)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -900,11 +901,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
+	mmc_of_parse_voltage(np, &host->ocr_mask);
+
 	return 0;
 }
 #else
 static inline int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
+			 struct sdhci_host *host,
 			 struct esdhc_platform_data *boarddata)
 {
 	return -ENODEV;
@@ -999,7 +1003,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			host->ioaddr + ESDHC_TUNING_CTRL);
 
 	boarddata = &imx_data->boarddata;
-	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
+	if (sdhci_esdhc_imx_probe_dt(pdev, host, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
 			dev_err(mmc_dev(host->mmc), "no board data!\n");
 			err = -EINVAL;
-- 
2.1.4

