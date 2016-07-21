From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 12/15] mmc: sdhci-esdhc-imx: factor out hw related
 initialization into function
Date: Thu, 21 Jul 2016 11:11:27 +0300
Message-ID: <579083AF.1040403@intel.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-13-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9593 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbcGUIPr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2016 04:15:47 -0400
In-Reply-To: <1468309584-3591-13-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 12/07/16 10:46, Dong Aisheng wrote:
> Move all hw related static initializations into a separate function
> which helps concentrate the hw related initialization code.
> And that function could also be called by other places later as a
> basic hw state restore.
> e.g. suspend/resume where the hw state is possible to lost due to
> low power mode.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 72 +++++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index bbb0bd4eac28..5a0e5dee977f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -979,6 +979,44 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
>  	.ops = &sdhci_esdhc_ops,
>  };
>  
> +static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (esdhc_is_usdhc(imx_data)) {
> +		/*
> +		 * The imx6q ROM code will change the default watermark
> +		 * level setting to something insane.  Change it back here.
> +		 */
> +		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
> +
> +		/*
> +		 * ROM code will change the bit burst_length_enable setting
> +		 * to zero if this usdhc is choosed to boot system. Change
> +		 * it back here, otherwise it will impact the performance a
> +		 * lot. This bit is used to enable/disable the burst length
> +		 * for the external AHB2AXI bridge, it's usefully especially
> +		 * for INCR transfer because without burst length indicator,
> +		 * the AHB2AXI bridge does not know the burst length in
> +		 * advance. And without burst length indicator, AHB INCR
> +		 * transfer can only be converted to singles on the AXI side.
> +		 */
> +		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
> +			| ESDHC_BURST_LEN_EN_INCR,
> +			host->ioaddr + SDHCI_HOST_CONTROL);
> +		/*
> +		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
> +		* TO1.1, it's harmless for MX6SL
> +		*/
> +		writel(readl(host->ioaddr + 0x6c) | BIT(7),
> +			host->ioaddr + 0x6c);
> +
> +		/* disable DLL_CTRL delay line settings */
> +		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> +	}
> +}
> +
>  #ifdef CONFIG_OF
>  static int
>  sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> @@ -1176,43 +1214,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
>  			| SDHCI_QUIRK_BROKEN_ADMA;
>  
> -	/*
> -	 * The imx6q ROM code will change the default watermark level setting
> -	 * to something insane.  Change it back here.
> -	 */
>  	if (esdhc_is_usdhc(imx_data)) {
> -		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
> -
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> -
> -		/*
> -		 * ROM code will change the bit burst_length_enable setting
> -		 * to zero if this usdhc is choosed to boot system. Change
> -		 * it back here, otherwise it will impact the performance a
> -		 * lot. This bit is used to enable/disable the burst length
> -		 * for the external AHB2AXI bridge, it's usefully especially
> -		 * for INCR transfer because without burst length indicator,
> -		 * the AHB2AXI bridge does not know the burst length in
> -		 * advance. And without burst length indicator, AHB INCR
> -		 * transfer can only be converted to singles on the AXI side.
> -		 */
> -		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
> -			| ESDHC_BURST_LEN_EN_INCR,
> -			host->ioaddr + SDHCI_HOST_CONTROL);
> -
>  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> -
> -		/*
> -		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
> -		* TO1.1, it's harmless for MX6SL
> -		*/
> -		writel(readl(host->ioaddr + 0x6c) | BIT(7),
> -			host->ioaddr + 0x6c);
> -
> -		/* disable DLL_CTRL delay line settings */
> -		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
>  	}
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
> @@ -1237,6 +1243,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (err)
>  		goto disable_clk;
>  
> +	sdhci_esdhc_imx_hwinit(host);
> +
>  	err = sdhci_add_host(host);
>  	if (err)
>  		goto disable_clk;
> 

