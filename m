From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 4/6] OMAP: hwmod data: Add dev_attr and use in the host driver
Date: Fri, 25 Feb 2011 00:56:52 +0530
Message-ID: <1298575614-9388-5-git-send-email-kishore.kadiyala@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add a device attribute to hwmod data of omap2430, omap3, omap4.
Currently the device attribute holds information regarding dual volt MMC card
support by the controller which will be later passed to the host driver via
platform data.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 arch/arm/plat-omap/include/plat/mmc.h      |    9 +++++++++
 4 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9c99083..cbb7c9d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -19,6 +19,7 @@
 #include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
 
 #include "omap_hwmod_common_data.h"
@@ -1568,6 +1569,10 @@ static struct omap_hwmod_class mmc_class = {
 
 /* MMC/SD/SDIO1 */
 
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
 	{ .irq = 83 },
 };
@@ -1603,6 +1608,7 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MMCHS1_SHIFT,
 		},
 	},
+	.dev_attr	= &mmc1_dev_attr,
 	.slaves		= omap2430_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
 	.class		= &mmc_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index d4e734e..7fa2dfb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -22,6 +22,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mmc.h>
 #include <plat/smartreflex.h>
 #include <plat/mcspi.h>
 
@@ -2292,6 +2293,10 @@ static struct omap_hwmod_class mmc_class = {
 
 /* MMC/SD/SDIO1 */
 
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
 	{ .irq = 83, },
 };
@@ -2327,6 +2332,7 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
 		},
 	},
+	.dev_attr	= &mmc1_dev_attr,
 	.slaves		= omap3xxx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
 	.class		= &mmc_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dd39e75..28031e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -3383,6 +3384,10 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
 	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3433,6 +3438,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &mmc1_dev_attr,
 	.slaves		= omap44xx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
 	.masters	= omap44xx_mmc1_masters,
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index e5de5d4..a7afab0 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -43,6 +43,12 @@
 
 #define OMAP_MMC_MAX_SLOTS	2
 
+#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT	BIT(1)
+
+struct omap_mmc_dev_attr {
+	u8 flags;
+};
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
@@ -71,6 +77,9 @@ struct omap_mmc_platform_data {
 
 	u64 dma_mask;
 
+	/* Integrating attributes from the omap_hwmod layer */
+	u8 controller_flags;
+
 	/* Register offset deviation */
 	u16 reg_offset;
 
-- 
1.7.1

