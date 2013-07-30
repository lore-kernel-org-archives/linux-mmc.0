From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 06/13] sh: ecovec24: Remove MMCIF and SDHI .set_pwr() callbacks
Date: Tue, 30 Jul 2013 12:37:30 +0200
Message-ID: <1375180657-23641-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37602 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706Ab3G3Kgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 06:36:50 -0400
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

The MMCIF and SHDI platform data .set_pwr() callbacks are used to
control the vmmc/vqmmc power supplies. As the power supplies already
register control GPIOs there's no need to perform the operation
manually. Remove the callback functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c | 41 ------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index e1b6aa3..60bf82c 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -601,29 +601,9 @@ static struct platform_device sdhi0_power = {
 	},
 };
 
-static void sdhi0_set_pwr(struct platform_device *pdev, int state)
-{
-	static int power_gpio = -EINVAL;
-
-	if (power_gpio < 0) {
-		int ret = gpio_request(GPIO_PTB6, NULL);
-		if (!ret) {
-			power_gpio = GPIO_PTB6;
-			gpio_direction_output(power_gpio, 0);
-		}
-	}
-
-	/*
-	 * Toggle the GPIO regardless, whether we managed to grab it above or
-	 * the fixed regulator driver did.
-	 */
-	gpio_set_value(GPIO_PTB6, state);
-}
-
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.set_pwr	= sdhi0_set_pwr,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
 	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
@@ -653,25 +633,6 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
-static void cn12_set_pwr(struct platform_device *pdev, int state)
-{
-	static int power_gpio = -EINVAL;
-
-	if (power_gpio < 0) {
-		int ret = gpio_request(GPIO_PTB7, NULL);
-		if (!ret) {
-			power_gpio = GPIO_PTB7;
-			gpio_direction_output(power_gpio, 0);
-		}
-	}
-
-	/*
-	 * Toggle the GPIO regardless, whether we managed to grab it above or
-	 * the fixed regulator driver did.
-	 */
-	gpio_set_value(GPIO_PTB7, state);
-}
-
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
@@ -681,7 +642,6 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 			  MMC_CAP_NEEDS_POLL,
 	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
 	.cd_gpio	= GPIO_PTW7,
-	.set_pwr	= cn12_set_pwr,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -1003,7 +963,6 @@ static struct resource sh_mmcif_resources[] = {
 };
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
-	.set_pwr	= cn12_set_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
-- 
1.8.1.5

