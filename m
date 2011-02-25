From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 4/6] OMAP: hwmod data: Add dev_attr and use in the
 host driver
Date: Fri, 25 Feb 2011 14:15:52 +0100
Message-ID: <4D67AB88.9070802@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com> <1298575614-9388-5-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298575614-9388-5-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kishore,

On 2/24/2011 8:26 PM, Kadiyala, Kishore wrote:
> Add a device attribute to hwmod data of omap2430, omap3, omap4.
> Currently the device attribute holds information regarding dual volt MMC card
> support by the controller which will be later passed to the host driver via
> platform data.
>
> Signed-off-by: Kevin Hilman<khilman@deeprootsystems.com>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

I slightly moved the OMAP4 dev_attr as discussed in my previous comment 
to the right place.

The updated patch is below.

Thanks,
Benoit

---
commit 07385426ddbe1d1154a051474eef628a33f58f73
Author: kishore kadiyala <kishore.kadiyala@ti.com>
Date:   Thu Feb 24 19:26:52 2011 +0000

     OMAP: hwmod data: Add dev_attr and use in the host driver

     Add a device attribute to hwmod data of omap2430, omap3, omap4.
     Currently the device attribute holds information regarding dual 
volt MMC card
     support by the controller which will be later passed to the host 
driver via
     platform data.

     Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
     Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
     Acked-by: Benoit Cousson <b-cousson@ti.com>
     Cc: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c 
b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
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
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
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
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dd39e75..e981c5b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
  #include <plat/gpio.h>
  #include <plat/dma.h>
  #include <plat/mcspi.h>
+#include <plat/mmc.h>

  #include "omap_hwmod_common_data.h"

@@ -3420,6 +3421,11 @@ static struct omap_hwmod_ocp_if 
*omap44xx_mmc1_slaves[] = {
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
@@ -3433,6 +3439,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mmc1_dev_attr,
  	.slaves		= omap44xx_mmc1_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
  	.masters	= omap44xx_mmc1_masters,
diff --git a/arch/arm/plat-omap/include/plat/mmc.h 
b/arch/arm/plat-omap/include/plat/mmc.h
index f57f36a..b30e0a4 100644
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


