From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] omap_hsmmc: improve interrupt synchronisation
Date: Wed, 12 May 2010 12:52:13 -0700
Message-ID: <20100512125213.36631d2d.akpm@linux-foundation.org>
References: <4BEA5DD5.9010308@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4BEA5DD5.9010308@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Venkatraman S <svenkatr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 12 May 2010 10:50:45 +0300
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> >From ad2e1cd024ccf9144b6620cfe808893719db738f Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Wed, 14 Apr 2010 16:26:45 +0300
> Subject: [PATCH] omap_hsmmc: improve interrupt synchronisation
> 
> The following changes were needed:
> 	- do not use in_interrupt() because it will not work
> 	with threaded interrupts
> 
> In addition, the following improvements were made:
> 	- ensure DMA is unmapped only after the final DMA interrupt
> 	- ensure a request is completed only after the final DMA interrupt
> 	- disable controller interrupts when a request is not in progress
> 	- remove the spin-lock protecting the start of a new request from
> 	an unexpected interrupt because the locking was complicated and
> 	a 'req_in_progress' flag suffices (since the spin-lock only defers
> 	the unexpected interrupts anyway)
> 	- instead use the spin-lock to protect the MMC interrupt handler
> 	from the DMA interrupt handler
> 	- remove the semaphore preventing DMA from being started while
> 	the previous DMA is still in progress - the other changes make that
> 	impossible, so it is now a BUG_ON condition
> 	- ensure the controller interrupt status is clear before exiting
> 	the interrrupt handler
> 
> In general, these changes make the code safer but do not fix any specific
> bugs so backporting is not necessary.
> 
>
> ...
>
> +static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_request *mrq)
> +{
> +	int dma_ch;
> +
> +	spin_lock(&host->irq_lock);
> +	host->req_in_progress = 0;
> +	dma_ch = host->dma_ch;
> +	spin_unlock(&host->irq_lock);
> +
> +	omap_hsmmc_disable_irq(host);
> +	/* Do not complete the request if DMA is still in progress */
> +	if (mrq->data && host->use_dma && dma_ch != -1)
> +		return;
> +	host->mrq = NULL;
> +	mmc_request_done(host->mmc, mrq);
> +}

Are we sure that irq_lock doesn't need to be taken in an irq-safe fashion?


send_init_stream() doesn't report an error if its busywait times out.

