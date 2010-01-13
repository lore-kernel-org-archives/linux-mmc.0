From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/8] OMAP: rename mmc-twl4030 to hsmmc
Date: Wed, 13 Jan 2010 13:40:27 +0200
Message-ID: <20100113114027.7615.12153.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

>From 288f31b045a580d935bc2921ff34869038055521 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 4 Jan 2010 16:30:47 +0200
Subject: [PATCH] OMAP: rename mmc-twl4030 to hsmmc

mmc-twl4030.[ch] no longer has any dependency on twl4030
and should be renamed to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/Makefile                 |   28 +++---
 arch/arm/mach-omap2/board-2430sdp.c          |    6 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    6 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    6 +-
 arch/arm/mach-omap2/board-igep0020.c         |    6 +-
 arch/arm/mach-omap2/board-ldp.c              |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    6 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    6 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    6 +-
 arch/arm/mach-omap2/board-overo.c            |    6 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   20 ++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +-
 arch/arm/mach-omap2/hsmmc.c                  |  135 +++++++++++++++++++++++++
 arch/arm/mach-omap2/hsmmc.h                  |   34 +++++++
 arch/arm/mach-omap2/mmc-twl4030.c            |  136 --------------------------
 arch/arm/mach-omap2/mmc-twl4030.h            |   34 -------
 17 files changed, 224 insertions(+), 227 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsmmc.c
 create mode 100644 arch/arm/mach-omap2/hsmmc.h
 delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.c
 delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b32678b..a7e4c5a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -71,42 +71,42 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
 					   board-rx51-peripherals.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o \
