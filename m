From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: [PATCH v2 08/14] MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
Date: Sun, 22 Jan 2017 15:49:41 +0100
Message-ID: <20170122144947.16158-9-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170122144947.16158-1-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

We set the pin configuration for the jz4740-nand, jz4740-mmc,
jz4740-fb, jz4740-pwm and jz4740-uart drivers.

This will permit those drivers to be cleaned out of the custom GPIO code
that they currently use.

Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 13 +++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 42 ++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

v2: Changed the devicetree bindings to match the new driver

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
