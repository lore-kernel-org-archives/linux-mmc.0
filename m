From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
Date: Fri, 1 Oct 2010 20:32:39 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C50E@dbde02.ent.ti.com>
References: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34540 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724Ab0JAPCs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2010 11:02:48 -0400
In-Reply-To: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@li
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>




> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Kadiyala, Kishore
> Sent: Saturday, September 18, 2010 10:04 PM
> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> Cc: khilman@deeprootsystems.com; Cousson, Benoit
> Subject: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
> 
> The offset handling implementation of omap4 mmc registers 
> which was already present can't be reused once hwmod 
> modifications are done for mmc driver.
> Since hwmod data file for OMAP4 is an auto generated the base 
> address for MMC will remain same as OMAP3 and thus the offset 
> deviation of registers should be updated in the hsmmc driver.
> The omap-mmc platform data is updated with a register offset 
> which will be updated and used in the driver accordingly.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c         |    8 +++-----
>  arch/arm/mach-omap2/hsmmc.c           |    4 ++++
>  arch/arm/plat-omap/include/plat/mmc.h |    3 +++
>  drivers/mmc/host/omap_hsmmc.c         |    2 +-
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c 
> b/arch/arm/mach-omap2/devices.c index 2dbb265..bb7ec13 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -745,13 +745,13 @@ void __init omap2_init_mmc(struct 
> omap_mmc_platform_data **mmc_data,
>  		case 3:
>  			if (!cpu_is_omap44xx())
>  				return;
> -			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
> +			base = OMAP4_MMC4_BASE;
>  			irq = OMAP44XX_IRQ_MMC4;
>  			break;
>  		case 4:
>  			if (!cpu_is_omap44xx())
>  				return;
> -			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
> +			base = OMAP4_MMC5_BASE;
>  			irq = OMAP44XX_IRQ_MMC5;
>  			break;
>  		default:
> @@ -762,10 +762,8 @@ void __init omap2_init_mmc(struct 
> omap_mmc_platform_data **mmc_data,
>  			size = OMAP2420_MMC_SIZE;
>  			name = "mmci-omap";
>  		} else if (cpu_is_omap44xx()) {
> -			if (i < 3) {
> -				base += OMAP4_MMC_REG_OFFSET;
> +			if (i < 3)
>  				irq += OMAP44XX_IRQ_GIC_START;
> -			}
>  			size = OMAP4_HSMMC_SIZE;
>  			name = "mmci-omap-hs";
>  		} else {
> diff --git a/arch/arm/mach-omap2/hsmmc.c 
> b/arch/arm/mach-omap2/hsmmc.c index c8f647b..49d76a7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -261,6 +261,10 @@ void __init omap2_hsmmc_init(struct 
> omap2_hsmmc_info *controllers)
>  		mmc->slots[0].wires = c->wires;
>  		mmc->slots[0].internal_clock = !c->ext_clock;
>  		mmc->dma_mask = 0xffffffff;
> +		if (cpu_is_omap44xx())
> +			mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
> +		else
> +			mmc->reg_offset = 0;

1. Since you mentioned that, this is useful for hwmod, the 
register offsets should use enum and static tables. You can
refer to i2c-omap.c for more details and dma hwmod review 
comments for more details.
https://patchwork.kernel.org/patch/126251/

2. Replace macros with inline functions for low level read/write
functions.

 -Manjunath
