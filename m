From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 01/10] ARM: OMAP2: MMC: include mmc-omap platform header directly
Date: Sat,  8 Nov 2014 15:33:08 +0100
Message-ID: <1415457197-14294-2-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Only a few files really need that platform header. When later splitting
omap_mmc_platform_data into omap_mmc and omap_mmc_hs, those files
declaring an hs mmc platform data will have to change the platform
include, which is a good sanity check.
Also removing omap242x_init_mmc, which is not used anywhere, checked
with grep.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/board-n8x0.c                        |  2 ++
 arch/arm/mach-omap2/hsmmc.c                             |  3 ++-
 arch/arm/mach-omap2/mmc.h                               | 10 ----------
 arch/arm/mach-omap2/omap4-common.c                      |  1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c              |  1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c               |  2 +-
 11 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 97767a2..e0ad64f 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -21,8 +21,10 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
+#include <linux/mmc/host.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/mfd/menelaus.h>
 #include <sound/tlv320aic3x.h>
 
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 07d4c7b..73e28ac 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,14 +14,15 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 
 #include "soc.h"
 #include "omap_device.h"
 #include "omap-pm.h"
 
 #include "mux.h"
-#include "mmc.h"
 #include "hsmmc.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
index 0cd4b08..30d39b9 100644
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -1,5 +1,3 @@
-#include <linux/mmc/host.h>
-#include <linux/platform_data/mmc-omap.h>
 
 #define OMAP24XX_NR_MMC		2
 #define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
@@ -7,14 +5,6 @@
 
 #define OMAP4_MMC_REG_OFFSET	0x100
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-#else
-static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
-{
-}
-#endif
-
 struct omap_hwmod;
 int omap_msdi_reset(struct omap_hwmod *oh);
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 16b20ce..b7cb44a 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -36,7 +36,6 @@
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
-#include "mmc.h"
 #include "prminst44xx.h"
 #include "prcm_mpu44xx.h"
 #include "omap4-sar-layout.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c2555cb..cd95e82 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,12 +15,12 @@
 
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
-#include "mmc.h"
 #include "l3_2xxx.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index a579b89..bf8c12d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -15,10 +15,10 @@
  */
 
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include "omap_hwmod.h"
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 #include "cm33xx.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 6b406ca..0cf7b56 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -27,7 +27,6 @@
 #include "prm33xx.h"
 #include "prm-regbits-33xx.h"
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 2a78b09..5f244a9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -18,6 +18,7 @@
 #include <linux/i2c-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 
 #include <linux/omap-dma.h>
 #include "l3_3xxx.h"
@@ -37,7 +38,6 @@
 #include "cm-regbits-34xx.h"
 
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 #include "serial.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 44e5634..c385185 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
@@ -39,7 +40,6 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 1103aa0..13bf6a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -19,6 +19,7 @@
 
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
@@ -33,7 +34,6 @@
 #include "cm2_54xx.h"
 #include "prm54xx.h"
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 
 /* Base offset for all OMAP5 interrupts external to MPUSS */
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 5684f11..8523821 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -19,6 +19,7 @@
 
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
@@ -33,7 +34,6 @@
 #include "cm2_7xx.h"
 #include "prm7xx.h"
 #include "i2c.h"
-#include "mmc.h"
 #include "wd_timer.h"
 #include "soc.h"
 
-- 
2.1.1

