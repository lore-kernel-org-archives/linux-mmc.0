From: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v4 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
Date: Fri, 7 Aug 2015 15:40:20 +0800
Message-ID: <20150807074019.GB6935@shlinux1.ap.freescale.net>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
 <1438771122-8601-3-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438771122-8601-3-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, johan.derycke-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 05, 2015 at 06:38:38PM +0800, Haibo Chen wrote:
> tuning-step is the delay cell steps in tuning procedure. The default value
> of tuning-step is 1. Some boards or cards need another value to pass the
> tuning procedure. For example, imx7d-sdb board need the tuning-step value
> as 2, otherwise it can't pass the tuning procedure.
> 
> So this patch add the tuning-step setting in driver, so that user can set
> the tuning-step value in dts.
> 
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 9 +++++++++
>  include/linux/platform_data/mmc-esdhc-imx.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 48f009c..803d24f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -75,6 +75,7 @@
>  #define ESDHC_STD_TUNING_EN		(1 << 24)
>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
>  #define ESDHC_TUNING_START_TAP		0x1
> +#define ESDHC_TUNING_STEP_SHIFT		16
>  
>  /* pinctrl state */
>  #define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
> @@ -474,6 +475,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
>  			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +			u32 tuning_ctrl;
>  			if (val & SDHCI_CTRL_TUNED_CLK) {
>  				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
>  			} else {
> @@ -484,6 +486,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  			if (val & SDHCI_CTRL_EXEC_TUNING) {
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
>  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> +				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> +				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
> +				if (imx_data->boarddata.tuning_step)
> +					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
> +					writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);

Is there a code indent issue here?
Otherwise, the patch looks good to me.

Regards
Dong Aisheng

>  			} else {
>  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>  			}
> @@ -964,6 +971,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (gpio_is_valid(boarddata->wp_gpio))
>  		boarddata->wp_type = ESDHC_WP_GPIO;
>  
> +	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
> +
>  	if (of_find_property(np, "no-1-8-v", NULL))
>  		boarddata->support_vsel = false;
>  	else
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index e1571ef..95ccab3 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -45,5 +45,6 @@ struct esdhc_platform_data {
>  	int max_bus_width;
>  	bool support_vsel;
>  	unsigned int delay_line;
> +	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>  };
>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
