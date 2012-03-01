From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] mmc: omap_hsmmc: Use GPIO offset for external GPIO chips
Date: Thu, 01 Mar 2012 10:55:32 -0800
Message-ID: <20120301185532.29210.32421.stgit@kaulin.local>
References: <20120301185044.29210.44521.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120301185044.29210.44521.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
To: linuxkernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

We can now remove the setting of GPIO pins with callbacks
as the drivers can access a GPIO offset on a named gpio_chip
directly with gpio_find_by_chip_name().

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |   13 ++++---------
 arch/arm/mach-omap2/board-cm-t35.c           |    8 ++------
 arch/arm/mach-omap2/board-devkit8000.c       |    7 ++-----
 arch/arm/mach-omap2/board-igep0020.c         |    8 ++------
 arch/arm/mach-omap2/board-omap3beagle.c      |    9 +++------
 arch/arm/mach-omap2/board-omap3evm.c         |    8 ++------
 arch/arm/mach-omap2/board-omap3pandora.c     |   13 ++++---------
 arch/arm/mach-omap2/board-omap3stalker.c     |    8 ++------
 arch/arm/mach-omap2/board-omap3touchbook.c   |    7 ++-----
 arch/arm/mach-omap2/board-zoom-peripherals.c |    7 ++-----
 10 files changed, 25 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index da75f23..238b95a 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -231,14 +231,16 @@ static struct omap2_hsmmc_info mmc[] = {
 		 * so the SIM card isn't used; else 4 bits.
 		 */
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 4,
-		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 1,	/* mmc1_cd offset in twl4030 */
 		.gpio_wp	= 7,
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -246,13 +248,6 @@ static struct omap2_hsmmc_info mmc[] = {
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	/* gpio + 0 is "mmc0_cd" (input/IRQ),
-	 * gpio + 1 is "mmc1_cd" (input/IRQ)
-	 */
-	mmc[0].gpio_cd = gpio + 0;
-	mmc[1].gpio_cd = gpio + 1;
-	omap_hsmmc_late_init(mmc);
-
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "sub_lcd_en_bkl");
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 49e6405..26466f3 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= -EINVAL,
-		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
@@ -469,10 +469,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
 	}
 
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 11cd2a8..b250999 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -99,8 +99,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 29,
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -227,10 +228,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 {
 	int ret;
 
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index e558800..d39f016 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -293,9 +293,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= -EINVAL,
-		.deferred	= true,
 	},
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
 	{
@@ -401,10 +401,6 @@ static int igep_twl_gpio_setup(struct device *dev,
 {
 	int ret;
 
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
 	ret = gpio_request_one(gpio + TWL4030_GPIO_MAX + 1, GPIOF_OUT_INIT_HIGH,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7be8d65..bbb3234 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -252,8 +252,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= -EINVAL,
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -273,11 +274,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 {
 	int r;
 
-	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
 	 * high / others active low)
@@ -523,6 +519,7 @@ static void __init omap3_beagle_init(void)
 
 	if (beagle_config.mmc1_gpio_wp != -EINVAL)
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
+	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
 	omap_hsmmc_init(mmc);
 
 	omap3_beagle_i2c_init();
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6b77ad9..4bc86d9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -315,9 +315,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 63,
-		.deferred	= true,
 	},
 #ifdef CONFIG_WL12XX_PLATFORM_DATA
 	{
@@ -361,10 +361,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 {
 	int r, lcd_bl_en;
 
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ace466b..b387264 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -270,19 +270,19 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
-		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 127,
 		.ext_clock	= 1,
 		.transceiver	= true,
-		.deferred	= true,
 	},
 	{
 		.mmc		= 3,
@@ -299,11 +299,6 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 {
 	int ret, gpio_32khz;
 
-	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
-	omap3pandora_mmc[0].gpio_cd = gpio + 0;
-	omap3pandora_mmc[1].gpio_cd = gpio + 1;
-	omap_hsmmc_late_init(omap3pandora_mmc);
-
 	/* gpio + 13 drives 32kHz buffer for wifi module */
 	gpio_32khz = gpio + 13;
 	ret = gpio_request_one(gpio_32khz, GPIOF_OUT_INIT_HIGH, "wifi 32kHz");
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 6410043..6d0deb9 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -211,9 +211,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 23,
-		.deferred	= true,
 	 },
 	{}			/* Terminator */
 };
@@ -282,10 +282,6 @@ static int
 omap3stalker_twl_gpio_setup(struct device *dev,
 			    unsigned gpio, unsigned ngpio)
 {
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 8842e04..cf270b8 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -99,8 +99,9 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= 29,
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -118,10 +119,6 @@ static struct gpio_led gpio_leds[];
 static int touchbook_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 3d39cdb..604df86 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -203,9 +203,10 @@ static struct omap2_hsmmc_info mmc[] = {
 		.name		= "external",
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpiochip_cd	= "twl4030_gpio",
+		.gpio_cd	= 0,	/* mmc0_cd offset in twl4030 */
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
-		.deferred	= true,
 	},
 	{
 		.name		= "internal",
@@ -232,10 +233,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
 {
 	int ret;
 
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
 	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
 			       "lcd enable");
 	if (ret)

