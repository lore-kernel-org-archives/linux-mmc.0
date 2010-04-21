From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] OMAP4-HSMMC: Adding HSMMC support for OMAP4430
 Board file
Date: Wed, 21 Apr 2010 11:47:51 -0700
Message-ID: <20100421184751.GG18272@atomide.com>
References: <63411.10.24.255.18.1271873995.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63411.10.24.255.18.1271873995.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

* kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:15]:
> This patch adds MMC1 and MMC2 Controller support for OMAP4430 Board
> file.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile        |    3 +-
>  arch/arm/mach-omap2/board-4430sdp.c |   39 +++++++++++++++++++++++++++-------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4b9fc57..40b291a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -140,7 +140,8 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
>  					   hsmmc.o
> -obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
> +obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
> +					   hsmmc.o
> 
>  obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 32cbd72..eae7c80 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -33,6 +33,7 @@
>  #include <plat/usb.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include "hsmmc.h"
> 
>  static struct platform_device sdp4430_lcd_device = {
>  	.name		= "sdp4430_lcd",
> @@ -80,17 +81,27 @@ static int __init omap_l2_cache_init(void)
>  early_initcall(omap_l2_cache_init);
>  #endif
> 
> -
> -static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> -	{
> -		.supply = "vmmc",
> -	},
> +static struct omap2_hsmmc_info mmc[] = {
>  	{
> -		.supply = "vmmc",
> +		.mmc		= 1,
> +		.wires		= 8,
> +		/* "mmc0_cd" is not a gpio interrupt
> +		 * but is a phoenix interrupt
> +		 */
> +		.gpio_cd	= 384,

You can't use hardcoded irq numbers for twl interrupts. They can change.
See sdp3430_twl_gpio_setup() for example.

Tony
