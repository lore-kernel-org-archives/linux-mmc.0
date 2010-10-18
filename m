From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 2/2] arm: mach-mx3: pcm043: add write-protect-pin for SDHC
Date: Mon, 18 Oct 2010 13:57:57 +0200
Message-ID: <1287403077-519-2-git-send-email-w.sang@pengutronix.de>
References: <1287403077-519-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42661 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0JRL6H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 07:58:07 -0400
In-Reply-To: <1287403077-519-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index ddb0c5c..f5a9aa7 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -43,6 +43,7 @@
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
 #include <mach/ssi.h>
+#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -224,12 +225,15 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
 	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
+	MX35_PAD_ATA_DATA10__GPIO2_23, /* WriteProtect */
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
 #define AC97_GPIO_TXD	(1 * 32 + 28)
 #define AC97_GPIO_RESET	(1 * 32 + 0)
 
+#define SD1_GPIO_WP	(1 * 32 + 23)
+
 static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
@@ -312,6 +316,10 @@ pcm037_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.wp_gpio = SD1_GPIO_WP,
+};
+
 #if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
@@ -396,7 +404,7 @@ static void __init mxc_board_init(void)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 
 	imx35_add_flexcan1(NULL);
-	imx35_add_esdhc0(NULL);
+	imx35_add_esdhc0(&sd1_pdata);
 }
 
 static void __init pcm043_timer_init(void)
-- 
1.7.1

