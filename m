From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] mmc: sdhci: always reset all during resume
Date: Sat, 04 Feb 2012 21:09:07 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202042106590.2759@xanadu.home>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
 <1327926439-23603-3-git-send-email-adrian.hunter@intel.com>
 <m2d39u84sm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21648 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab2BECJI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Feb 2012 21:09:08 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYW006N4DZ2VA80@VL-VM-MR006.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sat, 04 Feb 2012 21:09:02 -0500 (EST)
In-reply-to: <m2d39u84sm.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>

On Sat, 4 Feb 2012, Chris Ball wrote:

> Hi, adding Nico for review,
> 
> On Mon, Jan 30 2012, Adrian Hunter wrote:
> > During suspend the host controller may or may not be powered off.
> > In order to get the same result either way, always perform a
> > software "reset all" when resuming.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Philip Rakity <prakity@marvell.com>
> > Cc: Aaron Lu <aaron.lu@amd.com>
> > ---

What if a card asked to be kept powered while the host system was 
suspended?  Wouldn't this full reset also remove power to the card?

> >  drivers/mmc/host/sdhci.c |   29 +++++++++++------------------
> >  1 files changed, 11 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 8d66706..ef2434c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -219,31 +219,20 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  	}
> >  }
> >  
> > -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> > -
> > -static void sdhci_init(struct sdhci_host *host, int soft)
> > +static void sdhci_init(struct sdhci_host *host)
> >  {
> > -	if (soft)
> > -		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
> > -	else
> > -		sdhci_reset(host, SDHCI_RESET_ALL);
> > +	sdhci_reset(host, SDHCI_RESET_ALL);
> >  
> >  	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> >  		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
> >  		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
> >  		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
> >  		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
> > -
> > -	if (soft) {
> > -		/* force clock reconfiguration */
> > -		host->clock = 0;
> > -		sdhci_set_ios(host->mmc, &host->mmc->ios);
> > -	}
> >  }
> >  
> >  static void sdhci_reinit(struct sdhci_host *host)
> >  {
> > -	sdhci_init(host, 0);
> > +	sdhci_init(host);
> >  	sdhci_enable_card_detection(host);
> >  }
> >  
> > @@ -2423,8 +2412,12 @@ int sdhci_resume_host(struct sdhci_host *host)
> >  	if (ret)
> >  		return ret;
> >  
> > -	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
> > -	mmiowb();
> > +	sdhci_init(host);
> > +
> > +	/* Force clock and power re-program */
> > +	host->pwr = 0;
> > +	host->clock = 0;
> > +	sdhci_do_set_ios(host, &host->mmc->ios);
> >  
> >  	ret = mmc_resume_host(host->mmc);
> >  	sdhci_enable_card_detection(host);
> > @@ -2500,7 +2493,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
> >  			host->ops->enable_dma(host);
> >  	}
> >  
> > -	sdhci_init(host, 0);
> > +	sdhci_init(host);
> >  
> >  	/* Force clock and power re-program */
> >  	host->pwr = 0;
> > @@ -2980,7 +2973,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >  		host->vmmc = NULL;
> >  	}
> >  
> > -	sdhci_init(host, 0);
> > +	sdhci_init(host);
> >  
> >  #ifdef CONFIG_MMC_DEBUG
> >  	sdhci_dumpregs(host);
> 
> This patch doesn't look correct to me -- yes, the hardware might have
> lost power during suspend, but that's what the common-case of:
> 
>         sdhci_init(host, soft=0);
> 
> is for.  soft=1 is supposed to indicate that the power stayed up via
> MMC_PM_KEEP_POWER, but you're changing that by setting ->pwr = 0 in the
> soft=1 path.  If I'm using soft=1 because my controller has a wifi SDIO
> card on it, I don't want you to reprogram the power to it on resume.
> Does that make sense?
> 
> (Doing a RESET_ALL might also destroy some wanted soft-state.)
> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
