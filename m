From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 3/3] pcm043: add resources for mmc
Date: Mon,  6 Sep 2010 12:34:25 +0200
Message-ID: <1283769265-14147-4-git-send-email-w.sang@pengutronix.de>
References: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51028 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0IFKe4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:34:56 -0400
In-Reply-To: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 28886f0..44278d3 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -28,6 +28,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/fsl_devices.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -139,10 +140,31 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
 };
 #endif
 
+static struct resource sdhci_resources[] = {
+       {
+               .start          = 0x53fb4000,
+               .end            = 0x53fb4000 + 0xff,
+               .flags          = IORESOURCE_MEM,
+       }, {
+               .start          = MX35_INT_MMC_SDHC1,
+               .end            = MX35_INT_MMC_SDHC1,
+               .flags          = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device sdhci_device = {
+       .name           = "sdhci-esdhc",
+       .id             = 0,
+       .num_resources  = ARRAY_SIZE(sdhci_resources),
+       .resource       = sdhci_resources,
+};
+
+
 static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
 	&mxc_fec_device,
 	&imx_wdt_device0,
+	&sdhci_device,
 };
 
 static struct pad_desc pcm043_pads[] = {
@@ -217,6 +239,13 @@ static struct pad_desc pcm043_pads[] = {
 	/* CAN2 */
 	MX35_PAD_TX5_RX0__CAN2_TXCAN,
 	MX35_PAD_TX4_RX1__CAN2_RXCAN,
+	/* esdhc */
+	MX35_PAD_SD1_CMD__ESDHC1_CMD,
+	MX35_PAD_SD1_CLK__ESDHC1_CLK,
+	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
-- 
1.7.1

