From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: don't print uninitialized variables
Date: Tue, 26 Jan 2016 11:37:15 -0800
Message-ID: <20160126193714.GA19432@atomide.com>
References: <3411189.gO0215GrNM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:57706 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbcAZThS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Jan 2016 14:37:18 -0500
Content-Disposition: inline
In-Reply-To: <3411189.gO0215GrNM@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Arnd Bergmann <arnd@arndb.de> [160126 07:28]:
> When DT based probing is used but the DMA request fails, the
> driver will print uninitialized stack data from the rx_req
> and tx_req variables, as indicated by this warning:
> 
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
> drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> 
> This removes the DMA request line number from the warning, which
> is the easiest solution and won't hurt us any more as we are
> planning to remove the legacy code path anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> A simpler patch as v1 with the same result, as suggested by Peter Ujfalusi.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b6639ea0bf18..87f0d840a166 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2159,7 +2159,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  						 &rx_req, &pdev->dev, "rx");
>  
>  	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
> @@ -2169,7 +2169,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  						 &tx_req, &pdev->dev, "tx");
>  
>  	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
>  		ret = -ENXIO;
>  		goto err_irq;
>  	}
> 
