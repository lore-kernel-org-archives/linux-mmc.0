From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/5] mmc: tmio: Provide separate interrupt handlers
Date: Tue, 16 Aug 2011 16:59:22 +0900
Message-ID: <20110816075919.GA12097@verge.net.au>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108160924030.13154@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36623 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1HPH73 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2011 03:59:29 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108160924030.13154@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Tue, Aug 16, 2011 at 09:41:52AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 16 Aug 2011, Simon Horman wrote:
> 
> > Provide separate interrupt handlers which may be used by platforms where
> > SDHI has three interrupt sources.
> 
> Yes, this looks much simpler and cleaner to me now, than 3 original 
> patches. It might change a bit after you change your PATCH 1/5, 
> 
> > 
> > This involves two key changes to the logic:
> > 1. Do not assume that only one interrupt has occurred.
> >    In particular because tmio_mmc_irq() handles interrupts
> >    from three sources. Also, because this allows
> >    the logic to be simplified.
> > 2. Just ignore spurious interrupts.
> >    Its not clear to me that they can ever occur.
> > 
> > This patch also removes the commented-out handling of CRC and other errors.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > ---
> > 
> > * SDCARD portion tested on AP4/Mackerel
> > * SDIO portion untested
> > 
> > v2
> > As suggested by Guennadi Liakhovetski
> > * Combine 3 patches into one
> > * Reduce the number of __tmio_..._irq() functions
> > * Rename "...card_access..." functions as "...sdcard..."
> > ---
> >  drivers/mmc/host/tmio_mmc.h     |    3 +
> >  drivers/mmc/host/tmio_mmc_pio.c |  121 +++++++++++++++++++++++----------------
> >  2 files changed, 75 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 1cf8db5..3020f98 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -97,6 +97,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
> >  void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
> >  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
> >  irqreturn_t tmio_mmc_irq(int irq, void *devid);
> > +irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid);
> > +irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid);
> > +irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid);
> >  
> >  static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
> >  					 unsigned long *flags)
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> > index c60b15f..e9640f2 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -547,45 +547,20 @@ out:
> >  	spin_unlock(&host->lock);
> >  }
> >  
> > -irqreturn_t tmio_mmc_irq(int irq, void *devid)
> > +static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
> > +				       int *ireg, int *status)
> >  {
> > -	struct tmio_mmc_host *host = devid;
> > -	struct mmc_host *mmc = host->mmc;
> > -	struct tmio_mmc_data *pdata = host->pdata;
> > -	unsigned int ireg, status;
> > -	unsigned int sdio_ireg, sdio_status;
> > -
> > -	pr_debug("MMC IRQ begin\n");
> > -
> > -	status = sd_ctrl_read32(host, CTL_STATUS);
> > -	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
> > +	*status = sd_ctrl_read32(host, CTL_STATUS);
> > +	*ireg = *status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
> >  
> > -	sdio_ireg = 0;
> > -	if (!ireg && pdata->flags & TMIO_MMC_SDIO_IRQ) {
> > -		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
> > -		host->sdio_irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
> > -		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL &
> > -				~host->sdio_irq_mask;
> > -
> > -		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
> > -
> > -		if (sdio_ireg && !host->sdio_irq_enabled) {
> > -			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
> > -				   sdio_status, host->sdio_irq_mask, sdio_ireg);
> > -			tmio_mmc_enable_sdio_irq(mmc, 0);
> > -			goto out;
> > -		}
> > -
> > -		if (mmc->caps & MMC_CAP_SDIO_IRQ &&
> > -			sdio_ireg & TMIO_SDIO_STAT_IOIRQ)
> > -			mmc_signal_sdio_irq(mmc);
> > -
> > -		if (sdio_ireg)
> > -			goto out;
> > -	}
> > +	pr_debug_status(*status);
> > +	pr_debug_status(*ireg);
> > +}
> >  
> > -	pr_debug_status(status);
> > -	pr_debug_status(ireg);
> > +static void __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
> > +				       int ireg, int status)
> > +{
> > +	struct mmc_host *mmc = host->mmc;
> >  
> >  	/* Card insert / remove attempts */
> >  	if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
> > @@ -595,43 +570,91 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
> >  		     ((ireg & TMIO_STAT_CARD_INSERT) && !mmc->card)) &&
> >  		    !work_pending(&mmc->detect.work))
> >  			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
> > -		goto out;
> >  	}
> > +}
> >  
> > -	/* CRC and other errors */
> > -/*	if (ireg & TMIO_STAT_ERR_IRQ)
> > - *		handled |= tmio_error_irq(host, irq, stat);
> > - */
> > +irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid)
> > +{
> > +	unsigned int ireg, status;
> > +	struct tmio_mmc_host *host = devid;
> > +
> > +	tmio_mmc_card_irq_status(host, &ireg, &status);
> > +	__tmio_mmc_card_detect_irq(host, ireg, status);
> >  
> > +	return IRQ_HANDLED;
> > +}
> > +EXPORT_SYMBOL(tmio_mmc_card_detect_irq);
> > +
> > +void __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host, int ireg, int status)
> 
> "static" missing
> 
> > +{
> >  	/* Command completion */
> >  	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
> >  		tmio_mmc_ack_mmc_irqs(host,
> >  			     TMIO_STAT_CMDRESPEND |
> >  			     TMIO_STAT_CMDTIMEOUT);
> >  		tmio_mmc_cmd_irq(host, status);
> > -		goto out;
> 
> Well, removing these goto's certainly changes behaviour - at least 
> theoretically. Imagine entering the ISR with status = TMIO_STAT_CMDRESPEND 
> | TMIO_STAT_DATAEND. Before your patch the driver would ack and process 
> the TMIO_STAT_CMDRESPEND and return dropping the TMIO_STAT_DATAEND status. 
> Anc we don't know whether a second interrupt would follow with 
> TMIO_STAT_DATAEND set. After your patch the driver will ack and process 
> both. Since this driver runs on a variaty of hardware, unless fixing a 
> problem or really improving something, I would keep the original 
> behaviour. So, I would rather keep those exit points - just put "return" 
> there.

I specifically noted this change in the changelog, sorry if that wasn't
clear enough.

I will revert the behaviour as you suggest, although I suspect
that the new behaviour is correct.

> >  	}
> >  
> >  	/* Data transfer */
> >  	if (ireg & (TMIO_STAT_RXRDY | TMIO_STAT_TXRQ)) {
> >  		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_RXRDY | TMIO_STAT_TXRQ);
> >  		tmio_mmc_pio_irq(host);
> > -		goto out;
> >  	}
> >  
> >  	/* Data transfer completion */
> >  	if (ireg & TMIO_STAT_DATAEND) {
> >  		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
> >  		tmio_mmc_data_irq(host);
> > -		goto out;
> >  	}
> > +}
> > +
> > +irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid)
> > +{
> > +	unsigned int ireg, status;
> > +	struct tmio_mmc_host *host = devid;
> >  
> > -	pr_warning("tmio_mmc: Spurious irq, disabling! "
> > -		"0x%08x 0x%08x 0x%08x\n", status, host->sdcard_irq_mask, ireg);
> > -	pr_debug_status(status);
> > -	tmio_mmc_disable_mmc_irqs(host, status & ~host->sdcard_irq_mask);
> > +	tmio_mmc_card_irq_status(host, &ireg, &status);
> > +	__tmio_mmc_sdcard_irq(host, ireg, status);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +EXPORT_SYMBOL(tmio_mmc_sdcard_irq);
> > +
> > +irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
> > +{
> > +	struct tmio_mmc_host *host = devid;
> > +	struct mmc_host *mmc = host->mmc;
> > +	struct tmio_mmc_data *pdata = host->pdata;
> > +	unsigned int ireg, status;
> > +
> > +	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
> > +		return IRQ_HANDLED;
> > +
> > +	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
> > +	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
> > +
> > +	sd_ctrl_write16(host, CTL_SDIO_STATUS, status & ~TMIO_SDIO_MASK_ALL);
> > +
> > +	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
> > +		mmc_signal_sdio_irq(mmc);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +EXPORT_SYMBOL(tmio_mmc_sdio_irq);
> > +
> > +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> > +{
> > +	struct tmio_mmc_host *host = devid;
> > +	unsigned int ireg, status;
> > +
> > +	pr_debug("MMC IRQ begin\n");
> > +
> > +	tmio_mmc_card_irq_status(host, &ireg, &status);
> > +	__tmio_mmc_card_detect_irq(host, ireg, status);
> 
> Same here - I would return, if a card hot-plug event occurred.

Will do.

> > +	__tmio_mmc_sdcard_irq(host, ireg, status);
> 
> Ditto
> 
> > +
> > +	tmio_mmc_sdio_irq(irq, devid);
> 
> Any specific reason, why you now process SDIO IRQs last?

I believe this is in keeping with the ordering implied by original code.

> >  
> > -out:
> >  	return IRQ_HANDLED;
> >  }
> >  EXPORT_SYMBOL(tmio_mmc_irq);
> > -- 
> > 1.7.5.4
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
