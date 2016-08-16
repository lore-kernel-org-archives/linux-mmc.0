From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circurt when insert
 sd card
Date: Tue, 16 Aug 2016 17:04:40 +0800
Message-ID: <20160816090440.GC9211@shlinux2>
References: <1471255318-10933-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35575 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbcHPJOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2016 05:14:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so4986049pad.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Aug 2016 02:14:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1471255318-10933-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org

Hi Haibo,

On Mon, Aug 15, 2016 at 06:01:58PM +0800, Haibo Chen wrote:
> Current driver do not clear the tuning related register after
> plug out SD3.0 card. This will impact the timing and let other
> SD3.0 card inserted later meet CRC error.
> 
> e.g., after plug out a SDR104 card, and then plug in a DDR50 card,
> CRC error shows up:
> 
> mmc2: new ultra high speed DDR50 SDHC card at address aaaa
> mmcblk2: mmc2:aaaa SE08G 7.40 GiB
> mmcblk2: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
> mmc2: tried to reset card
>  mmcblk2: p1 p2
> 
> Logictally, we should reset USDHC include tuning circurt first when we
> plug in a sd/mmc/sdio card.

I'm thinking a bit more about the issue.

Can you check if the voltage setting will clear tuning bits during
mmc_power_up()?
Because the esdhc_writew_le(SDHCI_HOST_CONTROL2) seems will clear
it if no tuning bits set for a normal card.

And did you reproduce the issue with latest kernel?
If yes, please paste log and register dump which shows the issue
is caused by tuning bits.

Regards
Dong Aisheng

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ea7d086..2783a4b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -924,6 +924,30 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> +static void esdhc_hw_reset_for_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	sdhci_reset(host, SDHCI_RESET_ALL);
> +
> +	/* Rest the tuning circurt */
> +	if (esdhc_is_usdhc(imx_data)) {
> +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> +			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +			ctrl &= ~(ESDHC_MIX_CTRL_SMPCLK_SEL |
> +					ESDHC_MIX_CTRL_FBCLK_SEL);
> +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +			writel(0 << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +			ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
> +		}
> +	}
> +}
> +
>  static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -958,6 +982,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.set_bus_width = esdhc_pltfm_set_bus_width,
>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
>  	.reset = esdhc_reset,
> +	.hw_reset = esdhc_hw_reset_for_init,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> @@ -1223,7 +1248,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	if (esdhc_is_usdhc(imx_data)) {
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> -		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_HW_RESET;
>  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
