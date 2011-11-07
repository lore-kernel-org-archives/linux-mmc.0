From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] mmc: omap_hsmmc: DMA unmap only once in case of
	MMC error
Date: Mon, 7 Nov 2011 18:29:39 +0000
Message-ID: <20111107182939.GF15294@n2100.arm.linux.org.uk>
References: <1320683111-12577-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48302 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1KGS3t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2011 13:29:49 -0500
Content-Disposition: inline
In-Reply-To: <1320683111-12577-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>

On Mon, Nov 07, 2011 at 09:55:11PM +0530, Balaji T K wrote:
> From: Per Forlin <per.forlin@linaro.org>
> 
> Reported by Russell King:
> mmcblk0: error -84 transferring data, sector 149201, nr 64,
> cmd response 0x900, card status 0xb00
> mmcblk0: retrying using single block read
> 
> WARNING: at lib/dma-debug.c:811 check_unmap
> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA memory
> it has not allocated [device address=0x0000000080933000] [size=20480 bytes]
> 
> In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup()
> and then again in omap_hsmmc_post_req(). Resolve this by clearing the
> host_cookie to indicate there is no DMA mapped memory to unmap.
> 
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> Tested-by: Balaji T K <balajitk@ti.com>
> ---
> Repost with my Tested-by

Thanks.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

> 
>  drivers/mmc/host/omap_hsmmc.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 101cd31..d5fe43d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1010,6 +1010,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
>  			host->data->sg_len,
>  			omap_hsmmc_get_dma_dir(host, host->data));
>  		omap_free_dma(dma_ch);
> +		host->data->host_cookie = 0;
>  	}
>  	host->data = NULL;
>  }
> @@ -1575,8 +1576,10 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  	struct mmc_data *data = mrq->data;
>  
>  	if (host->use_dma) {
> -		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> -			     omap_hsmmc_get_dma_dir(host, data));
> +		if (data->host_cookie)
> +			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +				     data->sg_len,
> +				     omap_hsmmc_get_dma_dir(host, data));
>  		data->host_cookie = 0;
>  	}
>  }
> -- 
> 1.7.0.4
> 
