From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/3 ] mmc: add support for h/w clock gating of sd controller
Date: Fri, 03 Dec 2010 17:18:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012031607220.10437@xanadu.home>
References: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:8922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0LCWSC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 17:18:02 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LCV005IFHXMSNO0@vl-mo-mrz23.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 03 Dec 2010 17:17:46 -0500 (EST)
In-reply-to: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.Walleij@stericsson.com>

On Fri, 3 Dec 2010, Philip Rakity wrote:

> This code extends software clock gating in the mmc layer
> by adding the ability to indicate that controller support
> hardware clock gating.
> 
> hardware clock gating is enabled by setting the mmc quirk
> MMC_CAP_CLOCK_GATING_HW
> in the sd driver.
> eg: host->mmc->caps |= MMC_CAP_CLOCK_GATING_HW
> 
> The approach follows the suggestion of Nico Pitre.
> 
> sd/mmc/eMMC cards use dynmamic clocks
> sdio uses continuous clocks
> 
> The code has been test using marvell linux for mmp2.  The marvell
> controller support h/w clock gating.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Comments below.

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6286898..c8bba7d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -131,7 +131,10 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  		if (mrq->done)
>  			mrq->done(mrq);
>  
> -		mmc_host_clk_gate(host);
> +#ifdef CONFIG_MMC_CLKGATE
> +		if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
> +			mmc_host_clk_gate(host);
> +#endif

This is a needless proliferation of #ifdef's, since you could just test 
for MMC_CAP_CLOCK_GATING_HW inside mmc_host_clk_gate() instead, and 
return early if set.

>  }
>  
> @@ -192,7 +195,10 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  			mrq->stop->mrq = mrq;
>  		}
>  	}
> -	mmc_host_clk_ungate(host);
> +#ifdef CONFIG_MMC_CLKGATE
> +	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
> +		mmc_host_clk_ungate(host);
> +#endif

Same thing here.

>  	host->ops->request(host, mrq);
>  }
>  
> @@ -1547,8 +1553,14 @@ void mmc_rescan(struct work_struct *work)
>  		pr_info("%s: %s: trying to init card at %u Hz\n",
>  			mmc_hostname(host), __func__, host->f_init);
>  #endif
> -		mmc_power_up(host);
> +
> +#ifdef CONFIG_MMC_CLKGATE
> +		if (host->caps & MMC_CAP_CLOCK_GATING_HW)
> +			mmc_hwungate_clock(host);
> +#endif

Here you should do just like what is done for mmc_host_clk_gate() in 
host.h: provide an empty inline version when CONFIG_MMC_CLKGATE is not 
defined and get rid of the #ifdef here.

>  		sdio_reset(host);
> +		mmc_power_up(host);

Why did you move down this mmc_power_up()?

>  		mmc_go_idle(host);
>  
>  		mmc_send_if_cond(host, host->ocr_avail);
[...]
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 92e3370..ace748e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -282,7 +282,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  	host->class_dev.class = &mmc_host_class;
>  	device_initialize(&host->class_dev);
>  
> -	mmc_host_clk_init(host);
> +#ifdef CONFIG_MMC_CLKGATE
> +	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
> +		mmc_host_clk_init(host);
> +#endif

Same comment as above: why don't you check for MMC_CAP_CLOCK_GATING_HW 
inside mmc_host_clk_init()?

Granted, here mmc_host_clk_init() appears to be misnomed (maybe 
mmc_host_clk_gating_init() would have been clearer).

>  	spin_lock_init(&host->lock);
>  	init_waitqueue_head(&host->wq);
> @@ -366,7 +369,10 @@ void mmc_remove_host(struct mmc_host *host)
>  
>  	led_trigger_unregister_simple(host->led);
>  
> -	mmc_host_clk_exit(host);
> +#ifdef CONFIG_MMC_CLKGATE
> +	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
> +		mmc_host_clk_exit(host);
> +#endif

Ditto here.

>  }
>  
>  EXPORT_SYMBOL(mmc_remove_host);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0eccd96..195e557 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -517,6 +517,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  
>  	mmc_set_clock(host, max_dtr);
>  
> +#ifdef CONFIG_MMC_CLKGATE
> +	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
> +		mmc_hwgate_clock(host);
> +#endif

And here I seriously begin to dislike this patch.  The sw gating code is 
centralized while the hw one is spread across all card type drivers.  
Why not calling mmc_hwgate_clock() at the appropriate location within 
mmc_rescan() (that would be where it is determined that only anew card 
might be present) and call mmc_hwgate_clock() at the end of mmc_rescan() 
and only if mmc_host_may_gate_card() is true?


Nicolas
