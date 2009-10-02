From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/07] sh: SDHI platform data to the Migo-R board
Date: Fri, 02 Oct 2009 11:22:43 +0900
Message-ID: <20091002022243.8215.7784.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbZJBC1S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:27:18 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

From: Magnus Damm <damm@opensource.se>

Convert the Migo-R board to use sh_mobile_sdhi for the
SD Card connected to CN9 instead of mmc_spi.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-migor/setup.c |   52 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-10-02 09:41:19.000000000 +0900
@@ -18,8 +18,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_gpio.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/ov772x.h>
@@ -390,17 +388,25 @@ static struct platform_device migor_ceu_
 	},
 };
 
-struct spi_gpio_platform_data sdcard_cn9_platform_data = {
-	.sck = GPIO_PTD0,
-	.mosi = GPIO_PTD1,
-	.miso = GPIO_PTD2,
-	.num_chipselect = 1,
+static struct resource sdhi_cn9_resources[] = {
+	[0] = {
+		.name	= "SDHI",
+		.start	= 0x04ce0000,
+		.end	= 0x04ce01ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 101,
+		.flags  = IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device sdcard_cn9_device = {
-	.name		= "spi_gpio",
-	.dev	= {
-		.platform_data	= &sdcard_cn9_platform_data,
+static struct platform_device sdhi_cn9_device = {
+	.name		= "sh_mobile_sdhi",
+	.num_resources	= ARRAY_SIZE(sdhi_cn9_resources),
+	.resource	= sdhi_cn9_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI,
 	},
 };
 
@@ -467,20 +473,11 @@ static struct platform_device *migor_dev
 	&migor_ceu_device,
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
-	&sdcard_cn9_device,
+	&sdhi_cn9_device,
 	&migor_camera[0],
 	&migor_camera[1],
 };
 
-static struct spi_board_info migor_spi_devices[] = {
-	{
-		.modalias = "mmc_spi",
-		.max_speed_hz = 5000000,
-		.chip_select = 0,
-		.controller_data = (void *) GPIO_PTD5,
-	},
-};
-
 static int __init migor_devices_setup(void)
 {
 
@@ -525,6 +522,16 @@ static int __init migor_devices_setup(vo
 	gpio_request(GPIO_PTA1, NULL);
 	gpio_direction_input(GPIO_PTA1);
 
+	/* SDHI */
+	gpio_request(GPIO_FN_SDHICD, NULL);
+	gpio_request(GPIO_FN_SDHIWP, NULL);
+	gpio_request(GPIO_FN_SDHID3, NULL);
+	gpio_request(GPIO_FN_SDHID2, NULL);
+	gpio_request(GPIO_FN_SDHID1, NULL);
+	gpio_request(GPIO_FN_SDHID0, NULL);
+	gpio_request(GPIO_FN_SDHICMD, NULL);
+	gpio_request(GPIO_FN_SDHICLK, NULL);
+
 	/* Touch Panel */
 	gpio_request(GPIO_FN_IRQ6, NULL);
 
@@ -612,9 +619,6 @@ static int __init migor_devices_setup(vo
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
 
-	spi_register_board_info(migor_spi_devices,
-				ARRAY_SIZE(migor_spi_devices));
-
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
 arch_initcall(migor_devices_setup);
