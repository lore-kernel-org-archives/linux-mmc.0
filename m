From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v2 1/5] OMAP4-HSMMC: Adding HSMMC support for OMAP4430
      Board file
Date: Wed, 05 May 2010 13:32:37 +0300
Message-ID: <4BE14945.5040300@nokia.com>
References: <35156.10.24.255.17.1272988883.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <35156.10.24.255.17.1272988883.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

kishore kadiyala wrote:
> This patch adds MMC1 and MMC2 Controller data for OMAP4430 Board
> file.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile        |    3 +-
>  arch/arm/mach-omap2/board-4430sdp.c |   39 ++++++++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ffe600a..65d8d11 100644
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
> index f1b9708..c4e61d5 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -33,6 +33,7 @@
>  #include <plat/control.h>
>  #include <plat/timer-gp.h>
>  #include <plat/usb.h>
> +#include "hsmmc.h"
> 
>  #define ETHERNET_KS8851_IRQ		34
>  #define ETHERNET_KS8851_POWER_ENABLE	48
> @@ -93,16 +94,27 @@ static struct omap_musb_board_data musb_board_data = {
>  	.power			= 100,
>  };
> 
> -static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> +static struct omap2_hsmmc_info mmc[] = {
>  	{
> -		.supply = "vmmc",
> +		.mmc		= 1,
> +		.wires		= 8,
> +		/* "mmc0_cd" is not a gpio interrupt
> +		 * but is a phoenix interrupt
> +		 */
> +		.gpio_cd	= TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET,
> +		.gpio_wp	= -EINVAL,
>  	},
>  	{
> -		.supply = "vmmc",
> -	},
> -	{
> -		.supply = "vmmc",
> +		.mmc		= 2,
> +		.wires		= 8,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +		.nonremovable   = true,
>  	},
> +	{}	/* Terminator */
> +};
> +
> +static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
>  	{
>  		.supply = "vmmc",
>  	},
> @@ -111,6 +123,18 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
>  	},
>  };
> 
> +static int __init sdp4430_mmc_init(void)
> +{
> +	omap2_hsmmc_init(mmc);
> +
> +	/* link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	 */
> +	sdp4430_vmmc_supply[0].dev = mmc[0].dev;
> +	sdp4430_vmmc_supply[1].dev = mmc[1].dev;

Can do this instead I think:

static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
	{
		.supply		= "vmmc",
		.dev_name	= "mmci-omap-hs.0",
	},
	{
		.supply		= "vmmc",
		.dev_name	= "mmci-omap-hs.1",
	},
};




> +	return 0;
> +}
> +
>  static struct regulator_init_data sdp4430_vaux1 = {
>  	.constraints = {
>  		.min_uV			= 1000000,
> @@ -162,7 +186,7 @@ static struct regulator_init_data sdp4430_vmmc = {
>  					| REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies  = 5,
> +	.num_consumer_supplies  = 2,
>  	.consumer_supplies      = sdp4430_vmmc_supply,
>  };
> 
> @@ -281,6 +305,7 @@ static void __init omap_4430sdp_init(void)
>  	omap4_i2c_init();
>  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
>  	omap_serial_init();
> +	sdp4430_mmc_init();
>  	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
>  	usb_nop_xceiv_register();
>  	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */

