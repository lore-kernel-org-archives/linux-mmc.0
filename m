From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Wed, 1 Jun 2011 00:41:34 -0700
Message-ID: <20110601074134.GX11352@atomide.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
 <1306765534-20103-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35519 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259Ab1FAHlh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 03:41:37 -0400
Content-Disposition: inline
In-Reply-To: <1306765534-20103-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

* Balaji T K <balajitk@ti.com> [110530 07:23]:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
> 
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index b2f30be..3f8dc16 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -145,6 +145,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>  				 int power_on, int vdd)
>  {
>  	u32 reg;
> +	unsigned long timeout;
>  
>  	if (power_on) {
>  		reg = omap4_ctrl_pad_readl(control_pbias_offset);
> @@ -157,9 +158,15 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>  			OMAP4_MMC1_PWRDNZ_MASK |
>  			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
>  		omap4_ctrl_pad_writel(reg, control_pbias_offset);
> -		/* 4 microsec delay for comparator to generate an error*/
> -		udelay(4);
> -		reg = omap4_ctrl_pad_readl(control_pbias_offset);
> +
> +		timeout = jiffies + msecs_to_jiffies(5);
> +		do {
> +			reg = omap4_ctrl_pad_readl(control_pbias_offset);
> +			if (!(reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK))
> +				break;
> +			udelay(100);
> +		} while (!time_after(jiffies, timeout));
> +
>  		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
>  			pr_err("Pbias Voltage is not same as LDO\n");
>  			/* Caution : On VMODE_ERROR Power Down MMC IO */

Actually, can you check if you can use usleep_range here as recommended
by checkpatch.pl?

Tony
