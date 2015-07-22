From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 09/11] mmc: sdhci-esdhc-imx: remove duplicated dts parsing
Date: Wed, 22 Jul 2015 20:53:08 +0800
Message-ID: <1437569590-5228-10-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0141.outbound.protection.outlook.com ([65.55.169.141]:53906
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965133AbbGVODr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:03:47 -0400
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

After commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()"),
we do not need those duplicated parsing anymore.

Note: fsl,cd-controller is also deleted due to the driver does
not support controller card detection anymore after switch to runtime pm.
And there's no user of it right now in device tree.

wp-gpios is kept because we're still support fsl,wp-controller,
so we need a way to check if it's gpio wp or controller wp.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 10f03ee..1b0e618 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -884,27 +884,13 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	int ret;
 
-	if (of_get_property(np, "non-removable", NULL))
-		boarddata->cd_type = ESDHC_CD_PERMANENT;
-
-	if (of_get_property(np, "fsl,cd-controller", NULL))
-		boarddata->cd_type = ESDHC_CD_CONTROLLER;
-
 	if (of_get_property(np, "fsl,wp-controller", NULL))
 		boarddata->wp_type = ESDHC_WP_CONTROLLER;
 
-	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
-	if (gpio_is_valid(boarddata->cd_gpio))
-		boarddata->cd_type = ESDHC_CD_GPIO;
-
 	boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
 	if (gpio_is_valid(boarddata->wp_gpio))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
-	of_property_read_u32(np, "bus-width", &boarddata->max_bus_width);
-
-	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
-
 	if (of_find_property(np, "no-1-8-v", NULL))
 		boarddata->support_vsel = false;
 	else
-- 
1.9.1

