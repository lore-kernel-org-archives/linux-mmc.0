From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v6 5/8] OMAP: hwmod data: Add dev_attr and use in the host driver
Date: Mon, 28 Feb 2011 20:48:02 +0530
Message-ID: <1298906285-29895-6-git-send-email-kishore.kadiyala@ti.com>
References: <1298906285-29895-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43689 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab1B1PKs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Feb 2011 10:10:48 -0500
In-Reply-To: <1298906285-29895-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

Add a device attribute to hwmod data of omap2430, omap3, omap4.
Currently the device attribute holds information regarding dual volt MMC card
support by the controller which will be later passed to the host driver via
platform data.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by: Benoit Cousson<b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 arch/arm/plat-omap/include/plat/mmc.h      |    9 +++++++++
 4 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index cba1800..d144540 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -19,6 +19,7 @@
 #include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
 
 #include "omap_hwmod_common_data.h"
@@ -1585,6 +1586,10 @@ static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
 	&omap2430_l4_core__mmc1,
 };
 
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.name		= "mmc1",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
@@ -1604,6 +1609,7 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MMCHS1_SHIFT,
 		},
 	},
+	.dev_attr	= &mmc1_dev_attr,
 	.slaves		= omap2430_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
 	.class		= &omap2430_mmc_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7726932..07065c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -22,6 +22,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mmc.h>
 #include <plat/smartreflex.h>
 #include <plat/mcspi.h>
 
@@ -2309,6 +2310,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc1_slaves[] = {
 	&omap3xxx_l4_core__mmc1,
 };
 
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
@@ -2327,6 +2332,7 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
 		},
 	},
+	.dev_attr	= &mmc1_dev_attr,
 	.slaves		= omap3xxx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
 	.class		= &omap34xx_mmc_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dd39e75..0f7d02b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -3383,6 +3384,7 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
+
 static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
 	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3420,6 +3422,11 @@ static struct omap_hwmod_ocp_if *omap44xx_mmc1_slaves[] = {
 	&omap44xx_l4_per__mmc1,
 };
 
+/* mmc1 dev_attr */
+static struct omap_mmc_dev_attr mmc1_dev_attr = {
+	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
@@ -3433,6 +3440,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
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

