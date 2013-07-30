From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 03/13] ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
Date: Tue, 30 Jul 2013 12:37:27 +0200
Message-ID: <1375180657-23641-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Pass the CD and RO GPIO numbers to the MMC SPI driver and remove the
custom .get_cd() and .get_ro() callback functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-ep93xx/vision_ep9307.c | 57 ++++--------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 605956f..5a4c06d 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -224,62 +224,15 @@ static struct ep93xx_spi_chip_ops vision_spi_flash_hw = {
 #define VISION_SPI_MMC_WP	EP93XX_GPIO_LINE_F(0)
 #define VISION_SPI_MMC_CD	EP93XX_GPIO_LINE_EGPIO15
 
-static struct gpio vision_spi_mmc_gpios[] = {
-	{ VISION_SPI_MMC_WP, GPIOF_DIR_IN, "mmc_spi:wp" },
-	{ VISION_SPI_MMC_CD, GPIOF_DIR_IN, "mmc_spi:cd" },
-};
-
-static int vision_spi_mmc_init(struct device *pdev,
-			irqreturn_t (*func)(int, void *), void *pdata)
-{
-	int err;
-
-	err = gpio_request_array(vision_spi_mmc_gpios,
-				 ARRAY_SIZE(vision_spi_mmc_gpios));
-	if (err)
-		return err;
-
-	err = gpio_set_debounce(VISION_SPI_MMC_CD, 1);
-	if (err)
-		goto exit_err;
-
-	err = request_irq(gpio_to_irq(VISION_SPI_MMC_CD), func,
-			IRQ_TYPE_EDGE_BOTH, "mmc_spi:cd", pdata);
-	if (err)
-		goto exit_err;
-
-	return 0;
-
-exit_err:
-	gpio_free_array(vision_spi_mmc_gpios, ARRAY_SIZE(vision_spi_mmc_gpios));
-	return err;
-
-}
-
-static void vision_spi_mmc_exit(struct device *pdev, void *pdata)
-{
-	free_irq(gpio_to_irq(VISION_SPI_MMC_CD), pdata);
-	gpio_free_array(vision_spi_mmc_gpios, ARRAY_SIZE(vision_spi_mmc_gpios));
-}
-
-static int vision_spi_mmc_get_ro(struct device *pdev)
-{
-	return !!gpio_get_value(VISION_SPI_MMC_WP);
-}
-
-static int vision_spi_mmc_get_cd(struct device *pdev)
-{
-	return !gpio_get_value(VISION_SPI_MMC_CD);
-}
-
 static struct mmc_spi_platform_data vision_spi_mmc_data = {
-	.init		= vision_spi_mmc_init,
-	.exit		= vision_spi_mmc_exit,
-	.get_ro		= vision_spi_mmc_get_ro,
-	.get_cd		= vision_spi_mmc_get_cd,
 	.detect_delay	= 100,
 	.powerup_msecs	= 100,
 	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.flags		= MMC_SPI_USE_CD_GPIO | MMC_SPI_USE_RO_GPIO,
+	.cd_gpio	= VISION_SPI_MMC_CD,
+	.cd_debounce	= 1,
+	.ro_gpio	= VISION_SPI_MMC_WP,
+	.caps2		= MMC_CAP2_RO_ACTIVE_HIGH,
 };
 
 static int vision_spi_mmc_hw_setup(struct spi_device *spi)
-- 
1.8.1.5

