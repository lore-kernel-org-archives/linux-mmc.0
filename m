From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Mon, 20 Sep 2010 11:14:49 -0500
Message-ID: <738912BD0A0F48FC9E3159F923571E9E@am.dhcp.ti.com>
References: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com> <20100917154803.GB29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100917154803.GB29610@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, September 17, 2010 10:48 AM
> To: Madhusudhan Chikkature
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
> santosh.shilimkar@ti.com
> Subject: Re: [PATCH] OMAP4: HSMMC cmd line reset change
> 
> * Madhusudhan Chikkature <madhu.cr@ti.com> [100915 16:50]:
> > OMAP4: HSMMC cmd line reset change
> >
> > The cmd line reset logic is changed in OMAP4 ES2. The new procedure
> > is to monitor a 0->1 transition and then 1->0 transition.The earlier
> > logic would fail on ES2 chips because the loop could exit even before
> > the reset is actually complete.
> >
> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> > index 4526d27..750ba7d 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -976,12 +976,19 @@ static inline void
> omap_hsmmc_reset_controller_fsm(struct
> > omap_hsmmc_host *host,
> >  						   unsigned long bit)
> >  {
> >  	unsigned long i = 0;
> > +	unsigned long j = 0;
> >  	unsigned long limit = (loops_per_jiffy *
> >  				msecs_to_jiffies(MMC_TIMEOUT_MS));
> >
> >  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> >  			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
> >
> > +	if (cpu_is_omap44xx() && bit == SRC) {
> > +		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
> > +				&& (j++ < limit))
> > +			cpu_relax();
> > +	}
> > +
> >  	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
> >  		(i++ < limit))
> >  		cpu_relax();
> 
> Please don't use cpu_is_omapxxxx tests in the drivers, drivers
> should be generic.
> 
> Instead, just pass a feature flag in the platform_data for this
> feature like HSMMC_REVERSE_RESET_LOGIC or similar.
> 

This is not a feature. It is like an ERRATA fix. I am yet to receive an
errata number though. How about dealing with this like an errata fix similar
to the way in arch/mach-omap2/serial.c done for the uart case? 

The mmc ip revision will not help because it really does not change to
distinguish such issues.

Regards,
Madhu

> Even better, look at the mmc silicon revision number and set this
> flag automatically during the driver init if possible.
> 
> Regards,
> 
> Tony

