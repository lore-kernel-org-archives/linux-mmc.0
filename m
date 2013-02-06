From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: add DT bindings for more MMC capability flags
Date: Wed, 6 Feb 2013 17:25:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302061720390.13474@axis700.grange>
References: <Pine.LNX.4.64.1301231743190.26301@axis700.grange>
 <20130206151549.GA11609@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60568 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab3BFQZ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 11:25:56 -0500
In-Reply-To: <20130206151549.GA11609@e106331-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>

Hi Mark

On Wed, 6 Feb 2013, Mark Rutland wrote:

> Hi,
> 
> On Wed, Jan 23, 2013 at 04:45:11PM +0000, Guennadi Liakhovetski wrote:
> > Many MMC capability flags are platform-dependent and are traditionally set
> > in platform data. With DT often each such capability requires a special
> > binding. Add bindings for MMC_CAP_SD_HIGHSPEED, MMC_CAP_MMC_HIGHSPEED and
> > MMC_CAP_POWER_OFF_CARD capabilities. Also add code to DT parser to look
> > up "keep-power-in-suspend" and "enable-sdio-wakeup" bindings and set
> > MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ respectively, if found.
> > 
> 
> I've Cc'd Arnd, who had some related comments a while back:
> 
> https://lkml.org/lkml/2012/10/15/231
> 
> MMC_CAP_POWER_OFF_CARD sounds like something that can be selected in the driver
> by checking the compatible string or probing the hardware revision, and not
> something that should be taken directly from the dts where it could be
> completely invalid for the hardware.

Thank for pointing me out at that thread. However, I don't think 
MMC_CAP_POWER_OFF_CARD has anything to do with compatibility or hardware 
revisions. At least I haven't yet come across any sd/mmc hosts, that also 
supply card power. You could "derive" this flag from the presence of a 
regulator, capable of changing its status (switching on / off), but even 
then you're not guaranteed, that you actually can (and want to) power the 
card off at run-time - the regulator can be shared etc. So, an explicit 
flag is needed.

Thanks
Guennadi

> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Attention: contains new DT bindings, please, comment!
> > 
> >  Documentation/devicetree/bindings/mmc/mmc.txt |    5 ++++-
> >  drivers/mmc/core/host.c                       |   11 +++++++++++
> >  2 files changed, 15 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> > index e180892..92ec534c 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> > @@ -25,8 +25,11 @@ Optional properties:
> >  - max-frequency: maximum operating clock frequency
> >  - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
> >    this system, even if the controller claims it is.
> > +- cap-sd-highspeed: SD high-speed timing is supported
> > +- cap-mmc-highspeed: MMC high-speed timing is supported
> > +- cap-power-off-card: powering off the card is safe
> >  
> > -cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
> > +cd-inverted and wp-inverted properties are deprecated and shouldn't be used,
> >  instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
> >  that the default (as defined by the SDHCI standard) CD and WP polarity is
> >  active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index e4c1cbd..f3ea268 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -372,6 +372,17 @@ void mmc_of_parse(struct mmc_host *host)
> >  			dev_err(host->parent,
> >  				"Failed to request WP GPIO: %d!\n", ret);
> >  	}
> > +
> > +	if (of_find_property(np, "cap-sd-highspeed", &len))
> > +		host->caps |= MMC_CAP_SD_HIGHSPEED;
> > +	if (of_find_property(np, "cap-mmc-highspeed", &len))
> > +		host->caps |= MMC_CAP_MMC_HIGHSPEED;
> > +	if (of_find_property(np, "cap-power-off-card", &len))
> > +		host->caps |= MMC_CAP_POWER_OFF_CARD;
> > +	if (of_find_property(np, "keep-power-in-suspend", &len))
> > +		host->pm_caps |= MMC_PM_KEEP_POWER;
> > +	if (of_find_property(np, "enable-sdio-wakeup", &len))
> > +		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> >  }
> >  
> >  EXPORT_SYMBOL(mmc_of_parse);
> > -- 
> > 1.7.2.5
> > 
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> > 
> 
> Thanks,
> Mark.
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
