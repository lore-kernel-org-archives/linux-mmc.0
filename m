From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/5] arm: mach-mx3: pcm043: add write-protect and card-detect for SD1
Date: Thu, 10 Feb 2011 20:14:50 +0100
Message-ID: <1297365291-1038-5-git-send-email-w.sang@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49308 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab1BJTPd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 14:15:33 -0500
In-Reply-To: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index bcf83fc..26b686c 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -40,6 +40,7 @@
 #include <mach/mx3fb.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
+#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -219,12 +220,17 @@ static iomux_v3_cfg_t pcm043_pads[] = {
 	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
 	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
+	MX35_PAD_ATA_DATA10__GPIO2_23, /* WriteProtect */
+	MX35_PAD_ATA_DATA11__GPIO2_24, /* CardDetect */
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
 #define AC97_GPIO_TXD	(1 * 32 + 28)
 #define AC97_GPIO_RESET	(1 * 32 + 0)
 
+#define SD1_GPIO_WP	(1 * 32 + 23)
+#define SD1_GPIO_CD	(1 * 32 + 24)
+
 static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	iomux_v3_cfg_t txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
@@ -307,6 +313,11 @@ pcm037_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.wp_gpio = SD1_GPIO_WP,
+	.cd_gpio = SD1_GPIO_CD,
+};
+
 #if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
@@ -393,7 +404,7 @@ static void __init mxc_board_init(void)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx35_add_flexcan1(NULL);
-	imx35_add_sdhci_esdhc_imx(0, NULL);
+	imx35_add_sdhci_esdhc_imx(0, &sd1_pdata);
 }
 
 static void __init pcm043_timer_init(void)
-- 
1.7.2.3

