From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Thu, 7 May 2015 15:00:09 -0300
Message-ID: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0141.outbound.protection.outlook.com ([207.46.100.141]:27567
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751333AbbEGSP3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 14:15:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Since commit 8d86e4fcccf61 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
the 'non-removable' and 'cd-gpios' properties are handled by
mmc_of_parse(), so we can safely remove the pieces of code that still
handles them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8eed843..d7b0a39 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -872,19 +872,12 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	if (of_get_property(np, "non-removable", NULL))
-		boarddata->cd_type = ESDHC_CD_PERMANENT;
-
 	if (of_get_property(np, "fsl,cd-controller", NULL))
 		boarddata->cd_type = ESDHC_CD_CONTROLLER;
 
 	if (of_get_property(np, "fsl,wp-controller", NULL))
 		boarddata->wp_type = ESDHC_WP_CONTROLLER;
 
-	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
-	if (gpio_is_valid(boarddata->cd_gpio))
-		boarddata->cd_type = ESDHC_CD_GPIO;
-
 	boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
 	if (gpio_is_valid(boarddata->wp_gpio))
 		boarddata->wp_type = ESDHC_WP_GPIO;
-- 
1.9.1

