From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] omap_hsmmc: use original sg_len for dma_unmap_sg
Date: Sat, 18 Jun 2011 23:20:25 -0400
Message-ID: <m2tybmzeva.fsf@bob.laptop.org>
References: <1308334461-3869-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34225 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307Ab1FSDUn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 23:20:43 -0400
In-Reply-To: <1308334461-3869-1-git-send-email-per.forlin@linaro.org> (Per
	Forlin's message of "Fri, 17 Jun 2011 20:14:21 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>

Hi Per,

On Fri, Jun 17 2011, Per Forlin wrote:
> Don't use the returned sg_len from dma_map_sg() as inparameter
> to dma_unmap_sg(). Use the original sg_len for both dma_map_sg
> and dma_unmap_sg according to the documentation in DMA-API.txt.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> Reviewed-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 259ece0..ad3731a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -959,7 +959,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
>  	spin_unlock(&host->irq_lock);
>  
>  	if (host->use_dma && dma_ch != -1) {
> -		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
> +		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
> +			host->data->sg_len,
>  			omap_hsmmc_get_dma_dir(host, host->data));
>  		omap_free_dma(dma_ch);
>  	}
> @@ -1343,7 +1344,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
>  		return;
>  	}
>  
> -	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
> +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>  		omap_hsmmc_get_dma_dir(host, data));
>  
>  	req_in_progress = host->req_in_progress;

Pushed to mmc-next for 3.0-rc, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
