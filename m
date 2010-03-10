From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
 autoloading feature
Date: Wed, 10 Mar 2010 14:41:10 -0800
Message-ID: <20100310224110.GW2900@atomide.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55435 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354Ab0CJWjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 17:39:53 -0500
Content-Disposition: inline
In-Reply-To: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

* Venkatraman S <svenkatr@ti.com> [100310 06:08]:
> @@ -1400,14 +1471,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
> *host, struct mmc_request *req)
>  					| (req->data->blocks << 16));
>  	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
> 
> -	if (host->use_dma) {
> -		ret = omap_hsmmc_start_dma_transfer(host, req);
> -		if (ret != 0) {
> -			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
> +	if (host->dma_caps & DMA_TYPE_SDMA) {
> +		ret = omap_hsmmc_configure_sdma(host, req);
> +		if (ret)
>  			return ret;
> -		}
> +		host->dma_in_use = DMA_TYPE_SDMA;
>  	}
> -	return 0;
> +	if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
> +		host->data->sg_len > 4) {
> +		ret = omap_hsmmc_configure_sdma_sglist(host, req);
> +		if (ret)
> +			return ret;
> +		host->dma_in_use = DMA_TYPE_SDMA_DLOAD;
> +
> +	}
> +	ret = omap_hsmmc_start_dma_transfer(host);
> +	return ret;
> +
>  }

Does the driver still work in PIO mode?

We need to have the drivers capable to fail over to PIO mode
as the DMA channels can run out.

Regards,

Tony
