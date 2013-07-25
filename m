From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 03/12] sh: ecovec24: Use MMC/SDHI CD and RO GPIO
Date: Fri, 26 Jul 2013 01:26:39 +0200
Message-ID: <1374794808-21890-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Pass the CD and RO GPIO numbers to the MMC SPI and SDHI drivers and
remove the custom .get_cd() and .get_ro() callback functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 42 +++++++-----------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bcbb86b..4d46700 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -620,18 +620,14 @@ static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PTB6, state);
 }
 
-static int sdhi0_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(GPIO_PTY7);
-}
-
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr	= sdhi0_set_pwr,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= sdhi0_get_cd,
+	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
+	.cd_gpio	= GPIO_PTY7,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -678,18 +674,14 @@ static void cn12_set_pwr(struct platform_device *pdev, int state)
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
-static int sdhi1_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(GPIO_PTW7);
-}
-
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
+	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
+	.cd_gpio	= GPIO_PTW7,
 	.set_pwr	= cn12_set_pwr,
-	.get_cd		= sdhi1_get_cd,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -719,27 +711,19 @@ static struct platform_device sdhi1_device = {
 #else
 
 /* MMC SPI */
-static int mmc_spi_get_ro(struct device *dev)
-{
-	return gpio_get_value(GPIO_PTY6);
-}
-
-static int mmc_spi_get_cd(struct device *dev)
-{
-	return !gpio_get_value(GPIO_PTY7);
-}
-
 static void mmc_spi_setpower(struct device *dev, unsigned int maskval)
 {
 	gpio_set_value(GPIO_PTB6, maskval ? 1 : 0);
 }
 
 static struct mmc_spi_platform_data mmc_spi_info = {
-	.get_ro = mmc_spi_get_ro,
-	.get_cd = mmc_spi_get_cd,
 	.caps = MMC_CAP_NEEDS_POLL,
+	.caps2 = MMC_CAP2_RO_ACTIVE_HIGH,
 	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34, /* 3.3V only */
 	.setpower = mmc_spi_setpower,
+	.flags = MMC_SPI_USE_CD_GPIO | MMC_SPI_USE_RO_GPIO,
+	.cd_gpio = GPIO_PTY7,
+	.ro_gpio = GPIO_PTY6,
 };
 
 static struct spi_board_info spi_bus[] = {
@@ -1342,10 +1326,6 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR6);
 
 	/* SD-card slot CN11 */
-	/* Card-detect, used on CN11, either with SDHI0 or with SPI */
-	gpio_request(GPIO_PTY7, NULL);
-	gpio_direction_input(GPIO_PTY7);
-
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
@@ -1364,8 +1344,6 @@ static int __init arch_setup(void)
 	gpio_direction_output(GPIO_PTM4, 1); /* active low CS */
 	gpio_request(GPIO_PTB6, NULL); /* 3.3V power control */
 	gpio_direction_output(GPIO_PTB6, 0); /* disable power by default */
-	gpio_request(GPIO_PTY6, NULL); /* write protect */
-	gpio_direction_input(GPIO_PTY6);
 
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 #endif
@@ -1395,10 +1373,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
 
-	/* Card-detect, used on CN12 with SDHI1 */
-	gpio_request(GPIO_PTW7, NULL);
-	gpio_direction_input(GPIO_PTW7);
-
 	cn12_enabled = true;
 #endif
 
-- 
1.8.1.5

