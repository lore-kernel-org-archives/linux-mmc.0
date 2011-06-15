From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: fix recursive spinlock, don't schedule with
 interrupts disabled
Date: Wed, 15 Jun 2011 18:50:46 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1106151849300.28243@axis700.grange>
References: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab1FOQvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 12:51:18 -0400
In-Reply-To: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>

On Wed, 15 Jun 2011, Guennadi Liakhovetski wrote:

> Calling mmc_request_done() under a spinlock with interrupts disabled
> leads to a recursive spin-lock on request retry path and to
> scheduling in atomic context. This patch fixes both these problems
> by moving mmc_request_done() to the scheduler workqueue.

Hm, sorry, please, wait with this one, I have to test it a bit more.

Thanks
Guennadi

> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Morimoto-san, this should fix the race in TMIO / SDHI driver, that you 
> reported here:
> 
> http://article.gmane.org/gmane.linux.ports.sh.devel/11349
> 
> Please, verify.
> 
>  drivers/mmc/host/tmio_mmc.h     |    2 ++
>  drivers/mmc/host/tmio_mmc_pio.c |   14 +++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 8260bc2..b4dfc13 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -73,6 +73,8 @@ struct tmio_mmc_host {
>  
>  	/* Track lost interrupts */
>  	struct delayed_work	delayed_reset_work;
> +	struct work_struct	done;
> +	/* protect host private data */
>  	spinlock_t		lock;
>  	unsigned long		last_req_ts;
>  };
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ad6347b..1b63045 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -297,10 +297,16 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
>  
>  	host->mrq = NULL;
>  
> -	/* FIXME: mmc_request_done() can schedule! */
>  	mmc_request_done(host->mmc, mrq);
>  }
>  
> +static void tmio_mmc_done_work(struct work_struct *work)
> +{
> +	struct tmio_mmc_host *host = container_of(work, struct tmio_mmc_host,
> +						  done);
> +	tmio_mmc_finish_request(host);
> +}
> +
>  /* These are the bitmasks the tmio chip requires to implement the MMC response
>   * types. Note that R1 and R6 are the same in this scheme. */
>  #define APP_CMD        0x0040
> @@ -467,7 +473,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
>  			BUG();
>  	}
>  
> -	tmio_mmc_finish_request(host);
> +	schedule_work(&host->done);
>  }
>  
>  static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
> @@ -557,7 +563,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
>  				tasklet_schedule(&host->dma_issue);
>  		}
>  	} else {
> -		tmio_mmc_finish_request(host);
> +		schedule_work(&host->done);
>  	}
>  
>  out:
> @@ -916,6 +922,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  
>  	/* Init delayed work for request timeouts */
>  	INIT_DELAYED_WORK(&_host->delayed_reset_work, tmio_mmc_reset_work);
> +	INIT_WORK(&_host->done, tmio_mmc_done_work);
>  
>  	/* See if we also get DMA */
>  	tmio_mmc_request_dma(_host, pdata);
> @@ -963,6 +970,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  		pm_runtime_get_sync(&pdev->dev);
>  
>  	mmc_remove_host(host->mmc);
> +	cancel_work_sync(&host->done);
>  	cancel_delayed_work_sync(&host->delayed_reset_work);
>  	tmio_mmc_release_dma(host);
>  
> -- 
> 1.7.2.5
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