+					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o \
+					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
-					   mmc-twl4030.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 31042ee..a3d21a6 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,7 +38,7 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
 
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
@@ -182,7 +182,7 @@ static int __init omap2430_i2c_init(void)
 	return 0;
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -201,7 +201,7 @@ static void __init omap_2430sdp_init(void)
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..a77b25e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -43,7 +43,7 @@
 
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -326,7 +326,7 @@ static struct twl4030_bci_platform_data sdp3430_bci_data = {
 	.tblsize		= ARRAY_SIZE(sdp3430_batt_table),
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		/* 8 bits (default) requires S6.3 == ON,
@@ -363,7 +363,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	 */
 	mmc[0].gpio_cd = gpio + 0;
 	mmc[1].gpio_cd = gpio + 1;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2626a9f..e2b1885 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -46,7 +46,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define CM_T35_GPIO_PENDOWN	57
 
@@ -364,7 +364,7 @@ static struct twl4030_keypad_data cm_t35_kp_data = {
 	.rep		= 1,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -413,7 +413,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	cm_t35_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 117b8fd..754bcc0 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,7 +30,7 @@
 #include <plat/usb.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -121,7 +121,7 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -142,7 +142,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 995d4a2..e3b0fcd 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -44,7 +44,7 @@
 #include <plat/usb.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
@@ -359,7 +359,7 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -396,7 +396,7 @@ static void __init omap_ldp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 231cb4e..518fde6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -45,7 +45,7 @@
 #include <plat/timer-gp.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
@@ -108,7 +108,7 @@ static struct platform_device omap3beagle_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
@@ -147,7 +147,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	beagle_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 34de178..7916faa 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -44,7 +44,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
@@ -185,7 +185,7 @@ static struct regulator_init_data omap3evm_vsim = {
 	.consumer_supplies	= &omap3evm_vsim_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -225,7 +225,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	omap3evm_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ef17cf1..148be6d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -43,7 +43,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OMAP3_PANDORA_TS_GPIO		94
 
@@ -192,7 +192,7 @@ static struct twl4030_keypad_data pandora_kp_data = {
 	.rep		= 1,
 };
 
-static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
+static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -231,7 +231,7 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
-	twl4030_mmc_init(omap3pandora_mmc);
+	omap2_hsmmc_init(omap3pandora_mmc);
 
 	/* link regulators to MMC adapters */
 	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index fe3d22c..f4987a1 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -50,7 +50,7 @@
 #include <plat/timer-gp.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #include <asm/setup.h>
 
@@ -122,7 +122,7 @@ static struct platform_device omap3touchbook_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
@@ -161,7 +161,7 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	touchbook_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d192dd9..0597245 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -48,7 +48,7 @@
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
@@ -272,7 +272,7 @@ static void __init overo_flash_init(void)
 	}
 }
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -297,7 +297,7 @@ static struct regulator_consumer_supply overo_vmmc1_supply = {
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	overo_vmmc1_supply.dev = mmc[0].dev;
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index acafdbc..ab07ca2 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -34,7 +34,7 @@
 #include <plat/gpmc-smc91x.h>
 
 #include "mux.h"
-#include "mmc-twl4030.h"
+#include "hsmmc.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
@@ -209,7 +209,7 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
@@ -232,15 +232,18 @@ static struct twl4030_hsmmc_info mmc[] = {
 };
 
 static struct regulator_consumer_supply rx51_vmmc1_supply = {
-	.supply			= "vmmc",
+	.supply   = "vmmc",
+	.dev_name = "mmci-omap-hs.0",
 };
 
 static struct regulator_consumer_supply rx51_vmmc2_supply = {
-	.supply			= "vmmc",
+	.supply   = "vmmc",
+	.dev_name = "mmci-omap-hs.1",
 };
 
 static struct regulator_consumer_supply rx51_vsim_supply = {
-	.supply			= "vmmc_aux",
+	.supply   = "vmmc_aux",
+	.dev_name = "mmci-omap-hs.1",
 };
 
 static struct regulator_init_data rx51_vaux1 = {
@@ -375,12 +378,6 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 7, "speaker_en");
 	gpio_direction_output(gpio + 7, 1);
 
-	/* set up MMC adapters, linking their regulators to them */
-	twl4030_mmc_init(mmc);
-	rx51_vmmc1_supply.dev = mmc[0].dev;
-	rx51_vmmc2_supply.dev = mmc[1].dev;
-	rx51_vsim_supply.dev = mmc[1].dev;
-
 	return 0;
 }
 
@@ -751,5 +748,6 @@ void __init rx51_peripherals_init(void)
 	rx51_init_wl1251();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
+	omap2_hsmmc_init(mmc);
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 5c8474c..d20294e 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -151,7 +151,7 @@ static struct regulator_init_data zoom_vsim = {
 	.consumer_supplies      = &zoom_vsim_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
@@ -176,7 +176,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
new file mode 100644
index 0000000..1d5f2f0
--- /dev/null
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -0,0 +1,135 @@
+/*
+ * linux/arch/arm/mach-omap2/hsmmc.c
+ *
+ * Copyright (C) 2007-2008 Texas Instruments
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <mach/hardware.h>
+#include <plat/mmc.h>
+
+#include "hsmmc.h"
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
+#define HSMMC_NAME_LEN	9
+
+static struct hsmmc_controller {
+	char				name[HSMMC_NAME_LEN + 1];
+} hsmmc[OMAP34XX_NR_MMC];
+
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
+
+static int hsmmc_get_context_loss(struct device *dev)
+{
+	/* FIXME: PM DPS not implemented yet */
+	return 0;
+}
+
+#else
+#define hsmmc_get_context_loss NULL
+#endif
+
+static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
+
+void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	struct omap2_hsmmc_info *c;
+	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
+
+	for (c = controllers; c->mmc; c++) {
+		struct hsmmc_controller *hc = hsmmc + c->mmc - 1;
+		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
+
+		if (!c->mmc || c->mmc > nr_hsmmc) {
+			pr_debug("MMC%d: no such controller\n", c->mmc);
+			continue;
+		}
+		if (mmc) {
+			pr_debug("MMC%d: already configured\n", c->mmc);
+			continue;
+		}
+
+		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
+		if (!mmc) {
+			pr_err("Cannot allocate memory for mmc device!\n");
+			return;
+		}
+
+		if (c->name)
+			strncpy(hc->name, c->name, HSMMC_NAME_LEN);
+		else
+			snprintf(hc->name, ARRAY_SIZE(hc->name),
+				"mmc%islot%i", c->mmc, 1);
+		mmc->slots[0].name = hc->name;
+		mmc->nr_slots = 1;
+		mmc->slots[0].wires = c->wires;
+		mmc->slots[0].internal_clock = !c->ext_clock;
+		mmc->dma_mask = 0xffffffff;
+
+		mmc->get_context_loss_count = hsmmc_get_context_loss;
+
+		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].gpio_wp = c->gpio_wp;
+
+		if (c->cover_only)
+			mmc->slots[0].cover = 1;
+
+		if (c->nonremovable)
+			mmc->slots[0].nonremovable = 1;
+
+		if (c->power_saving)
+			mmc->slots[0].power_saving = 1;
+
+		/* NOTE:  MMC slots should have a Vcc regulator set up.
+		 * This may be from a TWL4030-family chip, another
+		 * controllable regulator, or a fixed supply.
+		 *
+		 * temporary HACK: ocr_mask instead of fixed supply
+		 */
+		mmc->slots[0].ocr_mask = c->ocr_mask;
+
+		switch (c->mmc) {
+		case 1:
+			/* Omap3630 HSMMC1 supports only 4-bit */
+			if (cpu_is_omap3630() && c->wires > 4) {
+				c->wires = 4;
+				mmc->slots[0].wires = c->wires;
+			}
+			break;
+		case 2:
+			if (c->ext_clock)
+				c->transceiver = 1;
+			if (c->transceiver && c->wires > 4)
+				c->wires = 4;
+			break;
+		case 3:
+			break;
+		default:
+			pr_err("MMC%d configuration not supported!\n", c->mmc);
+			kfree(mmc);
+			continue;
+		}
+		hsmmc_data[c->mmc - 1] = mmc;
+	}
+
+	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
+
+	/* pass the device nodes back to board setup code */
+	for (c = controllers; c->mmc; c++) {
+		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
+
+		if (!c->mmc || c->mmc > nr_hsmmc)
+			continue;
+		c->dev = mmc->dev;
+	}
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
new file mode 100644
index 0000000..e946b5f
--- /dev/null
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -0,0 +1,34 @@
+/*
+ * MMC definitions for OMAP2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+struct omap2_hsmmc_info {
+	u8	mmc;		/* controller 1/2/3 */
+	u8	wires;		/* 1/4/8 wires */
+	bool	transceiver;	/* MMC-2 option */
+	bool	ext_clock;	/* use external pin for input clock */
+	bool	cover_only;	/* No card detect - just cover switch */
+	bool	nonremovable;	/* Nonremovable e.g. eMMC */
+	bool	power_saving;	/* Try to sleep or power off when possible */
+	int	gpio_cd;	/* or -EINVAL */
+	int	gpio_wp;	/* or -EINVAL */
+	char	*name;		/* or NULL for default */
+	struct device *dev;	/* returned: pointer to mmc adapter */
+	int	ocr_mask;	/* temporary HACK */
+};
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
+void omap2_hsmmc_init(struct omap2_hsmmc_info *);
+
+#else
+
+static inline void omap2_hsmmc_init(struct omap2_hsmmc_info *info)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
deleted file mode 100644
index e846d56..0000000
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/mmc-twl4030.c
- *
- * Copyright (C) 2007-2008 Texas Instruments
- * Copyright (C) 2008 Nokia Corporation
- * Author: Texas Instruments
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <mach/hardware.h>
-#include <plat/mmc.h>
-
-#include "mmc-twl4030.h"
-
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
-#define HSMMC_NAME_LEN	9
-
-static struct twl_mmc_controller {
-	char				name[HSMMC_NAME_LEN + 1];
-} hsmmc[OMAP34XX_NR_MMC];
-
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-
-static int twl4030_mmc_get_context_loss(struct device *dev)
-{
-	/* FIXME: PM DPS not implemented yet */
-	return 0;
-}
-
-#else
-#define twl4030_mmc_get_context_loss NULL
-#endif
-
-static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
-
-void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
-{
-	struct twl4030_hsmmc_info *c;
-	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
-
-	for (c = controllers; c->mmc; c++) {
-		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
-		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
-
-		if (!c->mmc || c->mmc > nr_hsmmc) {
-			pr_debug("MMC%d: no such controller\n", c->mmc);
-			continue;
-		}
-		if (mmc) {
-			pr_debug("MMC%d: already configured\n", c->mmc);
-			continue;
-		}
-
-		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
-		if (!mmc) {
-			pr_err("Cannot allocate memory for mmc device!\n");
-			return;
-		}
-
-		if (c->name)
-			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
-		else
-			snprintf(twl->name, ARRAY_SIZE(twl->name),
-				"mmc%islot%i", c->mmc, 1);
-		mmc->slots[0].name = twl->name;
-		mmc->nr_slots = 1;
-		mmc->slots[0].wires = c->wires;
-		mmc->slots[0].internal_clock = !c->ext_clock;
-		mmc->dma_mask = 0xffffffff;
-
-		mmc->get_context_loss_count =
-				twl4030_mmc_get_context_loss;
-
-		mmc->slots[0].switch_pin = c->gpio_cd;
-		mmc->slots[0].gpio_wp = c->gpio_wp;
-
-		if (c->cover_only)
-			mmc->slots[0].cover = 1;
-
-		if (c->nonremovable)
-			mmc->slots[0].nonremovable = 1;
-
-		if (c->power_saving)
-			mmc->slots[0].power_saving = 1;
-
-		/* NOTE:  MMC slots should have a Vcc regulator set up.
-		 * This may be from a TWL4030-family chip, another
-		 * controllable regulator, or a fixed supply.
-		 *
-		 * temporary HACK: ocr_mask instead of fixed supply
-		 */
-		mmc->slots[0].ocr_mask = c->ocr_mask;
-
-		switch (c->mmc) {
-		case 1:
-			/* Omap3630 HSMMC1 supports only 4-bit */
-			if (cpu_is_omap3630() && c->wires > 4) {
-				c->wires = 4;
-				mmc->slots[0].wires = c->wires;
-			}
-			break;
-		case 2:
-			if (c->ext_clock)
-				c->transceiver = 1;
-			if (c->transceiver && c->wires > 4)
-				c->wires = 4;
-			break;
-		case 3:
-			break;
-		default:
-			pr_err("MMC%d configuration not supported!\n", c->mmc);
-			kfree(mmc);
-			continue;
-		}
-		hsmmc_data[c->mmc - 1] = mmc;
-	}
-
-	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
-
-	/* pass the device nodes back to board setup code */
-	for (c = controllers; c->mmc; c++) {
-		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
-
-		if (!c->mmc || c->mmc > nr_hsmmc)
-			continue;
-		c->dev = mmc->dev;
-	}
-}
-
-#endif
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
deleted file mode 100644
index 87d67c1..0000000
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * MMC definitions for OMAP2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-struct twl4030_hsmmc_info {
-	u8	mmc;		/* controller 1/2/3 */
-	u8	wires;		/* 1/4/8 wires */
-	bool	transceiver;	/* MMC-2 option */
-	bool	ext_clock;	/* use external pin for input clock */
-	bool	cover_only;	/* No card detect - just cover switch */
-	bool	nonremovable;	/* Nonremovable e.g. eMMC */
-	bool	power_saving;	/* Try to sleep or power off when possible */
-	int	gpio_cd;	/* or -EINVAL */
-	int	gpio_wp;	/* or -EINVAL */
-	char	*name;		/* or NULL for default */
-	struct device *dev;	/* returned: pointer to mmc adapter */
-	int	ocr_mask;	/* temporary HACK */
-};
-
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
-void twl4030_mmc_init(struct twl4030_hsmmc_info *);
-
-#else
-
-static inline void twl4030_mmc_init(struct twl4030_hsmmc_info *info)
-{
-}
-
-#endif
-- 
1.6.0.4

