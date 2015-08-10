From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v5 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting
 support
Date: Mon, 10 Aug 2015 16:25:01 +0800
Message-ID: <20150810082500.GB15036@shlinux1.ap.freescale.net>
References: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
 <1439194688-18335-3-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:64704
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752830AbbHJIe5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 04:34:57 -0400
Content-Disposition: inline
In-Reply-To: <1439194688-18335-3-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, johan.derycke@barco.com, mkl@pengutronix.de, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Mon, Aug 10, 2015 at 04:18:04PM +0800, Haibo Chen wrote:
> tuning-step is the delay cell steps in tuning procedure. The default value
> of tuning-step is 1. Some boards or cards need another value to pass the
> tuning procedure. For example, imx7d-sdb board need the tuning-step value
> as 2, otherwise it can't pass the tuning procedure.
> 
> So this patch add the tuning-step setting in driver, so that user can set
> the tuning-step value in dts.
> 

Fix a typo.

For patch title:
mmc: sdhci-esdhc-imx: add tuning-step seting support
s/seting/setting

Regards
Dong Aisheng

> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 9 +++++++++
>  include/linux/platform_data/mmc-esdhc-imx.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2a816ad..03c9f33 100644
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
>  			} else {
>  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>  			}
> @@ -965,6 +972,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
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
