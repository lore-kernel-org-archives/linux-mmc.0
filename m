From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/2] mmc: sdhci-esdhc: OR mmc->caps with platform data caps
Date: Fri,  1 Jul 2011 16:13:39 -0700
Message-ID: <1309562019-32707-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1309562019-32707-1-git-send-email-troy.kisky@boundarydevices.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:53966 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757921Ab1GAXNr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 19:13:47 -0400
In-Reply-To: <1309562019-32707-1-git-send-email-troy.kisky@boundarydevices.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de
Cc: Hong-Xing.Zhu@freescale.com, cjb@laptop.org, linux-mmc@vger.kernel.org, Troy Kisky <troy.kisky@boundarydevices.com>

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/plat-mxc/include/mach/esdhc.h |    5 +++++
 drivers/mmc/host/sdhci-esdhc-imx.c     |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index 86003f4..9c0dd1d 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -22,5 +22,10 @@
 struct esdhc_platform_data {
 	unsigned int wp_gpio;
 	unsigned int cd_gpio;
+	/*
+	 * 4/8 wires and any additional host
+	 * capabilities OR'd
+	 */
+	u32	caps;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ad53041..c42ba83 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -261,6 +261,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 			imx_data->cd_gpio = boarddata->cd_gpio;
 		if (gpio_is_valid(boarddata->wp_gpio))
 			imx_data->wp_gpio = boarddata->wp_gpio;
+		host->mmc->caps |= boarddata->caps;
 	}
 	if (imx_data->wp_gpio != -EINVAL) {
 		err = gpio_request_one(imx_data->wp_gpio, GPIOF_IN, "ESDHC_WP");
-- 
1.7.0.4

