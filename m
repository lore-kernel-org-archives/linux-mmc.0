From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: Fix build errors
Date: Mon, 16 May 2011 23:07:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105162306110.29373@axis700.grange>
References: <E1QLbJV-0007eN-AF@outmx05.plus.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57688 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1EPVHJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 17:07:09 -0400
In-Reply-To: <E1QLbJV-0007eN-AF@outmx05.plus.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

On Sun, 15 May 2011, Paul Parsons wrote:

> Conditional code in tmio_mmc.h selects dummy tmio_mmc_start_dma(), 
> tmio_mmc_request_dma() and tmio_mmc_release_dma() inline functions 
> instead of the required declarations. This breaks the build of 
> tmio_mmc_dma.c
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>

NAK. Are you trying to use DMA with TMIO on your platform? Then this is a 
wrong fix. Otherwise tmio_mmc_dma.c shouldn't be compiled on your arch at 
all.

Thanks
Guennadi

> ---
> diff -uprN clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h
> --- clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h	2011-05-11 00:54:17.647289808 +0100
> +++ linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h	2011-05-14 16:30:47.208267896 +0100
> @@ -98,26 +98,8 @@ static inline void tmio_mmc_kunmap_atomi
>  	local_irq_restore(*flags);
>  }
>  
> -#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
>  void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
>  void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
>  void tmio_mmc_release_dma(struct tmio_mmc_host *host);
> -#else
> -static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
> -			       struct mmc_data *data)
> -{
> -}
> -
> -static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
> -				 struct tmio_mmc_data *pdata)
> -{
> -	host->chan_tx = NULL;
> -	host->chan_rx = NULL;
> -}
> -
> -static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
> -{
> -}
> -#endif
>  
>  #endif
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
