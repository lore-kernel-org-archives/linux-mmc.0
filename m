From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and
 wp-inverted DT properties
Date: Wed, 30 Jan 2013 18:03:35 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301301743470.3113@axis700.grange>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1301301656370.3113@axis700.grange>
 <Pine.LNX.4.64.1301301709400.3113@axis700.grange> <201301301629.45511.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201301301629.45511.arnd@arndb.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 30 Jan 2013, Arnd Bergmann wrote:

> On Wednesday 30 January 2013, Guennadi Liakhovetski wrote:
> > > This means, that a multi-platform driver like, e.g. SDHCI cannot use the 
> > > gpio "flags" cell and has to fall-back to always use "*-inverted" 
> > > properties. Same holds for any other multi-arch driver, using GPIOs. So, 
> > > we're stuck with this?
> 
> But the SDHCI driver itself would not interpret the flags anyway, would it?

Currently each driver, including SDHCI, does it on its own, the goal is to 
do this centrally. And yes, in our specific MMC case, if we want to 
support GPIO controllers with 1 cell, no mmc DT node, using GPIOs for WP 
or CD should be using the inversion flag - even where possible.

> From the code, I understand that of_get_named_gpio() would return a gpio
> line with the polarity already inverted if it's specified that way,

Sorry, don't understand. of_get_named_gpio() just returns a GPIO number, 
not GPIO level. It doesn't even actually request the GPIO for the specific 
user. Or do you mean, that gpio_chip::of_xlate() should request the chip 
to invert the GPIO from now on?

> and
> the SDHCI_QUIRK_INVERTED_WRITE_PROTECT flag can be used to invert it
> independent of it.

Right, not sure about that flag. Isn't it used for SDHCI-native WP?

> So you could actually express the same thing by either
> putting the inversion into the gpio specifier or into the *-inverted
> properties.
> 
> If you actually provide both, that would have the same meaning as not
> inverting.

Hm, that'd be a weird way to configure the pin, perhaps.

> > BTW, just verified in the current "next": all platforms, using cd-inverted 
> > or wp-inverted in the mainline
> > 
> > arch/arm/boot/dts/ccu9540.dts
> > arch/arm/boot/dts/ea3250.dts
> > arch/arm/boot/dts/phy3250.dts
> > arch/arm/boot/dts/snowball.dts
> > arch/arm/boot/dts/u9540.dts
> > 
> > use GPIO controllers with 2 or 3 cells.
> 
> What about those that don't use a GPIO line at all but instead use a
> built-in write-protect and card-detect registers of the SDHCI controller?

The mmc.txt document specifies cd-inverted and wp-inverted _explicitly_ 
for use with GPIOs. If we want to use them with built-in CD and WP pins, 
we have to modify those definitions too.

Thanks
Guennadi

> The Freescale ESDHC on powerpc mpc83xx seems to do that, and require 
> the wp-inverted flag.
> 
> 	Arnd
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
