From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap4: hsmmc: Fix Pbias configuration on
 regulator OFF
Date: Thu, 29 Sep 2011 09:20:06 -0700
Message-ID: <20110929162006.GG6324@atomide.com>
References: <1317307500-5514-1-git-send-email-balajitk@ti.com>
 <1317307500-5514-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62221 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754552Ab1I2QUJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 12:20:09 -0400
Content-Disposition: inline
In-Reply-To: <1317307500-5514-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com

* Balaji T K <balajitk@ti.com> [110929 07:11]:
> MMC1 data line IO's are powered down in before set regulator function.
> IO's should not be powered ON when regulator is OFF.
> Keep the IO's in power pown mode after regulator OFF.
> Delete incorrect comments which are not applicable for OMAP4.

Care to check how this is different from what I added into fixes
branch as commit 3fe8df93b0992199e3a0026fc51e90b705f94e40?

Is this a separate issue?

Tony

 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Reported-by: Viswanath Puttagunta <vishp@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 097a42d..9cc2eb7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -129,15 +129,11 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
>  	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
>  	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
>  	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
> -	 *
> -	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
> -	 * is most naturally TWL VSIM; those pins also use PBIAS.
> -	 *
> -	 * FIXME handle VMMC1A as needed ...
>  	 */
>  	reg = omap4_ctrl_pad_readl(control_pbias_offset);
>  	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
> -		OMAP4_MMC1_PWRDNZ_MASK);
> +		OMAP4_MMC1_PWRDNZ_MASK |
> +		OMAP4_MMC1_PBIASLITE_VMODE_MASK);
>  	omap4_ctrl_pad_writel(reg, control_pbias_offset);
>  }
>  
> @@ -172,12 +168,6 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>  			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
>  			omap4_ctrl_pad_writel(reg, control_pbias_offset);
>  		}
> -	} else {
> -		reg = omap4_ctrl_pad_readl(control_pbias_offset);
> -		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
> -			OMAP4_MMC1_PWRDNZ_MASK |
> -			OMAP4_MMC1_PBIASLITE_VMODE_MASK);
> -		omap4_ctrl_pad_writel(reg, control_pbias_offset);
>  	}
>  }
>  
> -- 
> 1.7.0.4
> 
