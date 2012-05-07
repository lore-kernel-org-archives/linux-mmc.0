From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 05/10] mmc: mxs-mmc: use devm_* helper to make cleanup simpler
Date: Tue, 8 May 2012 01:49:58 +0200
Message-ID: <201205080149.59012.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org> <1336401793-13753-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40375 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab2EGX6e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 19:58:34 -0400
In-Reply-To: <1336401793-13753-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

Dear Shawn Guo,

> Use devm_request_and_ioremap and devm_request_irq helpers to clean up
> the code a little bit.

Nice :)

btw do we have i2c dt bindings ?

Acked-by: Marek Vasut <marex@denx.de>
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |   40 +++++++++-------------------------------
>  1 files changed, 9 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index c70c7c7..1a8ba314 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -146,8 +146,6 @@ struct mxs_mmc_host {
>  	struct mmc_data			*data;
> 
>  	void __iomem			*base;
> -	int				irq;
> -	struct resource			*res;
>  	struct resource			*dma_res;
>  	struct clk			*clk;
>  	unsigned int			clk_rate;
> @@ -695,7 +693,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  {
>  	struct mxs_mmc_host *host;
>  	struct mmc_host *mmc;
> -	struct resource *iores, *dmares, *r;
> +	struct resource *iores, *dmares;
>  	struct mxs_mmc_platform_data *pdata;
>  	struct pinctrl *pinctrl;
>  	int ret = 0, irq_err, irq_dma;
> @@ -708,28 +706,20 @@ static int mxs_mmc_probe(struct platform_device
> *pdev) if (!iores || !dmares || irq_err < 0 || irq_dma < 0)
>  		return -EINVAL;
> 
> -	r = request_mem_region(iores->start, resource_size(iores), pdev->name);
> -	if (!r)
> -		return -EBUSY;
> -
>  	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
> -	if (!mmc) {
> -		ret = -ENOMEM;
> -		goto out_release_mem;
> -	}
> +	if (!mmc)
> +		return -ENOMEM;
> 
>  	host = mmc_priv(mmc);
> -	host->base = ioremap(r->start, resource_size(r));
> +	host->base = devm_request_and_ioremap(&pdev->dev, iores);
>  	if (!host->base) {
> -		ret = -ENOMEM;
> +		ret = -EADDRNOTAVAIL;
>  		goto out_mmc_free;
>  	}
> 
>  	host->devid = pdev->id_entry->driver_data;
>  	host->mmc = mmc;
> -	host->res = r;
>  	host->dma_res = dmares;
> -	host->irq = irq_err;
>  	host->sdio_irq_en = 0;
> 
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> @@ -741,7 +731,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	host->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(host->clk)) {
>  		ret = PTR_ERR(host->clk);
> -		goto out_iounmap;
> +		goto out_mmc_free;
>  	}
>  	clk_prepare_enable(host->clk);
> 
> @@ -782,7 +772,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, mmc);
> 
> -	ret = request_irq(host->irq, mxs_mmc_irq_handler, 0, DRIVER_NAME, host);
> +	ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
> +			       DRIVER_NAME, host);
>  	if (ret)
>  		goto out_free_dma;
> 
> @@ -790,26 +781,20 @@ static int mxs_mmc_probe(struct platform_device
> *pdev)
> 
>  	ret = mmc_add_host(mmc);
>  	if (ret)
> -		goto out_free_irq;
> +		goto out_free_dma;
> 
>  	dev_info(mmc_dev(host->mmc), "initialized\n");
> 
>  	return 0;
> 
> -out_free_irq:
> -	free_irq(host->irq, host);
>  out_free_dma:
>  	if (host->dmach)
>  		dma_release_channel(host->dmach);
>  out_clk_put:
>  	clk_disable_unprepare(host->clk);
>  	clk_put(host->clk);
> -out_iounmap:
> -	iounmap(host->base);
>  out_mmc_free:
>  	mmc_free_host(mmc);
> -out_release_mem:
> -	release_mem_region(iores->start, resource_size(iores));
>  	return ret;
>  }
> 
> @@ -817,12 +802,9 @@ static int mxs_mmc_remove(struct platform_device
> *pdev) {
>  	struct mmc_host *mmc = platform_get_drvdata(pdev);
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> -	struct resource *res = host->res;
> 
>  	mmc_remove_host(mmc);
> 
> -	free_irq(host->irq, host);
> -
>  	platform_set_drvdata(pdev, NULL);
> 
>  	if (host->dmach)
> @@ -831,12 +813,8 @@ static int mxs_mmc_remove(struct platform_device
> *pdev) clk_disable_unprepare(host->clk);
>  	clk_put(host->clk);
> 
> -	iounmap(host->base);
> -
>  	mmc_free_host(mmc);
> 
> -	release_mem_region(res->start, resource_size(res));
> -
>  	return 0;
>  }

Best regards,
Marek Vasut
