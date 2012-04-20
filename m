From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] sh: ecovec: switch MMC power control to regulator
Date: Fri, 20 Apr 2012 18:59:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Power on the CN12 SD/MMC slot on ecovec is controlled by a GPIO, which
makes it possible to use the gpio-regulator driver to produce a primitive
voltage regulator.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

As mentioned in the introductory mail, this patch is mostly an 
implementation example.

 arch/sh/boards/mach-ecovec24/setup.c |   50 +++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a2f70e6..96561ec 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -19,6 +19,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/gpio-regulator.h>
+#include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/i2c.h>
@@ -872,10 +876,45 @@ static struct platform_device vou_device = {
 
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SH_MMCIF */
-static void mmcif_set_pwr(struct platform_device *pdev, int state)
+static struct regulator_consumer_supply mmcif_power_consumers[] =
 {
-	gpio_set_value(GPIO_PTB7, state);
-}
+	REGULATOR_SUPPLY("MMC Vdd", "sh_mmcif.0"),
+};
+
+static struct regulator_init_data mmcif_power_init_data = {
+	.constraints = {
+		.min_uV         = 3300000,
+		.max_uV         = 3300000,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(mmcif_power_consumers),
+	.consumer_supplies      = mmcif_power_consumers,
+};
+
+static struct gpio_regulator_state mmcif_power_states[] = {
+	{ .value = 3300000, .gpios = 0 },
+};
+
+static struct gpio_regulator_config mmcif_power_info = {
+	.supply_name = "CN12 SD/MMC Vdd",
+
+	.enable_gpio = GPIO_PTB7,
+	.enable_high = 1,
+
+	.states = mmcif_power_states,
+	.nr_states = ARRAY_SIZE(mmcif_power_states),
+
+	.type = REGULATOR_VOLTAGE,
+	.init_data = &mmcif_power_init_data,
+};
+
+static struct platform_device mmcif_power = {
+	.name = "gpio-regulator",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &mmcif_power_info,
+	},
+};
 
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -897,12 +936,10 @@ static struct resource sh_mmcif_resources[] = {
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
@@ -942,6 +979,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&irda_device,
 	&vou_device,
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
+	&mmcif_power,
 	&sh_mmcif_device,
 #endif
 };
@@ -1254,8 +1292,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MMC_D0, NULL);
 	gpio_request(GPIO_FN_MMC_CLK, NULL);
 	gpio_request(GPIO_FN_MMC_CMD, NULL);
-	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB7, 0);
 
 	cn12_enabled = true;
 #elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
-- 
1.7.2.5

