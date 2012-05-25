From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3 v3] sh: ecovec: switch MMC power control to regulators
Date: Fri, 25 May 2012 17:45:50 +0200
Message-ID: <1337960752-4944-36-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
which makes it possible to use the fixed voltage regulator driver to switch
card power on and off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c |   85 ++++++++++++++++++++++++---------
 1 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index dbedfda..5ba295d 100644
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
@@ -518,12 +521,66 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
+static struct regulator_consumer_supply cn12_power_consumers[] =
+{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
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
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
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
@@ -533,7 +590,6 @@ static int sdhi0_get_cd(struct platform_device *pdev)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.set_pwr	= sdhi0_set_pwr,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= sdhi0_get_cd,
@@ -564,11 +620,6 @@ static struct platform_device sdhi0_device = {
 
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
@@ -579,7 +630,6 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
 			  MMC_CAP_NEEDS_POLL,
-	.set_pwr	= sdhi1_set_pwr,
 	.get_cd		= sdhi1_get_cd,
 };
 
@@ -899,11 +949,6 @@ static struct platform_device vou_device = {
 
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
@@ -924,12 +969,10 @@ static struct resource sh_mmcif_resources[] = {
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
@@ -954,7 +997,9 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
+	&cn12_power,
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
+	&sdhi0_power,
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
@@ -1252,8 +1297,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D2,  NULL);
 	gpio_request(GPIO_FN_SDHI0D1,  NULL);
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
-	gpio_request(GPIO_PTB6, NULL);
-	gpio_direction_output(GPIO_PTB6, 0);
 #else
 	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
 	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
@@ -1282,8 +1325,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MMC_D0, NULL);
 	gpio_request(GPIO_FN_MMC_CLK, NULL);
 	gpio_request(GPIO_FN_MMC_CMD, NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
 
 	cn12_enabled = true;
 #elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
@@ -1295,8 +1336,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D2,  NULL);
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
 
 	/* Card-detect, used on CN12 with SDHI1 */
 	gpio_request(GPIO_PTW7, NULL);
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
