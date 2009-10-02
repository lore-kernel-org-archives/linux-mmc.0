From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/07] sh: SDHI platform data to the AP325RXA board
Date: Fri, 02 Oct 2009 11:22:56 +0900
Message-ID: <20091002022256.8215.49366.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbZJBC1a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:27:30 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

Convert the AP325 board to use sh_mobile_sdhi for the
SD Card connected to CN3 instead of mmc_spi.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/board-ap325rxa.c |   52 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-10-02 09:44:21.000000000 +0900
@@ -20,8 +20,6 @@
 #include <linux/i2c.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_gpio.h>
 #include <media/ov772x.h>
 #include <media/soc_camera.h>
 #include <media/soc_camera_platform.h>
@@ -409,17 +407,25 @@ static struct platform_device ceu_device
 	},
 };
 
-struct spi_gpio_platform_data sdcard_cn3_platform_data = {
-	.sck = GPIO_PTD0,
-	.mosi = GPIO_PTD1,
-	.miso = GPIO_PTD2,
-	.num_chipselect = 1,
+static struct resource sdhi0_cn3_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start	= 0x04ce0000,
+		.end	= 0x04ce01ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 101,
+		.flags  = IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device sdcard_cn3_device = {
-	.name		= "spi_gpio",
-	.dev	= {
-		.platform_data	= &sdcard_cn3_platform_data,
+static struct platform_device sdhi0_cn3_device = {
+	.name		= "sh_mobile_sdhi",
+	.num_resources	= ARRAY_SIZE(sdhi0_cn3_resources),
+	.resource	= sdhi0_cn3_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI0,
 	},
 };
 
@@ -470,20 +476,11 @@ static struct platform_device *ap325rxa_
 	&lcdc_device,
 	&ceu_device,
 	&nand_flash_device,
-	&sdcard_cn3_device,
+	&sdhi0_cn3_device,
 	&ap325rxa_camera[0],
 	&ap325rxa_camera[1],
 };
 
-static struct spi_board_info ap325rxa_spi_devices[] = {
-	{
-		.modalias = "mmc_spi",
-		.max_speed_hz = 5000000,
-		.chip_select = 0,
-		.controller_data = (void *) GPIO_PTD5,
-	},
-};
-
 static int __init ap325rxa_devices_setup(void)
 {
 	/* LD3 and LD4 LEDs */
@@ -578,12 +575,19 @@ static int __init ap325rxa_devices_setup
 
 	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
 
+	/* SDHI0 */
+	gpio_request(GPIO_FN_SDHI0CD_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0WP_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0D3_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0D2_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0D1_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0D0_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0CMD_PTD, NULL);
+	gpio_request(GPIO_FN_SDHI0CLK_PTD, NULL);
+
 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
 
-	spi_register_board_info(ap325rxa_spi_devices,
-				ARRAY_SIZE(ap325rxa_spi_devices));
-
 	return platform_add_devices(ap325rxa_devices,
 				ARRAY_SIZE(ap325rxa_devices));
 }
