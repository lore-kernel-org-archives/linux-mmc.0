From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 4/5] OMAP: hwmod data: Add dev_attr and use in the
 host driver
Date: Thu, 24 Feb 2011 11:59:51 +0100
Message-ID: <4D663A27.2010502@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com> <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298483231-29622-5-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
> Add a device attribute to hwmod data of omap2430, omap3, omap4.
> Currently the device attribute holds information regarding dual volt MMC card
> support by the controller which will be later passed to the host driver via
> platform data.
>
> Signed-off-by: Kevin Hilman<khilman@deeprootsystems.com>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>

There are few minor comments to fix hence the:
Almost-Acked-by: Benoit Cousson<b-cousson@ti.com>


> ---
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 +++++++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   16 ++++++++++++++++
>   arch/arm/plat-omap/include/plat/mmc.h      |   10 ++++++++++
>   drivers/mmc/host/omap_hsmmc.c              |    4 ++--
>   5 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 4d45b7d..e050355 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -19,6 +19,7 @@
>   #include<plat/i2c.h>
>   #include<plat/gpio.h>
>   #include<plat/mcspi.h>
> +#include<plat/mmc.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -1290,6 +1291,10 @@ static struct omap_hwmod_class mmc_class = {
>
>   /* MMC/SD/SDIO1 */
>
> +static struct mmc_dev_attr mmc1_dev_attr = {

Could you rename the struct omap_mmc_dev_attr to stick to the convention?

The dev_attr should be just above "static struct omap_hwmod". See the 
OMAP4 example below.

> +	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> +};
> +
>   static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
>   	{ .irq = 83 },
>   };
> @@ -1328,11 +1333,14 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
>   	.slaves		= omap2430_mmc1_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
>   	.class		=&mmc_class,
> +	.dev_attr	=&mmc1_dev_attr,

dev_attr should be above .slaves.

>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
>   };
>
>   /* MMC/SD/SDIO2 */
>
> +static struct mmc_dev_attr mmc2_dev_attr;

If you do not have any dev_attr for that instance, do not add it here 
and test for null pointer in your driver.
This comment applies for all instances in all OMAPs.

> +
>   static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
>   	{ .irq = 86 },
>   };
> @@ -1371,6 +1379,7 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
>   	.slaves		= omap2430_mmc2_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
>   	.class		=&mmc_class,
> +	.dev_attr	=&mmc2_dev_attr,

Not needed if there is not data in the structure.

[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index dd39e75..6c4ccfd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -25,6 +25,7 @@
>   #include<plat/gpio.h>
>   #include<plat/dma.h>
>   #include<plat/mcspi.h>
> +#include<plat/mmc.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -3383,6 +3384,10 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
>   };
>
>   /* mmc1 */
> +static struct mmc_dev_attr omap_mmc1_dev_attr = {
> +	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> +};
> +
>   static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
>   	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -3437,10 +3442,14 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
>   	.masters	= omap44xx_mmc1_masters,
>   	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
> +	.dev_attr	=&omap_mmc1_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* mmc2 */
> +static struct omap_hwmod omap44xx_mmc2_hwmod;
> +static struct mmc_dev_attr omap_mmc2_dev_attr;
> +
>   static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
>   	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -3495,11 +3504,13 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
>   	.masters	= omap44xx_mmc2_masters,
>   	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
> +	.dev_attr	=&omap_mmc2_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* mmc3 */
>   static struct omap_hwmod omap44xx_mmc3_hwmod;
> +static struct mmc_dev_attr omap_mmc3_dev_attr;
>   static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
>   	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -3547,11 +3558,13 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
>   	},
>   	.slaves		= omap44xx_mmc3_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc3_slaves),
> +	.dev_attr	=&omap_mmc3_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* mmc4 */
>   static struct omap_hwmod omap44xx_mmc4_hwmod;
> +static struct mmc_dev_attr omap_mmc4_dev_attr;
>   static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
>   	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -3599,11 +3612,13 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
>   	},
>   	.slaves		= omap44xx_mmc4_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc4_slaves),
> +	.dev_attr	=&omap_mmc4_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
>   /* mmc5 */
>   static struct omap_hwmod omap44xx_mmc5_hwmod;
> +static struct mmc_dev_attr omap_mmc5_dev_attr;
>   static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
>   	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
>   };
> @@ -3651,6 +3666,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
>   	},
>   	.slaves		= omap44xx_mmc5_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc5_slaves),
> +	.dev_attr	=&omap_mmc5_dev_attr,
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>

In order to be aligned with the generator, and assuming that only the 
mm1 needs dev_attr, the OMAP4 diff should be:

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..958651c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3420,6 +3420,11 @@ static struct omap_hwmod_ocp_if 
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
@@ -3433,6 +3438,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
  			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
  		},
  	},
+	.dev_attr	= &mmc1_dev_attr,
  	.slaves		= omap44xx_mmc1_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
  	.masters	= omap44xx_mmc1_masters,
---

Regards,
Benoit
