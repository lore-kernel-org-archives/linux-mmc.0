From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v5 1/2] OMAP HSMMC: Adding a Flag to determine the type of
     Card detect
Date: Thu, 17 Jun 2010 20:56:58 +0530 (IST)
Message-ID: <43583.10.24.255.17.1276788418.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Adding a flag to determine the card detect type which can be
either GPIO or NON-GPIO. MMC1 Controller of OMAP4 have NON-GPIO
interrupt line from twl6030 for card detect.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
 arch/arm/mach-omap2/board-cm-t35.c           |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c       |    2 ++
 arch/arm/mach-omap2/board-igep0020.c         |    2 ++
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 +++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 ++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
 arch/arm/mach-omap2/hsmmc.h                  |    1 +
 arch/arm/plat-omap/include/plat/mmc.h        |    4 ++++
 11 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f474a80..bd6f81d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -40,6 +40,7 @@

 #include <plat/control.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/mmc.h>

 #include <mach/board-sdp.h>

@@ -354,11 +355,13 @@ static struct omap2_hsmmc_info mmc[] = {
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
index e679a2c..ddf6968 100644
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
index d55c57b..bc1957f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -30,6 +30,7 @@
 #include <plat/usb.h>
 #include <plat/display.h>
 #include <plat/onenand.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -250,6 +251,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 69b154c..62d7fcb 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -44,6 +44,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -184,6 +185,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
+		.cd_type	= GPIO,
 		.gpio_wp	= 29,
 	},
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index db06dc9..76752bf 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2f5f823..83ccdcc 100644
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
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c
b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..130f745 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/mmc.h>

 #include "mux.h"
 #include "hsmmc.h"
@@ -284,6 +285,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.wires		= 4,
 		.cover_only	= true,
 		.gpio_cd	= 160,
+		.cd_type	= GPIO,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 	},
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..f9c96e1 100644
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


