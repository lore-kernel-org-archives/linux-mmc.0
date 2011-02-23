From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v3 4/5] OMAP: hwmod data: Add dev_attr and use in the host driver
Date: Wed, 23 Feb 2011 23:17:10 +0530
Message-ID: <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695Ab1BWRjq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Feb 2011 12:39:46 -0500
In-Reply-To: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add a device attribute to hwmod data of omap2430, omap3, omap4.
Currently the device attribute holds information regarding dual volt MMC card
support by the controller which will be later passed to the host driver via
platform data.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   16 ++++++++++++++++
 arch/arm/plat-omap/include/plat/mmc.h      |   10 ++++++++++
 drivers/mmc/host/omap_hsmmc.c              |    4 ++--
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4d45b7d..e050355 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -19,6 +19,7 @@
 #include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/mcspi.h>
+#include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1290,6 +1291,10 @@ static struct omap_hwmod_class mmc_class = {
 
 /* MMC/SD/SDIO1 */
 
+static struct mmc_dev_attr mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
 	{ .irq = 83 },
 };
@@ -1328,11 +1333,14 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.slaves		= omap2430_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
 	.class		= &mmc_class,
+	.dev_attr	= &mmc1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* MMC/SD/SDIO2 */
 
+static struct mmc_dev_attr mmc2_dev_attr;
+
 static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
 	{ .irq = 86 },
 };
@@ -1371,6 +1379,7 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.slaves		= omap2430_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
 	.class		= &mmc_class,
+	.dev_attr	= &mmc2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c8f2725..6afdf7f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,6 +21,7 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mmc.h>
 #include <plat/smartreflex.h>
 #include <plat/mcspi.h>
 
@@ -1868,6 +1869,10 @@ static struct omap_hwmod_class mmc_class = {
 
 /* MMC/SD/SDIO1 */
 
+static struct mmc_dev_attr omap_mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
 	{ .irq = 83, },
 };
@@ -1906,11 +1911,14 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 	.slaves		= omap3xxx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
 	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* MMC/SD/SDIO2 */
 
+static struct mmc_dev_attr omap_mmc2_dev_attr;
+
 static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
 	{ .irq = INT_24XX_MMC2_IRQ, },
 };
@@ -1949,11 +1957,14 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
 	.slaves		= omap3xxx_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
 	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* MMC/SD/SDIO3 */
 
+static struct mmc_dev_attr omap_mmc3_dev_attr;
+
 static struct omap_hwmod_irq_info mmc3_mpu_irqs[] = {
 	{ .irq = 94, },
 };
@@ -1991,6 +2002,7 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.slaves		= omap3xxx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc3_slaves),
 	.class		= &mmc_class,
+	.dev_attr	= &omap_mmc3_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dd39e75..6c4ccfd 100644
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
+static struct mmc_dev_attr omap_mmc1_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+};
+
 static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
 	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3437,10 +3442,14 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
 	.masters	= omap44xx_mmc1_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
+	.dev_attr	= &omap_mmc1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc2 */
+static struct omap_hwmod omap44xx_mmc2_hwmod;
+static struct mmc_dev_attr omap_mmc2_dev_attr;
+
 static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
 	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3495,11 +3504,13 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
 	.masters	= omap44xx_mmc2_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
+	.dev_attr	= &omap_mmc2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc3 */
 static struct omap_hwmod omap44xx_mmc3_hwmod;
+static struct mmc_dev_attr omap_mmc3_dev_attr;
 static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
 	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3547,11 +3558,13 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	},
 	.slaves		= omap44xx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc3_slaves),
+	.dev_attr	= &omap_mmc3_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc4 */
 static struct omap_hwmod omap44xx_mmc4_hwmod;
+static struct mmc_dev_attr omap_mmc4_dev_attr;
 static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
 	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3599,11 +3612,13 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	},
 	.slaves		= omap44xx_mmc4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc4_slaves),
+	.dev_attr	= &omap_mmc4_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc5 */
 static struct omap_hwmod omap44xx_mmc5_hwmod;
+static struct mmc_dev_attr omap_mmc5_dev_attr;
 static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
 	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3651,6 +3666,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	},
 	.slaves		= omap44xx_mmc5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc5_slaves),
+	.dev_attr	= &omap_mmc5_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index e5de5d4..7853130 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -43,6 +43,13 @@
 
 #define OMAP_MMC_MAX_SLOTS	2
 
+/* omap_hwmod integration data */
+#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT	BIT(1)
+
+struct mmc_dev_attr {
+	u8 flags;
+};
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
@@ -71,6 +78,9 @@ struct omap_mmc_platform_data {
 
 	u64 dma_mask;
 
+	/* Integrating attributes from the omap_hwmod layer */
+	u8 controller_dev_attr;
+
 	/* Register offset deviation */
 	u16 reg_offset;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 078fdf1..160cc95 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1555,7 +1555,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_dev_attr & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		/* Only MMC1 can interface at 3V without some flavor
 		 * of external transceiver; but they all handle 1.8V.
 		 */
@@ -1647,7 +1647,7 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	u32 hctl, capa, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_dev_attr & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		hctl = SDVS30;
 		capa = VS30 | VS18;
 	} else {
-- 
1.7.1

