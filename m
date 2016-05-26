From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 17/23] mmc: sdhci: add standard hw auto retuning support
Date: Thu, 26 May 2016 20:11:15 +0800
Message-ID: <20160526121115.GD23988@shlinux2>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-18-git-send-email-aisheng.dong@nxp.com>
 <57319D51.8030907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35752 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbcEZMQY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 08:16:24 -0400
Received: by mail-pa0-f65.google.com with SMTP id gp3so2097236pac.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 05:16:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57319D51.8030907@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On Tue, May 10, 2016 at 11:35:29AM +0300, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
> > If HW supports SDHCI_TUNING_MODE_3 which is auto retuning, we won't
> 
> Since this is about tuning mode 3, could you put that in the subject e.g.
> "Add support for auto re-tuning (tuning mode 3)"
> 
> > retune during runtime suspend and resume, instead we use Re-tuning
> > Request signaled via SDHCI_INT_RETUNE interrupt to do retuning and
> > hw auto retuning during data transfer to guarantee the signal sample
> > window correction.
> > 
> > This can avoid a mass of repeatly retuning during small file system
> 
> repeatly -> repeatedly
> 

Got it.

> > data access and improve the performance.
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 18 ++++++++++++++----
> >  drivers/mmc/host/sdhci.h |  3 +++
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 2eb0e34..0027b87 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -252,6 +252,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
> >  		    SDHCI_INT_TIMEOUT | SDHCI_INT_DATA_END |
> >  		    SDHCI_INT_RESPONSE;
> >  
> > +	if (host->tuning_mode == SDHCI_TUNING_MODE_3)
> 
> Tuning mode 2 uses this as well.  Might as well add it here.
> 

The origin plan is adding only mode 3 support here to make life
a bit easier. Seems mode 2 does not need much more things added.
So i can add it here too.

> > +		host->ier |= SDHCI_INT_RETUNE;
> > +
> >  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> >  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> >  
> > @@ -2477,6 +2480,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >  			pr_err("%s: Card is consuming too much power!\n",
> >  				mmc_hostname(host->mmc));
> >  
> > +		if (intmask & SDHCI_INT_RETUNE)
> > +			mmc_retune_needed(host->mmc);
> > +
> 
> Also need to add SDHCI_INT_RETUNE to the bits cleared further on, otherwise
> it will show up in the "Unexpected interrupt" message
> 

That's true.

> >  		if (intmask & SDHCI_INT_CARD_INT) {
> >  			sdhci_enable_sdio_irq_nolock(host, false);
> >  			host->thread_isr |= SDHCI_INT_CARD_INT;
> > @@ -2575,8 +2581,10 @@ int sdhci_suspend_host(struct sdhci_host *host)
> >  {
> >  	sdhci_disable_card_detection(host);
> >  
> > -	mmc_retune_timer_stop(host->mmc);
> > -	mmc_retune_needed(host->mmc);
> > +	if (host->tuning_mode == SDHCI_TUNING_MODE_1) {
> > +		mmc_retune_timer_stop(host->mmc);
> > +		mmc_retune_needed(host->mmc);
> > +	}
> 
> Probably wouldn't hurt to stop the timer always whether it's going or not.

Sounds correct.

> And tuning mode 2 is not auto re-tuning, so I would still expect to need
> re-tuning after power loss i.e.
> 
> 	mmc_retune_timer_stop(host->mmc);
> 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> 		mmc_retune_needed(host->mmc);
> 

I agree with you.
Will get it in v2.

Regards
Dong Aisheng

> >  
> >  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
> >  		host->ier = 0;
> > @@ -2651,8 +2659,10 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
> >  {
> >  	unsigned long flags;
> >  
> > -	mmc_retune_timer_stop(host->mmc);
> > -	mmc_retune_needed(host->mmc);
> > +	if (host->tuning_mode == SDHCI_TUNING_MODE_1) {
> > +		mmc_retune_timer_stop(host->mmc);
> > +		mmc_retune_needed(host->mmc);
> > +	}
> 
> Ditto
> 
> >  
> >  	spin_lock_irqsave(&host->lock, flags);
> >  	host->ier &= SDHCI_INT_CARD_INT;
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index afa4de8..2c2404f 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -128,6 +128,7 @@
> >  #define  SDHCI_INT_CARD_INSERT	0x00000040
> >  #define  SDHCI_INT_CARD_REMOVE	0x00000080
> >  #define  SDHCI_INT_CARD_INT	0x00000100
> > +#define  SDHCI_INT_RETUNE	0x00001000
> >  #define  SDHCI_INT_ERROR	0x00008000
> >  #define  SDHCI_INT_TIMEOUT	0x00010000
> >  #define  SDHCI_INT_CRC		0x00020000
> > @@ -514,6 +515,8 @@ struct sdhci_host {
> >  	unsigned int		tuning_count;	/* Timer count for re-tuning */
> >  	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
> >  #define SDHCI_TUNING_MODE_1	0
> > +#define SDHCI_TUNING_MODE_2	1
> > +#define SDHCI_TUNING_MODE_3	2
> >  
> >  	unsigned long private[0] ____cacheline_aligned;
> >  };
> > 
> 
