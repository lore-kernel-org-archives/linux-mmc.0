From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Check the return value from
 clk_prepare_enable()
Date: Wed, 9 Oct 2013 09:42:09 +0800
Message-ID: <20131009014208.GD8946@S2101-09.ap.freescale.net>
References: <1381240048-22685-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:6847
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494Ab3JIBly (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 21:41:54 -0400
Content-Disposition: inline
In-Reply-To: <1381240048-22685-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: cjb@laptop.org, festevam@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 08, 2013 at 10:47:28AM -0300, Fabio Estevam wrote:
> clk_prepare_enable() may fail, so let's check its return value and propagate it
> in the case of error.
> 
> Also, fix the sequence for disabling the clock in the probe error path and 
> also in the remove function.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b9899e9..abc9836 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -877,9 +877,17 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	pltfm_host->clk = imx_data->clk_per;
>  
> -	clk_prepare_enable(imx_data->clk_per);
> -	clk_prepare_enable(imx_data->clk_ipg);
> -	clk_prepare_enable(imx_data->clk_ahb);
> +	err = clk_prepare_enable(imx_data->clk_per);
> +	if (err)
> +		goto free_sdhci;
> +
> +	err = clk_prepare_enable(imx_data->clk_ipg);
> +	if (err)
> +		goto err_ipg;
> +
> +	err = clk_prepare_enable(imx_data->clk_ahb);
> +	if (err)
> +		goto err_ahb;
>  
>  	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>  	if (IS_ERR(imx_data->pinctrl)) {
> @@ -995,9 +1003,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	return 0;
>  
>  disable_clk:
> -	clk_disable_unprepare(imx_data->clk_per);
> -	clk_disable_unprepare(imx_data->clk_ipg);
>  	clk_disable_unprepare(imx_data->clk_ahb);
> +err_ahb:

Naming schema of the existing labels seems to be 'acting' rather than
'reasoning', so I guess 'disable_ipg:' might fit here better?

Shawn

> +	clk_disable_unprepare(imx_data->clk_ipg);
> +err_ipg:
> +	clk_disable_unprepare(imx_data->clk_per);
>  free_sdhci:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1012,9 +1022,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  
>  	sdhci_remove_host(host, dead);
>  
> -	clk_disable_unprepare(imx_data->clk_per);
> -	clk_disable_unprepare(imx_data->clk_ipg);
>  	clk_disable_unprepare(imx_data->clk_ahb);
> +	clk_disable_unprepare(imx_data->clk_ipg);
> +	clk_disable_unprepare(imx_data->clk_per);
>  
>  	sdhci_pltfm_free(pdev);
>  
> -- 
> 1.8.1.2
> 
> 

