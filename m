From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 03/13] mmc: provide a standard MMC device-tree binding parser centrally
Date: Sat, 16 Feb 2013 10:54:36 +0000
Message-ID: <201302161054.36492.arnd@arndb.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de> <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de> <20130216060526.GA20785@verge.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130216060526.GA20785@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Saturday 16 February 2013, Simon Horman wrote:
> > +void mmc_of_parse(struct mmc_host *host)
> > +{
> > +     struct device_node *np;
> > +     u32 bus_width;
> > +     bool explicit_inv_wp, gpio_inv_wp = false;
> > +     enum of_gpio_flags flags;
> > +     int len, ret, gpio;
> > +
> > +     if (!host->parent || !host->parent->of_node)
> > +             return;
> > +
> > +     np = host->parent->of_node;
> > +
> > +     /* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
> > +     if (of_property_read_u32_array(np, "bus-width", &bus_width, 1) < 0)
> > +             dev_dbg(host->parent,
> > +                     "\"bus-width\" property is missing, assuming 1 bit.\n");
> > +
> > +     switch (bus_width) {
> 
> kbuild tells me that gcc thinks that bus_width is used without being
> initialised here. Assuming that of_property_read_u32_array always
> initialises bus_width if it returns zero then perhaps it would be worth
> considering using uninitialized_var().

I think this is a false positive that I encountered before and that should be gone
with gcc-4.7 or higher when using -O2 instead of -Os. I have a patch to disable
-Wmaybe-uninitialized when builing with -Os. If that gets rid of the warning,
I'd prefer not annotating it here.

There was some discussion about removing uninitialized_var() recently after it
was found to hide some real bugs.

	Arnd
