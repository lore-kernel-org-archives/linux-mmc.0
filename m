From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/7] sh: ecovec: switch MMC power control to regulators
Date: Tue, 24 Apr 2012 18:41:47 +0200
Message-ID: <1335285707-22707-8-git-send-email-g.liakhovetski@gmx.de>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55536 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab2DXQlx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:41:53 -0400
In-Reply-To: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>

Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
which makes it possible to use the fixed voltage regulator driver to switch
card power on and off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   85 ++++++++++++++++++++++++---------
 1 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a2f70e6..0822931 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -19,6 +19,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/i2c.h>
@@ -515,12 +518,66 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
+static struct regulator_consumer_supply cn12_power_consumers[] =
+{
+	REGULATOR_SUPPLY("MMC Vdd", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("SD Vdd", "sh_mobile_sdhi.1"),
+};
+
+static struct regulator_init_data cn12_power_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(cn12_power_consumers),
+	.consumer_supplies      = cn12_power_consumers,
+};
+
+static struct fixed_voltage_config cn12_power_info = {
+	.supply_name = "CN12 SD/MMC Vdd",
+	.microvolts = 3300000,
+	.gpio = GPIO_PTB7,
+	.enable_high = 1,
+	.init_data = &cn12_power_init_data,
+};
+
+static struct platform_device cn12_power = {
+	.name = "reg-fixed-voltage",
+	.id   = 0,
+	.dev  = {
+		.platform_data = &cn12_power_info,
+	},
+};
+
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 /* SDHI0 */
-static void sdhi0_set_pwr(struct platform_device *pdev, int state)
+static struct regulator_consumer_supply sdhi0_power_consumers[] =
 {
-	gpio_set_value(GPIO_PTB6, state);
-}
+	REGULATOR_SUPPLY("SD Vdd", "sh_mobile_sdhi.0"),
+};
+
+static struct regulator_init_data sdhi0_power_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(sdhi0_power_consumers),
+	.consumer_supplies      = sdhi0_power_consumers,
+};
+
+static struct fixed_voltage_config sdhi0_power_info = {
+	.supply_name = "CN11 SD/MMC Vdd",
+	.microvolts = 3300000,
+	.gpio = GPIO_PTB6,
+	.enable_high = 1,
+	.init_data = &sdhi0_power_init_data,
+};
+
+static struct platform_device sdhi0_power = {
+	.name = "reg-fixed-voltage",
+	.id   = 1,
+	.dev  = {
+		.platform_data = &sdhi0_power_info,
+	},
+};
 
 static int sdhi0_get_cd(struct platform_device *pdev)
 {
@@ -530,7 +587,6 @@ static int sdhi0_get_cd(struct platform_device *pdev)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.set_pwr	= sdhi0_set_pwr,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= sdhi0_get_cd,
@@ -561,11 +617,6 @@ static struct platform_device sdhi0_device = {
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
-static void sdhi1_set_pwr(struct platform_device *pdev, int state)
-{
-	gpio_set_value(GPIO_PTB7, state);
-}
-
 static int sdhi1_get_cd(struct platform_device *pdev)
 {
 	return !gpio_get_value(GPIO_PTW7);
@@ -576,7 +627,6 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
-	.set_pwr	= sdhi1_set_pwr,
 	.get_cd		= sdhi1_get_cd,
 };
 
@@ -872,11 +922,6 @@ static struct platform_device vou_device = {
 
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SH_MMCIF */
-static void mmcif_set_pwr(struct platform_device *pdev, int state)
-{
-	gpio_set_value(GPIO_PTB7, state);
-}
-
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "SH_MMCIF",
@@ -897,12 +942,10 @@ static struct resource sh_mmcif_resources[] = {
 };
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
-	.set_pwr	= mmcif_set_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
-	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
 };
 
 static struct platform_device sh_mmcif_device = {
@@ -927,7 +970,9 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
+	&cn12_power,
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
+	&sdhi0_power,
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
@@ -1224,8 +1269,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D2,  NULL);
 	gpio_request(GPIO_FN_SDHI0D1,  NULL);
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
-	gpio_request(GPIO_PTB6, NULL);
-	gpio_direction_output(GPIO_PTB6, 0);
 #else
 	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
 	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
@@ -1254,8 +1297,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MMC_D0, NULL);
 	gpio_request(GPIO_FN_MMC_CLK, NULL);
 	gpio_request(GPIO_FN_MMC_CMD, NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
 
 	cn12_enabled = true;
 #elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
@@ -1267,8 +1308,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D2,  NULL);
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
 
 	/* Card-detect, used on CN12 with SDHI1 */
 	gpio_request(GPIO_PTW7, NULL);
-- 
1.7.2.5

