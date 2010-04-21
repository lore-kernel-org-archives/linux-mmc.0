From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] OMAP4-HSMMC: Addind MMC-TWL regulator changes
Date: Wed, 21 Apr 2010 14:00:24 -0700
Message-ID: <20100421210023.GI18272@atomide.com>
References: <63579.10.24.255.18.1271874048.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49632 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab0DUVAd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2010 17:00:33 -0400
Content-Disposition: inline
In-Reply-To: <63579.10.24.255.18.1271874048.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

* kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:16]:
> This patch adds PBIAS Configuration during POWER ON and OFF.
> Also it adds MMC1 Card detect configuration on Phoenix
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c               |  145 +++++++++++++++++++++++------
>  arch/arm/plat-omap/include/plat/control.h |   17 ++++
>  2 files changed, 134 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index ca3d4c9..7653434 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -26,11 +26,18 @@
> 
>  static u16 control_pbias_offset;
>  static u16 control_devconf1_offset;
> +static u16 control_mmc1;
> 
>  #define HSMMC_NAME_LEN	9
> 
>  /* Phoenix Registers */
> -#define TWL6030_MMCCTRL	0xEE
> +#define TWL6030_MMCCTRL		0xEE
> +#define VMMC_AUTO_OFF		(0x1 << 3)
> +#define SW_FC			(0x1 << 2)
> +
> +#define TWL6030_CFG_INPUT_PUPD3	0xF2
> +#define MMC_PU			(0x1 << 3)
> +#define MMC_PD			(0x1 << 2)

These defines need to go to twl code.
 
>  static struct hsmmc_controller {
>  	struct omap_mmc_platform_data   *mmc;
> @@ -120,27 +127,38 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
>  				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
>  			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
>  		}
> +		if (!cpu_is_omap44xx()) {
> +			if (mmc->slots[0].internal_clock) {
> +				reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> +				reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> +				omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> +			}
> 
> -		if (mmc->slots[0].internal_clock) {
> -			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> -			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> -		}
> -
> -		reg = omap_ctrl_readl(control_pbias_offset);
> -		if (cpu_is_omap3630()) {
> -			/* Set MMC I/O to 52Mhz */
> -			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> -			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
> -			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
> +			reg = omap_ctrl_readl(control_pbias_offset);
> +			if (cpu_is_omap3630()) {
> +				/* Set MMC I/O to 52Mhz */
> +				prog_io =
> +				omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> +				prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
> +				omap_ctrl_writel(prog_io,
> +						OMAP343X_CONTROL_PROG_IO1);
> +			} else {
> +				reg |= OMAP2_PBIASSPEEDCTRL0;
> +			}
> +			reg &= ~OMAP2_PBIASLITEPWRDNZ0;
>  		} else {
> -			reg |= OMAP2_PBIASSPEEDCTRL0;
> +			reg = omap_ctrl_readl(control_pbias_offset);
> +			reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +						OMAP4_MMC1_PWRDNZ);
>  		}
> -		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
>  		omap_ctrl_writel(reg, control_pbias_offset);
>  	} else {
>  		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> +		if (!cpu_is_omap44xx())
> +			reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> +		else
> +			reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +					OMAP4_MMC1_PWRDNZ);
>  		omap_ctrl_writel(reg, control_pbias_offset);
>  	}
>  }
> @@ -155,16 +173,36 @@ static void hsmmc1_after_set_reg(struct device *dev, int slot,
> 
>  	if (power_on) {
>  		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
> -		if ((1 << vdd) <= MMC_VDD_165_195)
> -			reg &= ~OMAP2_PBIASLITEVMODE0;
> +		if (!cpu_is_omap44xx())
> +			reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
>  		else
> -			reg |= OMAP2_PBIASLITEVMODE0;
> +			reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ;
> +		if ((1 << vdd) <= MMC_VDD_165_195) {
> +			if (!cpu_is_omap44xx()) {
> +				reg &= ~OMAP2_PBIASLITEVMODE0;
> +			} else {
> +				reg &= ~OMAP4_MMC1_PBIASLITE_VMODE;
> +				reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +						OMAP4_MMC1_PWRDNZ);
> +			}
> +		} else {
> +			if (!cpu_is_omap44xx())
> +				reg |= OMAP2_PBIASLITEVMODE0;
> +			else
> +				reg |= (OMAP4_MMC1_PBIASLITE_VMODE |
> +				OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +					OMAP4_MMC1_PWRDNZ);
> +		}
>  		omap_ctrl_writel(reg, control_pbias_offset);
>  	} else {
>  		reg = omap_ctrl_readl(control_pbias_offset);
> -		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
> -			OMAP2_PBIASLITEVMODE0);
> +		if (!cpu_is_omap44xx())
> +			reg |= (OMAP2_PBIASSPEEDCTRL0 |
> +				OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASLITEVMODE0);
> +		else
> +			 reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +				OMAP4_MMC1_PBIASLITE_VMODE |
> +				OMAP4_MMC1_PWRDNZ);
>  		omap_ctrl_writel(reg, control_pbias_offset);
>  	}
>  }

This all should be set once during init. Please don't sprinkle
cpu_is_omapxxxx() tests all over the code. That makes the code
hard to maintain.

Instead, please just register the omap4 specific functions
once during init. If something cannot be currently defined
that way, making that change should be a separate patch
before adding the omap4 code.

Regards,

Tony
