From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 08/14] MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
Date: Fri, 28 Apr 2017 22:08:18 +0200
Message-ID: <20170428200824.10906-9-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170428200824.10906-1-paul@crapouillou.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

We set the pin configuration for the jz4740-nand, jz4740-mmc,
jz4740-fb, jz4740-pwm and jz4740-uart drivers.

This will permit those drivers to be cleaned out of the custom GPIO code
that they currently use.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 13 +++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 42 ++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

 v2: Changed the devicetree bindings to match the new driver
 v3: No changes
 v4: No changes
 v5: No changes

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index be1a7d3a3e1b..b715ee2ac2ee 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -17,3 +17,16 @@
 &rtc_dev {
 	system-power-controller;
 };
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0>;
+};
+
+&pinctrl {
+	pins_uart0: uart0 {
+		function = "uart0";
+		groups = "uart0-data";
+		bias-disable;
+	};
+};
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index a5bd94b95263..bf3dcc9ee9f8 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -22,6 +22,8 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
@@ -447,13 +449,36 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&qi_lb60_audio_device,
 };
 
-static void __init board_gpio_setup(void)
-{
-	/* We only need to enable/disable pullup here for pins used in generic
-	 * drivers. Everything else is done by the drivers themselves. */
-	jz_gpio_disable_pullup(QI_LB60_GPIO_SD_VCC_EN_N);
-	jz_gpio_disable_pullup(QI_LB60_GPIO_SD_CD);
-}
+static unsigned long pin_cfg_bias_disable[] = {
+	    PIN_CONFIG_BIAS_DISABLE,
+};
+
+static struct pinctrl_map pin_map[] __initdata = {
+	/* NAND pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-nand",
+			"10010000.jz4740-pinctrl", "nand", "nand"),
+
+	/* fbdev pin configuration */
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_DEFAULT,
+			"10010000.jz4740-pinctrl", "lcd", "lcd-8bit"),
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
+			"10010000.jz4740-pinctrl", "lcd", "lcd-no-pins"),
+
+	/* MMC pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "mmc", "mmc-1bit"),
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "mmc", "mmc-4bit"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
+
+	/* PWM pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
+			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
+};
+
 
 static int __init qi_lb60_init_platform_devices(void)
 {
@@ -469,6 +494,7 @@ static int __init qi_lb60_init_platform_devices(void)
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
 	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
+	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
 
 	return platform_add_devices(jz_platform_devices,
 					ARRAY_SIZE(jz_platform_devices));
@@ -479,8 +505,6 @@ static int __init qi_lb60_board_setup(void)
 {
 	printk(KERN_INFO "Qi Hardware JZ4740 QI LB60 setup\n");
 
-	board_gpio_setup();
-
 	if (qi_lb60_init_platform_devices())
 		panic("Failed to initialize platform devices");
 
-- 
2.11.0

