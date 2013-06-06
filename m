From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: postpone controller reset during resume
Date: Thu, 6 Jun 2013 09:30:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306060928050.32566@axis700.grange>
References: <Pine.LNX.4.64.1304221025300.23906@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51660 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3FFHaq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 03:30:46 -0400
In-Reply-To: <Pine.LNX.4.64.1304221025300.23906@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, hechtb@gmail.com, Horman Simon <simon@horms.net>, Damm Magnus <magnus.damm@gmail.com>, "^[$B0p5H$5$s^[(B" <jinso.inayoshi@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Chris

On Mon, 22 Apr 2013, Guennadi Liakhovetski wrote:

> When resuming, the tmio_mmc_host_resume() function is run when the
> controller might still be powered down. Issuing a reset command to it at
> that time has no effect. This patch postpones resetting the controller
> until the first powering-up .set_ios() call.
> 
> Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Any reason why this hasn't been applied yet? Please, push for 3.10.

Thanks
Guennadi

> ---
> 
> There is some risk associated with this patch: it removes unconditional 
> (attempt of) controller reset from the tmio_mmc_host_resume() function. 
> AFAICS, this shouldn't have any negative effects. There _should_ always be 
> a powering-up .set_ios() call after a resume. However, if anyone sees any 
> (potential) problems with it, please, let me know.
> 
>  drivers/mmc/host/tmio_mmc.h     |    1 +
>  drivers/mmc/host/tmio_mmc_pio.c |    6 +++++-
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index d857f5c..759d8f4 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -85,6 +85,7 @@ struct tmio_mmc_host {
>  	unsigned long		last_req_ts;
>  	struct mutex		ios_lock;	/* protect set_ios() context */
>  	bool			native_hotplug;
> +	bool			resuming;
>  };
>  
>  int tmio_mmc_host_probe(struct tmio_mmc_host **host,
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index f508ecb..435cc4d 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -862,6 +862,10 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (!host->power) {
>  			tmio_mmc_clk_update(mmc);
>  			pm_runtime_get_sync(dev);
> +			if (host->resuming) {
> +				tmio_mmc_reset(host);
> +				host->resuming = false;
> +			}
>  		}
>  		tmio_mmc_set_clock(host, ios->clock);
>  		if (!host->power) {
> @@ -1154,10 +1158,10 @@ int tmio_mmc_host_resume(struct device *dev)
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	struct tmio_mmc_host *host = mmc_priv(mmc);
>  
> -	tmio_mmc_reset(host);
>  	tmio_mmc_enable_dma(host, true);
>  
>  	/* The MMC core will perform the complete set up */
> +	host->resuming = true;
>  	return mmc_resume_host(mmc);
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_resume);
> -- 
> 1.7.2.5
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
