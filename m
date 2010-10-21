From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 1/2] Add the GPIO write protection solution to esdhc device on MX51 BBG
Date: Thu, 21 Oct 2010 10:46:17 +0800
Message-ID: <1287629177-17181-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:2826 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042Ab0JUCla (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2010 22:41:30 -0400
Received: from mail150-tx2 (localhost.localdomain [127.0.0.1])	by
 mail150-tx2-R.bigfish.com (Postfix) with ESMTP id 8E58F9582AD	for
 <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2010 02:41:26 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.240])	by
 mail150-tx2.bigfish.com (Postfix) with ESMTP id 60C4D1760052	for
 <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2010 02:41:25 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o9L2fMVV006222	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 19:41:23 -0700 (MST)
Received: from shlinux1.ap.freescale.net
 (R62363-04-010192225216.ap.freescale.net [10.192.225.216])	by
 de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o9L2ujKV015250	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 21:56:46 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric@eukrea.com, w.sang@pengutronix.de, baruch@tkos.co.il
Cc: r65037@freescale.com

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c      |   16 ++++++++++++++--
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    8 +++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 476bfe4..5a69cda 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -34,6 +34,8 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
+#define BABBAGE_SDHCI1_WP	(0*32 + 1)	/* GPIO_1_1 */
+#define BABBAGE_SDHCI2_WP	(0*32 + 5)	/* GPIO_1_5 */
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
 #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
 #define BABBAGE_PHY_RESET (1*32 +5)	/* GPIO_2_5 */
@@ -102,6 +104,7 @@ static struct pad_desc mx51babbage_pads[] = {
 	MX51_PAD_SD1_DATA1__SD1_DATA1,
 	MX51_PAD_SD1_DATA2__SD1_DATA2,
 	MX51_PAD_SD1_DATA3__SD1_DATA3,
+	MX51_PAD_GPIO_1_1__GPIO_1_1,
 
 	/* SD 2 */
 	MX51_PAD_SD2_CMD__SD2_CMD,
@@ -110,6 +113,7 @@ static struct pad_desc mx51babbage_pads[] = {
 	MX51_PAD_SD2_DATA1__SD2_DATA1,
 	MX51_PAD_SD2_DATA2__SD2_DATA2,
 	MX51_PAD_SD2_DATA3__SD2_DATA3,
+	MX51_PAD_GPIO_1_5__GPIO_1_5,
 };
 
 /* Serial ports */
@@ -257,6 +261,14 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+static struct esdhc_platform_data esdhc_imx_pdata1 = {
+	.wp_gpio = BABBAGE_SDHCI1_WP,
+};
+
+static struct esdhc_platform_data esdhc_imx_pdata2 = {
+	.wp_gpio = BABBAGE_SDHCI2_WP,
+};
+
 /*
  * Board specific initialization.
  */
@@ -286,8 +298,8 @@ static void __init mxc_board_init(void)
 	mxc_iomux_v3_setup_pad(&usbh1stp);
 	babbage_usbhub_reset();
 
-	imx51_add_esdhc(0, NULL);
-	imx51_add_esdhc(1, NULL);
+	imx51_add_esdhc(0, &esdhc_imx_pdata1);
+	imx51_add_esdhc(1, &esdhc_imx_pdata2);
 }
 
 static void __init mx51_babbage_timer_init(void)
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 935f790..a3d84ad 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -43,7 +43,7 @@ typedef enum iomux_config {
 #define MX51_USBH1_PAD_CTRL	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | \
 				PAD_CTL_PKE | PAD_CTL_HYS)
-#define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
+#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
 				PAD_CTL_SRE_FAST)
 #define MX51_SDHCI_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
 				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
@@ -310,7 +310,8 @@ typedef enum iomux_config {
 #define MX51_PAD_SD1_DATA3__SD1_DATA3		IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, \
 							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CONFIG_GPIO, 0x0, 0, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD2_CMD__SD2_CMD		IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 1, \
 							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_SD2_CLK__SD2_CLK		IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, \
@@ -331,7 +332,8 @@ typedef enum iomux_config {
 							0x9bc,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, IOMUX_CONFIG_GPIO, 0x0, 1, \
+							MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
-- 
1.6.3.3


