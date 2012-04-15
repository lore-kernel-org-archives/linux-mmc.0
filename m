From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] mmc: sdio: avoid spurious calls to interrupt handlers
Date: Sun, 15 Apr 2012 09:02:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204150900080.16314@xanadu.home>
References: <alpine.LFD.2.02.1204131639510.16314@xanadu.home> <ffff015ed637538bd14b61b8507586ed.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50962 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab2DONCk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Apr 2012 09:02:40 -0400
Received: by qcro28 with SMTP id o28so2674585qcr.19
        for <linux-mmc@vger.kernel.org>; Sun, 15 Apr 2012 06:02:40 -0700 (PDT)
In-Reply-To: <ffff015ed637538bd14b61b8507586ed.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Sun, 15 Apr 2012, Sujit Reddy Thumma wrote:

> Hi Nicolas,
> 
> >
> > Commit 06e8935feb "optimized SDIO IRQ handling for single irq"
> > introduced some spurious calls to SDIO function interrupt handlers,
> > such as when the SDIO IRQ thread is started, or the safety check
> > performed upon a system resume.  Let's add a flag to perform the
> > optimization only when a real interrupt is signaled by the host
> > driver and we know there is no point confirming it.
> >
> 
> Thanks for putting up formal patch.
> 
> > Reported-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Cc: stable@kernel.org
> >
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index f573e7f9f7..3d8ceb4084 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -28,18 +28,20 @@
> >
> >  #include "sdio_ops.h"
> >
> > -static int process_sdio_pending_irqs(struct mmc_card *card)
> > +static int process_sdio_pending_irqs(struct mmc_host *host)
> >  {
> > +	struct mmc_card *card = host->card;
> >  	int i, ret, count;
> >  	unsigned char pending;
> >  	struct sdio_func *func;
> >
> >  	/*
> >  	 * Optimization, if there is only 1 function interrupt registered
> > -	 * call irq handler directly
> > +	 * and we know an IRQ was signaled then call irq handler directly.
> > +	 * Otherwise do the full probe.
> >  	 */
> >  	func = card->sdio_single_irq;
> > -	if (func) {
> > +	if (func && host->sdio_irq_pending) {
> >  		func->irq_handler(func);
> >  		return 1;
> >  	}
> > @@ -116,7 +118,8 @@ static int sdio_irq_thread(void *_host)
> >  		ret = __mmc_claim_host(host, &host->sdio_irq_thread_abort);
> >  		if (ret)
> >  			break;
> > -		ret = process_sdio_pending_irqs(host->card);
> > +		ret = process_sdio_pending_irqs(host);
> > +		host->sdio_irq_pending = false;
> >  		mmc_release_host(host);
> >
> >  		/*
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index ee2b0363c0..557aa4cd66 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -323,6 +323,7 @@ struct mmc_host {
> >
> >  	unsigned int		sdio_irqs;
> >  	struct task_struct	*sdio_irq_thread;
> > +	bool			sdio_irq_pending;
> >  	atomic_t		sdio_irq_thread_abort;
> >
> >  	mmc_pm_flag_t		pm_flags;	/* requested pm features */
> > @@ -378,6 +379,7 @@ extern int mmc_cache_ctrl(struct mmc_host *, u8);
> >  static inline void mmc_signal_sdio_irq(struct mmc_host *host)
> >  {
> >  	host->ops->enable_sdio_irq(host, 0);
> > +	host->sdio_irq_pending = true;
> >  	wake_up_process(host->sdio_irq_thread);
> >  }
> 
> In this case probably we need to add the following:
> @@ -946,8 +946,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 }
>         }
> 
> -       if (!err && host->sdio_irqs)
> -               mmc_signal_sdio_irq(host);
> +       if (!err && host->sdio_irqs) {
> +               host->ops->enable_sdio_irq(host, 0);
> +               wake_up_process(host->sdio_irq_thread);
> +       }

The call to enable_sdio_irq() is probably redundant.  Only 
wake_up_process() should be sufficient.


Nicolas
