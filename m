From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] sh: ecovec: switch SDHI controllers to card polling
Date: Sat, 28 Jan 2012 19:36:24 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201281929450.27970@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Polling for card hotplug events is a better option than using SDHI native
hotplug interrupt, because the latter option forces the controller to stay
permanently powered up and enabled.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

It is a kind of an RFC. We do in general prefer SDHI polling to SDHI 
native hotplug detection for the above reason, but there might well be 
other reasons, why this is not a good idea in this specific case. If there 
are such, I'd love to hear about them.

 arch/sh/boards/mach-ecovec24/setup.c |  104 ++++++++++++++++++++-------------
 1 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 033ef2b..c8d1bbd 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -522,11 +522,18 @@ static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PTB6, state);
 }
 
+static int sdhi0_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(GPIO_PTY7);
+}
+
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr	= sdhi0_set_pwr,
-	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
+			  MMC_CAP_NEEDS_POLL,
+	.get_cd		= sdhi0_get_cd,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -559,11 +566,18 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 	gpio_set_value(GPIO_PTB7, state);
 }
 
+static int sdhi1_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(GPIO_PTW7);
+}
+
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
+			  MMC_CAP_NEEDS_POLL,
 	.set_pwr	= sdhi1_set_pwr,
+	.get_cd		= sdhi1_get_cd,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -999,6 +1013,7 @@ extern char ecovec24_sdram_leave_end;
 static int __init arch_setup(void)
 {
 	struct clk *clk;
+	bool cn12_enabled = false;
 
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
@@ -1199,9 +1214,13 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
+	/* SD-card slot CN11 */
+	/* Card-detect, used on CN11, either with SDHI0 or with SPI */
+	gpio_request(GPIO_PTY7, NULL);
+	gpio_direction_input(GPIO_PTY7);
+
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
-	gpio_request(GPIO_FN_SDHI0CD,  NULL);
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
 	gpio_request(GPIO_FN_SDHI0CMD, NULL);
 	gpio_request(GPIO_FN_SDHI0CLK, NULL);
@@ -1211,23 +1230,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
 	gpio_request(GPIO_PTB6, NULL);
 	gpio_direction_output(GPIO_PTB6, 0);
-
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
-	gpio_request(GPIO_FN_SDHI1CD,  NULL);
-	gpio_request(GPIO_FN_SDHI1WP,  NULL);
-	gpio_request(GPIO_FN_SDHI1CMD, NULL);
-	gpio_request(GPIO_FN_SDHI1CLK, NULL);
-	gpio_request(GPIO_FN_SDHI1D3,  NULL);
-	gpio_request(GPIO_FN_SDHI1D2,  NULL);
-	gpio_request(GPIO_FN_SDHI1D1,  NULL);
-	gpio_request(GPIO_FN_SDHI1D0,  NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
-
-	/* I/O buffer drive ability is high for SDHI1 */
-	__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
-#endif /* CONFIG_MMC_SH_MMCIF */
 #else
 	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
 	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
@@ -1239,12 +1241,51 @@ static int __init arch_setup(void)
 	gpio_direction_output(GPIO_PTB6, 0); /* disable power by default */
 	gpio_request(GPIO_PTY6, NULL); /* write protect */
 	gpio_direction_input(GPIO_PTY6);
-	gpio_request(GPIO_PTY7, NULL); /* card detect */
-	gpio_direction_input(GPIO_PTY7);
 
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 #endif
 
+	/* MMC/SD-card slot CN12 */
+#if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
+	/* enable MMCIF (needs DS2.6,7 set to OFF,ON) */
+	gpio_request(GPIO_FN_MMC_D7, NULL);
+	gpio_request(GPIO_FN_MMC_D6, NULL);
+	gpio_request(GPIO_FN_MMC_D5, NULL);
+	gpio_request(GPIO_FN_MMC_D4, NULL);
+	gpio_request(GPIO_FN_MMC_D3, NULL);
+	gpio_request(GPIO_FN_MMC_D2, NULL);
+	gpio_request(GPIO_FN_MMC_D1, NULL);
+	gpio_request(GPIO_FN_MMC_D0, NULL);
+	gpio_request(GPIO_FN_MMC_CLK, NULL);
+	gpio_request(GPIO_FN_MMC_CMD, NULL);
+	gpio_request(GPIO_PTB7, NULL);
+	gpio_direction_output(GPIO_PTB7, 0);
+
+	cn12_enabled = true;
+#elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
+	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
+	gpio_request(GPIO_FN_SDHI1WP,  NULL);
+	gpio_request(GPIO_FN_SDHI1CMD, NULL);
+	gpio_request(GPIO_FN_SDHI1CLK, NULL);
+	gpio_request(GPIO_FN_SDHI1D3,  NULL);
+	gpio_request(GPIO_FN_SDHI1D2,  NULL);
+	gpio_request(GPIO_FN_SDHI1D1,  NULL);
+	gpio_request(GPIO_FN_SDHI1D0,  NULL);
+	gpio_request(GPIO_PTB7, NULL);
+	gpio_direction_output(GPIO_PTB7, 0);
+
+	/* Card-detect, used on CN12 with SDHI1 */
+	gpio_request(GPIO_PTW7, NULL);
+	gpio_direction_input(GPIO_PTW7);
+
+	cn12_enabled = true;
+#endif
+
+	if (cn12_enabled)
+		/* I/O buffer drive ability is high for CN12 */
+		__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000,
+			     IODRIVEA);
+
 	/* enable Video */
 	gpio_request(GPIO_PTU2, NULL);
 	gpio_direction_output(GPIO_PTU2, 1);
@@ -1303,25 +1344,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_PTU5, NULL);
 	gpio_direction_output(GPIO_PTU5, 0);
 
-#if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	/* enable MMCIF (needs DS2.6,7 set to OFF,ON) */
-	gpio_request(GPIO_FN_MMC_D7, NULL);
-	gpio_request(GPIO_FN_MMC_D6, NULL);
-	gpio_request(GPIO_FN_MMC_D5, NULL);
-	gpio_request(GPIO_FN_MMC_D4, NULL);
-	gpio_request(GPIO_FN_MMC_D3, NULL);
-	gpio_request(GPIO_FN_MMC_D2, NULL);
-	gpio_request(GPIO_FN_MMC_D1, NULL);
-	gpio_request(GPIO_FN_MMC_D0, NULL);
-	gpio_request(GPIO_FN_MMC_CLK, NULL);
-	gpio_request(GPIO_FN_MMC_CMD, NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
-
-	/* I/O buffer drive ability is high for MMCIF */
-	__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
-#endif
-
 	/* enable I2C device */
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
-- 
1.7.2.5

