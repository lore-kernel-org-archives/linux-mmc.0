From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3 v3] ARM: mach-shmobile: switch all SDHI instances on
 mackerel to use GPIO CD
Date: Fri, 25 May 2012 17:17:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251709070.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251704490.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56097 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab2EYPRr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:17:47 -0400
In-Reply-To: <Pine.LNX.4.64.1205251704490.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

All 3 SDHI instances on mackerel use GPIOs for card-detection and can be
switched to use the generic GPIO CD helper. SDHI0 card-detect is configured
to produce interrupts, SDHI1 and SDHI2 are polled.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   46 +++++++++++++++----------------
 1 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 5881bb1..45854a9 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1032,15 +1032,6 @@ static struct platform_device nand_flash_device = {
 	},
 };
 
-/*
- * The card detect pin of the top SD/MMC slot (CN7) is active low and is
- * connected to GPIO A22 of SH7372 (GPIO_PORT41).
- */
-static int slot_cn7_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(GPIO_PORT41);
-}
-
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -1084,14 +1075,17 @@ static struct platform_device sdhi0_device = {
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
+
+/* GPIO_PORT41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn7_get_cd,
+	.tmio_caps2	= MMC_CAP2_INVERTED_CD,
+	.cd_gpio	= GPIO_PORT41,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -1129,23 +1123,20 @@ static struct platform_device sdhi1_device = {
 };
 #endif
 
+/* SDHI2 */
+
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
  * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
  */
-static int slot_cn23_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(GPIO_PORT162);
-}
-
-/* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn23_get_cd,
+	.tmio_caps2	= MMC_CAP2_INVERTED_CD,
+	.cd_gpio	= GPIO_PORT162,
 };
 
 static struct resource sdhi2_resources[] = {
@@ -1183,6 +1174,16 @@ static struct platform_device sdhi2_device = {
 };
 
 /* SH_MMCIF */
+
+/*
+ * The card detect pin of the top SD/MMC slot (CN7) is active low and is
+ * connected to GPIO A22 of SH7372 (GPIO_PORT41).
+ */
+static int slot_cn7_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(GPIO_PORT41);
+}
+
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "MMCIF",
@@ -1521,10 +1522,11 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID1_2, NULL);
 	gpio_request(GPIO_FN_SDHID1_1, NULL);
 	gpio_request(GPIO_FN_SDHID1_0, NULL);
-#endif
+#else
 	/* card detect pin for MMC slot (CN7) */
 	gpio_request(GPIO_PORT41, NULL);
 	gpio_direction_input(GPIO_PORT41);
+#endif
 
 	/* enable SDHI2 */
 	gpio_request(GPIO_FN_SDHICMD2, NULL);
@@ -1534,10 +1536,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_1, NULL);
 	gpio_request(GPIO_FN_SDHID2_0, NULL);
 
-	/* card detect pin for microSD slot (CN23) */
-	gpio_request(GPIO_PORT162, NULL);
-	gpio_direction_input(GPIO_PORT162);
-
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
 	gpio_request(GPIO_FN_MMCD0_1, NULL);
-- 
1.7.2.5

