From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap mmc: extended to pass host capabilities from board file
Date: Wed, 15 Sep 2010 20:19:23 +0530
Message-ID: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Sukumar Ghorai <s-ghorai@ti.com>
List-Id: linux-mmc@vger.kernel.org

  wires variable is renamed, extended and this single variable to be used to
  pass the platform capabilities, e.g DDR mode. Also removed the hardcoded
  value was using as bus-width.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    3 ++-
 arch/arm/mach-omap2/board-3430sdp.c          |    5 +++--
 arch/arm/mach-omap2/board-4430sdp.c          |    4 ++--
 arch/arm/mach-omap2/board-cm-t35.c           |    5 +++--
 arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
 arch/arm/mach-omap2/board-igep0020.c         |    5 +++--
 arch/arm/mach-omap2/board-ldp.c              |    3 ++-
 arch/arm/mach-omap2/board-n8x0.c             |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    3 ++-
 arch/arm/mach-omap2/board-omap3evm.c         |    3 ++-
 arch/arm/mach-omap2/board-omap3pandora.c     |    7 ++++---
 arch/arm/mach-omap2/board-omap3stalker.c     |    3 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    3 ++-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    5 +++--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    5 +++--
 arch/arm/mach-omap2/devices.c                |   16 +++++++++-------
 arch/arm/mach-omap2/hsmmc.c                  |   16 ++++++++++------
 arch/arm/mach-omap2/hsmmc.h                  |    3 ++-
 arch/arm/plat-omap/include/plat/mmc.h        |    7 +++----
 drivers/mmc/host/omap.c                      |    2 +-
 drivers/mmc/host/omap_hsmmc.c                |   18 ++----------------
 23 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8538e41..fc178a0 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -19,6 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mmc/host.h>
 #include <linux/delay.h>
 #include <linux/i2c/twl.h>
 #include <linux/err.h>
@@ -190,7 +191,7 @@ static int __init omap2430_i2c_init(void)
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ext_clock	= 1,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5..3eb9839 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -353,12 +354,12 @@ static struct omap2_hsmmc_info mmc[] = {
 		/* 8 bits (default) requires S6.3 == ON,
 		 * so the SIM card isn't used; else 4 bits.
 		 */
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 4,
 	},
 	{
 		.mmc		= 2,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 7,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..e379bef 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -193,12 +193,12 @@ static struct omap_musb_board_data musb_board_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
-		.wires		= 8,
+		.caps		=  MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable   = true,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..b72009a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -31,6 +31,7 @@
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/tdo24m.h>
@@ -579,14 +580,14 @@ static struct twl4030_keypad_data cm_t35_kp_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 
 	},
 	{
 		.mmc		= 2,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.transceiver	= 1,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a07086d..de5e2c2 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -28,6 +28,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/mmc/host.h>
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
@@ -105,7 +106,7 @@ static struct omap_nand_platform_data devkit8000_nand_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 175f043..f3f0280 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -20,6 +20,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -248,13 +249,13 @@ static struct regulator_init_data igep2_vmmc2 = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 00d9b13..58698e3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -27,6 +27,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/mmc/host.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -362,7 +363,7 @@ static int __init omap_i2c_init(void)
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index a3e2b49..64ef167 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -487,7 +487,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.max_freq			= 24000000,
 	.dma_mask			= 0xffffffff,
 	.slots[0] = {
-		.wires			= 4,
+		.caps			= MMC_CAP_4_BIT_DATA,
 		.set_power		= n8x0_mmc_set_power,
 		.set_bus_mode		= n8x0_mmc_set_bus_mode,
 		.get_cover_state	= n8x0_mmc_get_cover_state,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 87969c7..51493f5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/mmc/host.h>
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
@@ -166,7 +167,7 @@ static void __init beagle_display_init(void)
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d9c0..523ba55 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -31,6 +31,7 @@
 #include <linux/smsc911x.h>
 
 #include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -370,7 +371,7 @@ static struct regulator_init_data omap3evm_vsim = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
 	},
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index dd3af2b..2d2e6fc 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -32,6 +32,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 
 #include <asm/mach-types.h>
@@ -276,14 +277,14 @@ static void pandora_wl1251_init_card(struct mmc_card *card)
 static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
 	},
 	{
 		.mmc		= 2,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 127,
 		.ext_clock	= 1,
@@ -291,7 +292,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	},
 	{
 		.mmc		= 3,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index bcd01d2..c1b881d 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -26,6 +26,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/mmc/host.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -275,7 +276,7 @@ static struct regulator_init_data omap3stalker_vsim = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 	 .mmc		= 1,
-	 .wires		= 4,
+	 .caps		= MMC_CAP_4_BIT_DATA,
 	 .gpio_cd	= -EINVAL,
 	 .gpio_wp	= 23,
 	 },
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 663c62d..9ab18fd 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/mmc/host.h>
 
 #include <plat/mcspi.h>
 #include <linux/spi/spi.h>
