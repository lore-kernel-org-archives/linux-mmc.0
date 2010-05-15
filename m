From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v4 4/5] OMAP HSMMC: Adding a flag to determine the card
     detect type
Date: Sat, 15 May 2010 23:51:52 +0530 (IST)
Message-ID: <22510.10.24.255.17.1273947712.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

Adding a flag to determine the card detect type which can be
either GPIO or NON-GPIO.MMC1 Controller of OMAP4 have NON-GPIO
interrupt line from twl6030 for card detect.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 ++
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
 arch/arm/mach-omap2/board-cm-t35.c           |    3 +++
 arch/arm/mach-omap2/board-devkit8000.c       |    2 ++
 arch/arm/mach-omap2/board-igep0020.c         |    3 +++
 arch/arm/mach-omap2/board-ldp.c              |    2 ++
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
 arch/arm/mach-omap2/board-omap3evm.c         |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 ++++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
 arch/arm/mach-omap2/board-overo.c            |    3 +++
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +++
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/mmc.h        |    4 ++++
 15 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a11a575..c7dec0e 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -37,6 +37,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/mmc.h>

 #include "hsmmc.h"

@@ -196,6 +197,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.ext_clock	= 1,
 	},
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e7d629b..cfb20a0 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -40,6 +40,7 @@

 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/mmc.h>

 #include <mach/board-sdp.h>

@@ -356,11 +357,13 @@ static struct omap2_hsmmc_info mmc[] = {
 		 * so the SIM card isn't used; else 4 bits.
 		 */
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 4,
 	},
 	{
 		.mmc		= 2,
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 7,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..89cfd1a 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -46,6 +46,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>

 #include <mach/hardware.h>

@@ -599,6 +600,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,

 	},
@@ -607,6 +609,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.wires		= 4,
 		.transceiver	= 1,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
 	},
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 77022b5..114820f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -45,6 +45,7 @@
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
 #include <plat/display.h>
+#include <plat/mmc.h>

 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
@@ -122,6 +123,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..3d5d506 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,6 +30,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/onenand.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -250,12 +251,14 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{}      /* Terminator */
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5fcb52e..efe3b1b 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,6 +38,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
+#include <plat/mmc.h>

 #include <asm/delay.h>
 #include <plat/control.h>
@@ -364,6 +365,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..d79adff 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -43,6 +43,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -112,6 +113,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index cfbe695..9d2f240 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -42,6 +42,7 @@
 #include <plat/common.h>
 #include <plat/mcspi.h>
 #include <plat/display.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -372,6 +373,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= 63,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..ba5043c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -41,6 +41,7 @@
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -232,6 +233,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
 	},
@@ -239,6 +241,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.mmc		= 2,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= 127,
 		.ext_clock	= 1,
 		.transceiver	= true,
@@ -247,6 +250,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.mmc		= 3,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..e6cab4a 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -48,6 +48,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -126,6 +127,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 79ac414..a2d1e74 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -45,6 +45,7 @@
 #include <mach/hardware.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -289,12 +290,14 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{
 		.mmc		= 2,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.transceiver	= true,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 966f5f8..c9c204a 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -256,6 +257,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.wires		= 4,
 		.cover_only	= true,
 		.gpio_cd	= 160,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 	},
@@ -264,6 +266,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.mmc		= 2,
 		.wires		= 8, /* See also rx51_mmc2_remux */
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..018a813 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -23,6 +23,7 @@

 #include <plat/common.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -156,6 +157,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.name		= "external",
 		.mmc		= 1,
 		.wires		= 4,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 	},
@@ -164,6 +166,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.mmc		= 2,
 		.wires		= 8,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 36f0ba8..10690b9 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -17,6 +17,7 @@ struct omap2_hsmmc_info {
 	bool	no_off;		/* power_saving and power is not to go off */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	int	gpio_cd;	/* or -EINVAL */
+	bool	cd_type;	/* GPIO or NON_GPIO */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index c835f1e..ed60c0f 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -43,6 +43,9 @@

 #define OMAP_MMC_MAX_SLOTS	2

+#define NON_GPIO		0
+#define GPIO			1
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
@@ -107,6 +110,7 @@ struct omap_mmc_platform_data {
 		unsigned features;

 		int switch_pin;			/* gpio (card detect) */
+		unsigned cd_type:1;		/* GPIO or NON_GPIO */
 		int gpio_wp;			/* gpio (write protect) */

 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
-- 
1.6.3.3


