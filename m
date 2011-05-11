From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: RE: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
 work instances
Date: Wed, 11 May 2011 15:31:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105111530470.15787@axis700.grange>
References: <Pine.LNX.4.64.1104152006110.18593@axis700.grange> <5D8008F58939784290FAB48F549751983DB52B1EEF@shsmsx502.ccr.corp.intel.com> <alpine.DEB.2.00.1105111423360.15787@axis700.grange>
 <5D8008F58939784290FAB48F549751983DB52B1EF7@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65400 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab1EKQNg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 12:13:36 -0400
In-Reply-To: <5D8008F58939784290FAB48F549751983DB52B1EF7@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, 11 May 2011, Dong, Chuanxiao wrote:

> 
> > -----Original Message-----
> > From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de]
> > Sent: Wednesday, May 11, 2011 8:26 PM
> > To: Dong, Chuanxiao
> > Cc: linux-mmc@vger.kernel.org
> > Subject: RE: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
> > work instances
> > 
> > Hi
> > 
> > On Wed, 11 May 2011, Dong, Chuanxiao wrote:
> > 
> > > Hello Liakhovetski,
> > >
> > > Right now I am facing some problem during kernel booting which indicate
> > > caused by MMC driver. So I think I encountered the race condition you
> > > mentioned below.
> > 
> > Which kernel are you using? With my patch or without it? What makes you
> > think, that your problem is caused by a race in MMC? Races rarely occur
> > reproducibly, so, it seems a bit unlikely to me during the boot process.
> I am using the kernel without your patch, so you can say my kernel is 
> before your patch.
> After applied your patch, I never encountered booting failure. So this 
> makes me think I encountered the race condition between card-detect 
> rescan and clock-gate thread.
> 
> But I am not quiet understanding what race it is actually. Can you just 
> introduce what race you faced? Is this race condition caused by 
> sdhci_set_ios reenter or something else?

Look here for an explanation: 
http://thread.gmane.org/gmane.linux.kernel.mmc/7253

Thanks
Guennadi

> 
> Thanks
> Chuanxiao
> > 
> > > I have gone through MMC stack code, seems sdhci_set_ios already wrapped
> > > by spin lock/unlock, so I am a little not understanding why there is
> > > still a race condition?
> > 
> > Again, are you referring to the kernel before my patch or after?
> > 
> > Thanks
> > Guennadi
> > 
> > > Is this race condition caused by sdhci_set_ios function reenter or
> > > something else?
> > >
> > > Thanks for your help on this.
> > >
> > > BR
> > > Chuanxiao
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org
> > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Guennadi Liakhovetski
> > > Sent: Saturday, April 16, 2011 2:08 AM
> > > To: linux-sh@vger.kernel.org
> > > Cc: linux-mmc@vger.kernel.org; Magnus Damm; Simon Horman; Linus Walleij
> > > Subject: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
> > work instances
> > >
> > > Currently there is a race in the MMC core between a card-detect
> > > rescan work and the clock-gating work, scheduled from a command
> > > completion. Fix it by removing the dedicated clock-gating mutex and
> > > using the MMC standard locking mechanism instead.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <damm@opensource.se>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  drivers/mmc/core/host.c  |    9 ++++-----
> > >  include/linux/mmc/host.h |    1 -
> > >  2 files changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 461e6a1..2b200c1 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -94,7 +94,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host
> > *host)
> > >  		spin_unlock_irqrestore(&host->clk_lock, flags);
> > >  		return;
> > >  	}
> > > -	mutex_lock(&host->clk_gate_mutex);
> > > +	mmc_claim_host(host);
> > >  	spin_lock_irqsave(&host->clk_lock, flags);
> > >  	if (!host->clk_requests) {
> > >  		spin_unlock_irqrestore(&host->clk_lock, flags);
> > > @@ -104,7 +104,7 @@ static void mmc_host_clk_gate_delayed(struct
> > mmc_host *host)
> > >  		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
> > >  	}
> > >  	spin_unlock_irqrestore(&host->clk_lock, flags);
> > > -	mutex_unlock(&host->clk_gate_mutex);
> > > +	mmc_release_host(host);
> > >  }
> > >
> > >  /*
> > > @@ -130,7 +130,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
> > >  {
> > >  	unsigned long flags;
> > >
> > > -	mutex_lock(&host->clk_gate_mutex);
> > > +	mmc_claim_host(host);
> > >  	spin_lock_irqsave(&host->clk_lock, flags);
> > >  	if (host->clk_gated) {
> > >  		spin_unlock_irqrestore(&host->clk_lock, flags);
> > > @@ -140,7 +140,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
> > >  	}
> > >  	host->clk_requests++;
> > >  	spin_unlock_irqrestore(&host->clk_lock, flags);
> > > -	mutex_unlock(&host->clk_gate_mutex);
> > > +	mmc_release_host(host);
> > >  }
> > >
> > >  /**
> > > @@ -215,7 +215,6 @@ static inline void mmc_host_clk_init(struct mmc_host
> > *host)
> > >  	host->clk_gated = false;
> > >  	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
> > >  	spin_lock_init(&host->clk_lock);
> > > -	mutex_init(&host->clk_gate_mutex);
> > >  }
> > >
> > >  /**
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index bcb793e..eb792cb 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -183,7 +183,6 @@ struct mmc_host {
> > >  	struct work_struct	clk_gate_work; /* delayed clock gate */
> > >  	unsigned int		clk_old;	/* old clock value cache */
> > >  	spinlock_t		clk_lock;	/* lock for clk fields */
> > > -	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
> > >  #endif
> > >
> > >  	/* host specific block data */
> > > --
> > > 1.7.2.5
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > 
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
