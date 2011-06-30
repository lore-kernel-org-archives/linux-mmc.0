From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: fix build error if CONFIG_MMC_SDHI is not
 configured
Date: Thu, 30 Jun 2011 09:23:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1106300922110.1965@axis700.grange>
References: <1309409956.10500.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64503 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab1F3HXN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 03:23:13 -0400
In-Reply-To: <1309409956.10500.3.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ian Molton <spyro@f2s.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Axel

On Thu, 30 Jun 2011, Axel Lin wrote:

> Fix below build error:
> 
>   CC      drivers/mmc/host/tmio_mmc_dma.o
> drivers/mmc/host/tmio_mmc_dma.c:192: error: redefinition of 'tmio_mmc_start_dma'
> drivers/mmc/host/tmio_mmc.h:111: error: previous definition of 'tmio_mmc_start_dma' was here
> drivers/mmc/host/tmio_mmc_dma.c:257: error: redefinition of 'tmio_mmc_request_dma'
> drivers/mmc/host/tmio_mmc.h:116: error: previous definition of 'tmio_mmc_request_dma' was here
> drivers/mmc/host/tmio_mmc_dma.c:305: error: redefinition of 'tmio_mmc_release_dma'
> drivers/mmc/host/tmio_mmc.h:122: error: previous definition of 'tmio_mmc_release_dma' was here
> make[3]: *** [drivers/mmc/host/tmio_mmc_dma.o] Error 1
> make[2]: *** [drivers/mmc/host] Error 2
> make[1]: *** [drivers/mmc] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

This is a known bug and a correct fix for it is this:

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg07999.html

No idea, why it still hasn't been applied, Chris?

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc_dma.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index a40fdba..4dc563a 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -189,6 +189,7 @@ pio:
>  		desc, cookie);
>  }
>  
> +#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
>  void tmio_mmc_start_dma(struct tmio_mmc_host *host,
>  			       struct mmc_data *data)
>  {
> @@ -200,6 +201,7 @@ void tmio_mmc_start_dma(struct tmio_mmc_host *host,
>  			tmio_mmc_start_dma_tx(host);
>  	}
>  }
> +#endif
>  
>  static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
>  {
> @@ -254,6 +256,7 @@ static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
>  	return true;
>  }
>  
> +#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
>  void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
>  {
>  	/* We can only either use DMA for both Tx and Rx or not use it at all */
> @@ -319,3 +322,4 @@ void tmio_mmc_release_dma(struct tmio_mmc_host *host)
>  		host->bounce_buf = NULL;
>  	}
>  }
> +#endif
> -- 
> 1.7.4.1
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
