From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: Handle return value of clk_prepare_enable
Date: Mon, 5 Jun 2017 13:52:54 +0300
Message-ID: <a952df70-c23d-aaa1-4a7c-9d4f3df3c695@intel.com>
References: <96cf6861af2a91afd7f836f6abcc4d35aa9bb449.1496658958.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbdFEK6x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Jun 2017 06:58:53 -0400
In-Reply-To: <96cf6861af2a91afd7f836f6abcc4d35aa9bb449.1496658958.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/06/17 13:48, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

It has already been done.  Check the 'next' branch in the mmc tree:
	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 40 ++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 23d8b8a..9ab64e73 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1250,9 +1250,17 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	pltfm_host->clk = imx_data->clk_per;
>  	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
> -	clk_prepare_enable(imx_data->clk_per);
> -	clk_prepare_enable(imx_data->clk_ipg);
> -	clk_prepare_enable(imx_data->clk_ahb);
> +	err = clk_prepare_enable(imx_data->clk_per);
> +	if (err)
> +		goto free_sdhci;
> +
> +	err = clk_prepare_enable(imx_data->clk_ipg);
> +	if (err)
> +		goto free_clk_per;
> +
> +	err = clk_prepare_enable(imx_data->clk_ahb);
> +	if (err)
> +		goto free_clk_ipg;
>  
>  	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>  	if (IS_ERR(imx_data->pinctrl)) {
> @@ -1314,9 +1322,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	return 0;
>  
>  disable_clk:
> -	clk_disable_unprepare(imx_data->clk_per);
> -	clk_disable_unprepare(imx_data->clk_ipg);
>  	clk_disable_unprepare(imx_data->clk_ahb);
> +free_clk_ipg:
> +	clk_disable_unprepare(imx_data->clk_ipg);
> +free_clk_per:
> +	clk_disable_unprepare(imx_data->clk_per);
>  free_sdhci:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1393,14 +1403,28 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>  
>  	if (!sdhci_sdio_irq_enabled(host)) {
> -		clk_prepare_enable(imx_data->clk_per);
> -		clk_prepare_enable(imx_data->clk_ipg);
> +		ret = clk_prepare_enable(imx_data->clk_per);
> +		if (ret)
> +			return ret;
> +		ret = clk_prepare_enable(imx_data->clk_ipg);
> +		if (ret)
> +			goto free_clk_per;
>  	}
> -	clk_prepare_enable(imx_data->clk_ahb);
> +	ret = clk_prepare_enable(imx_data->clk_ahb);
> +	if (ret)
> +		goto free_clk_ipg;
>  
>  	return sdhci_runtime_resume_host(host);
> +
> +free_clk_ipg:
> +	clk_disable_unprepare(imx_data->clk_ipg);
> +free_clk_per:
> +	clk_disable_unprepare(imx_data->clk_per);
> +	return ret;
> +
>  }
>  #endif
>  
> 

