From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] MMC: TMIO: add runtime PM calls to global suspend() /
 redume() methods
Date: Fri, 22 Apr 2011 09:32:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104220929310.3729@axis700.grange>
References: <Pine.LNX.4.64.1104211231240.29172@axis700.grange>
 <20110422011320.GA22726@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59323 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab1DVHc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 03:32:27 -0400
In-Reply-To: <20110422011320.GA22726@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>

On Fri, 22 Apr 2011, Simon Horman wrote:

> Hi Guennadi,
> 
> On Thu, Apr 21, 2011 at 12:32:54PM +0200, Guennadi Liakhovetski wrote:
> > The TMIO MMC driver cannot generally suspend itself at runtime even
> > with no card inserted, because otherwise it wouldn't be able to detect
> > new cards. But when the system goes down for a global suspend, we can
> > use runtime PM calls to let it activate platform-specific PM hooks,
> > e.g., to switch off respective power domains.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  drivers/mmc/host/tmio_mmc.h     |    2 ++
> >  drivers/mmc/host/tmio_mmc_pio.c |    6 ++++++
> >  2 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 249c724..58138a2 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -52,6 +52,8 @@ struct tmio_mmc_host {
> >  	void (*set_pwr)(struct platform_device *host, int state);
> >  	void (*set_clk_div)(struct platform_device *host, int state);
> >  
> > +	int			pm_error;
> 
> I wonder if instead of adding an whole int to effectively
> store one bit we could use some of the spare space in the
> sdio_irq_enabled element, which is also an int that effectively
> stores one bit.
> 
> Perhaps a bitmask or a bitfield?

It's always a dilemma for me - whether to use a bitfield, or an int, or a 
char... In this case I decided to use an int, because, although so far it 
is only used to check, whether an error occurred, we might in the future 
want to use the actual error code value. And wasting 4 bytes per 
controller didn't seem like a huge memory hog to me;)

Thanks
Guennadi

> I was thinking of doing something similar when adding support
> for multiple IRQ vectors, as my current code also needs, wait for it,
> one bit :-)
> 
> > +
> >  	/* pio related stuff */
> >  	struct scatterlist      *sg_ptr;
> >  	struct scatterlist      *sg_orig;
> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> > index d1791ba..26598f1 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -980,6 +980,8 @@ int tmio_mmc_host_suspend(struct device *dev)
> >  	if (!ret)
> >  		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> >  
> > +	host->pm_error = pm_runtime_put_sync(dev);
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(tmio_mmc_host_suspend);
> > @@ -987,6 +989,10 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
> >  int tmio_mmc_host_resume(struct device *dev)
> >  {
> >  	struct mmc_host *mmc = dev_get_drvdata(dev);
> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +
> > +	if (!host->pm_error)
> > +		pm_runtime_get_sync(dev);
> >  
> >  	tmio_mmc_reset(mmc_priv(mmc));
> >  
> > -- 
> > 1.7.2.5
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
