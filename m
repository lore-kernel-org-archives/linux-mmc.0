From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/6] mmc: sunxi: Always set signal delay to 0 for A64
Date: Tue, 10 Jan 2017 00:30:41 +0000
Message-ID: <96ba5fd8-d551-5993-f347-202c47efec8c@arm.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <5eff19eec2b110bb643a38e7fef221208f585589.1483980339.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5eff19eec2b110bb643a38e7fef221208f585589.1483980339.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/01/17 16:46, Maxime Ripard wrote:
> Experience have shown that the using the  autocalibration could severely
> degrade the performances of the MMC bus.
> 
> Allwinner is using in its BSP a delay set to 0 for all the modes but HS400.
> Remove the calibration code for now, and add comments to document our
> findings.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 50 ++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index b1d1303389a7..ea9552a0d820 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -683,41 +683,19 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  
>  static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
>  {
> -	u32 reg = readl(host->reg_base + reg_off);
> -	u32 delay;
> -	unsigned long timeout;
> -
>  	if (!host->cfg->can_calibrate)
>  		return 0;
>  
> -	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
> -	reg &= ~SDXC_CAL_DL_SW_EN;
> -
> -	writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
> -
> -	dev_dbg(mmc_dev(host->mmc), "calibration started\n");
> -
> -	timeout = jiffies + HZ * SDXC_CAL_TIMEOUT;
> -
> -	while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE)) {
> -		if (time_before(jiffies, timeout))
> -			cpu_relax();
> -		else {
> -			reg &= ~SDXC_CAL_START;
> -			writel(reg, host->reg_base + reg_off);
> -
> -			return -ETIMEDOUT;
> -		}
> -	}
> -
> -	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
> -
> -	reg &= ~SDXC_CAL_START;
> -	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
> -
> -	writel(reg, host->reg_base + reg_off);
> -
> -	dev_dbg(mmc_dev(host->mmc), "calibration ended, reg is 0x%x\n", reg);
> +	/*
> +	 * FIXME:
> +	 * This is not clear how the calibration is supposed to work
> +	 * yet. The best rate have been obtained by simply setting the
> +	 * delay to 0, as Allwinner does in its BSP.
> +	 *
> +	 * The only mode that doesn't have such a delay is HS400, that
> +	 * is in itself a TODO.
> +	 */
> +	writel(SDXC_CAL_DL_SW_EN, host->reg_base + reg_off);
>  
>  	return 0;
>  }
> @@ -806,7 +784,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  	if (ret)
>  		return ret;
>  
> -	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
> +	/*
> +	 * FIXME:
> +	 *
> +	 * In HS400 we'll also need to calibrate the data strobe
> +	 * signal. This should only happen on the MMC2 controller (at
> +	 * least on the A64 and older SoCs).

Which older SoCs have this calibration register and a DS signal?
Is that supposed to mean "other" SoCs?

Other than that:

Reviewed-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>

Cheers,
Andre.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