@@ -108,7 +109,7 @@ static struct omap_nand_platform_data omap3touchbook_nand_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c03d1d5..81e756d 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -56,7 +56,7 @@ static struct omap_musb_board_data musb_board_data = {
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4c48436..93441e5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -303,13 +304,13 @@ static void __init overo_flash_init(void)
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.transceiver	= true,
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a5eb87..a3dbaa7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -302,7 +302,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.cover_only	= true,
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
@@ -311,7 +311,8 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 8, /* See also rx51_mmc2_remux */
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+						/* See also rx51_mmc2_remux */
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..e5eac46 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -155,14 +156,14 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 	},
 	{
 		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 8,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..9390750 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -624,7 +624,7 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 		omap_mux_init_signal("sdmmc_dat0", 0);
 		omap_mux_init_signal("sdmmc_dat_dir0", 0);
 		omap_mux_init_signal("sdmmc_cmd_dir", 0);
-		if (mmc_controller->slots[0].wires == 4) {
+		if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
 			omap_mux_init_signal("sdmmc_dat1", 0);
 			omap_mux_init_signal("sdmmc_dat2", 0);
 			omap_mux_init_signal("sdmmc_dat3", 0);
@@ -652,8 +652,8 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 				OMAP_PIN_INPUT_PULLUP);
 			omap_mux_init_signal("sdmmc1_dat0",
 				OMAP_PIN_INPUT_PULLUP);
-			if (mmc_controller->slots[0].wires == 4 ||
-				mmc_controller->slots[0].wires == 8) {
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
 				omap_mux_init_signal("sdmmc1_dat1",
 					OMAP_PIN_INPUT_PULLUP);
 				omap_mux_init_signal("sdmmc1_dat2",
@@ -661,7 +661,8 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 				omap_mux_init_signal("sdmmc1_dat3",
 					OMAP_PIN_INPUT_PULLUP);
 			}
-			if (mmc_controller->slots[0].wires == 8) {
+			if (mmc_controller->slots[0].caps &
+						MMC_CAP_8_BIT_DATA) {
 				omap_mux_init_signal("sdmmc1_dat4",
 					OMAP_PIN_INPUT_PULLUP);
 				omap_mux_init_signal("sdmmc1_dat5",
@@ -685,8 +686,8 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7 need to be muxed
 			 * in the board-*.c files
 			 */
-			if (mmc_controller->slots[0].wires == 4 ||
-				mmc_controller->slots[0].wires == 8) {
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
 				omap_mux_init_signal("sdmmc2_dat1",
 					OMAP_PIN_INPUT_PULLUP);
 				omap_mux_init_signal("sdmmc2_dat2",
@@ -694,7 +695,8 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 				omap_mux_init_signal("sdmmc2_dat3",
 					OMAP_PIN_INPUT_PULLUP);
 			}
-			if (mmc_controller->slots[0].wires == 8) {
+			if (mmc_controller->slots[0].caps &
+							MMC_CAP_8_BIT_DATA) {
 				omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
 					OMAP_PIN_INPUT_PULLUP);
 				omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c8f647b..87ce6ff 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -258,7 +258,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 				"mmc%islot%i", c->mmc, 1);
 		mmc->slots[0].name = hc->name;
 		mmc->nr_slots = 1;
-		mmc->slots[0].wires = c->wires;
+		mmc->slots[0].caps = c->caps;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
 
@@ -316,16 +316,20 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			}
 
 			/* Omap3630 HSMMC1 supports only 4-bit */
-			if (cpu_is_omap3630() && c->wires > 4) {
-				c->wires = 4;
-				mmc->slots[0].wires = c->wires;
+			if (cpu_is_omap3630() &&
+					(c->caps & MMC_CAP_8_BIT_DATA)) {
+				c->caps &= ~MMC_CAP_8_BIT_DATA;
+				c->caps |= MMC_CAP_4_BIT_DATA;
+				mmc->slots[0].caps = c->caps;
 			}
 			break;
 		case 2:
 			if (c->ext_clock)
 				c->transceiver = 1;
-			if (c->transceiver && c->wires > 4)
-				c->wires = 4;
+			if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
+				c->caps &= ~MMC_CAP_8_BIT_DATA;
+				c->caps |= MMC_CAP_4_BIT_DATA;
+			}
 			/* FALLTHROUGH */
 		case 3:
 			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 1fe6f01..281e972 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -10,7 +10,8 @@ struct mmc_card;
 
 struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
-	u8	wires;		/* 1/4/8 wires */
+	u32	caps;		/* 4/8 wires and any additional host
+				 * capabilities OR'd (ref. linux/mmc/host.h) */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 9b89ec6..4f819fc 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -73,10 +73,9 @@ struct omap_mmc_platform_data {
 
 	struct omap_mmc_slot_data {
 
-		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
-		 * 8 wire signaling is also optional, and is used with HSMMC
-		 */
-		u8 wires;
+		/* 4/8 wires and any additional host capabilities
+		 * need to OR'd all capabilities (ref. linux/mmc/host.h) */
+		u32 caps;
 
 		/*
 		 * nomux means "standard" muxing is wrong on this board, and
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index d98ddcf..a9d62cf 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1317,7 +1317,7 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	host->slots[id] = slot;
 
 	mmc->caps = 0;
-	if (host->pdata->slots[id].wires >= 4)
+	if (host->pdata->slots[id].caps & MMC_CAP_8_BIT_DATA)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1c359f0..fe1d391 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2124,23 +2124,9 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
 
-	switch (mmc_slot(host).wires) {
-	case 8:
-		mmc->caps |= MMC_CAP_8_BIT_DATA;
-		/* Fall through */
-	case 4:
+	mmc->caps |= mmc_slot(host).caps;
+	if (mmc->caps & MMC_CAP_8_BIT_DATA)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 1:
-		/* Nothing to crib here */
-	case 0:
-		/* Assuming nothing was given by board, Core use's 1-Bit */
-		break;
-	default:
-		/* Completely unexpected.. Core goes with 1-Bit Width */
-		dev_crit(mmc_dev(host->mmc), "Invalid width %d\n used!"
-			"using 1 instead\n", mmc_slot(host).wires);
-	}
 
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
