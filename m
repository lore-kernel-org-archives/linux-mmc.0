From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4 03/13] mmc: provide a standard MMC device-tree binding
 parser centrally
Date: Sat, 16 Feb 2013 15:02:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302161457140.20044@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de>
 <20130216060526.GA20785@verge.net.au> <201302161054.36492.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58697 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab3BPOCw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Feb 2013 09:02:52 -0500
In-Reply-To: <201302161054.36492.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

On Sat, 16 Feb 2013, Arnd Bergmann wrote:

> On Saturday 16 February 2013, Simon Horman wrote:
> > > +void mmc_of_parse(struct mmc_host *host)
> > > +{
> > > +     struct device_node *np;
> > > +     u32 bus_width;
> > > +     bool explicit_inv_wp, gpio_inv_wp = false;
> > > +     enum of_gpio_flags flags;
> > > +     int len, ret, gpio;
> > > +
> > > +     if (!host->parent || !host->parent->of_node)
> > > +             return;
> > > +
> > > +     np = host->parent->of_node;
> > > +
> > > +     /* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
> > > +     if (of_property_read_u32_array(np, "bus-width", &bus_width, 1) < 0)
> > > +             dev_dbg(host->parent,
> > > +                     "\"bus-width\" property is missing, assuming 1 bit.\n");
> > > +
> > > +     switch (bus_width) {
> > 
> > kbuild tells me that gcc thinks that bus_width is used without being
> > initialised here. Assuming that of_property_read_u32_array always
> > initialises bus_width if it returns zero then perhaps it would be worth
> > considering using uninitialized_var().
> 
> I think this is a false positive that I encountered before and that should be gone
> with gcc-4.7 or higher when using -O2 instead of -Os. I have a patch to disable
> -Wmaybe-uninitialized when builing with -Os. If that gets rid of the warning,
> I'd prefer not annotating it here.

Unfortunately, this does seem to be a real bug, I lost the default 
initialisation to one somewhere along the way... I'll send a trivial 
update. Stupidly, my cross-toolchain doesn't report this error.

Thanks
Guennadi

> There was some discussion about removing uninitialized_var() recently after it
> was found to hide some real bugs.
> 
> 	Arnd

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
