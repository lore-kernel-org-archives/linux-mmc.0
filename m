From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 1 Apr 2010 09:33:02 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45689 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab0DAEDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2010 00:03:10 -0400
In-Reply-To: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Madhu,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Chikkature Rajashekar, Madhusudhan
> Sent: 2010-04-01 05:56
> To: tony@atomide.com
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> Date: Wed, 31 Mar 2010 12:29:19 -0400
> Subject: [PATCH] Zoom2/3: Disable MMC
> 
> The eMMC on Zoom2/3 seems to have a lower EXT_CSD Rev.This causes the
> writes to fail since the card size is not detected correctly by the MMC
> core. Disable the MMC2 support for Zoom2/3.


[Ghorai] Please let us know the EXT_CSD Rev you see in zoom3 and the exact problem. Because we never face any issue for eMMC in ZOOM3. Because we have the same eMMC device in 3630-SDP and could have the same problem.

> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   30 ---------------------
> -----
>  1 files changed, 0 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 6b39849..ac791d2 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -102,10 +102,6 @@ static struct regulator_consumer_supply
> zoom_vsim_supply = {
>  	.supply		= "vmmc_aux",
>  };
> 
> -static struct regulator_consumer_supply zoom_vmmc2_supply = {
> -	.supply		= "vmmc",
> -};
> -
>  /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
>  static struct regulator_init_data zoom_vmmc1 = {
>  	.constraints = {
> @@ -121,21 +117,6 @@ static struct regulator_init_data zoom_vmmc1 = {
>  	.consumer_supplies      = &zoom_vmmc1_supply,
>  };
> 
> -/* VMMC2 for MMC2 card */
> -static struct regulator_init_data zoom_vmmc2 = {
> -	.constraints = {
> -		.min_uV			= 1850000,
> -		.max_uV			= 1850000,
> -		.apply_uV		= true,
> -		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> -					| REGULATOR_MODE_STANDBY,
> -		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> -					| REGULATOR_CHANGE_STATUS,
> -	},
> -	.num_consumer_supplies  = 1,
> -	.consumer_supplies      = &zoom_vmmc2_supply,
> -};
> -
>  /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
>  static struct regulator_init_data zoom_vsim = {
>  	.constraints = {
> @@ -159,15 +140,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  		.gpio_wp	= -EINVAL,
>  		.power_saving	= true,
>  	},
> -	{
> -		.name		= "internal",
> -		.mmc		= 2,
> -		.wires		= 8,
> -		.gpio_cd	= -EINVAL,
> -		.gpio_wp	= -EINVAL,
> -		.nonremovable	= true,
> -		.power_saving	= true,
> -	},
>  	{}      /* Terminator */
>  };
> 
> @@ -183,7 +155,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
>  	*/
>  	zoom_vmmc1_supply.dev = mmc[0].dev;
>  	zoom_vsim_supply.dev = mmc[0].dev;
> -	zoom_vmmc2_supply.dev = mmc[1].dev;
> 
>  	return 0;
>  }
> @@ -241,7 +212,6 @@ static struct twl4030_platform_data zoom_twldata = {
>  	.keypad		= &zoom_kp_twl4030_data,
>  	.codec		= &zoom_codec_data,
>  	.vmmc1          = &zoom_vmmc1,
> -	.vmmc2          = &zoom_vmmc2,
>  	.vsim           = &zoom_vsim,
> 
>  };
> --
> 1.6.3.3
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
