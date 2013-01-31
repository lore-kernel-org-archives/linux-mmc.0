From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Thu, 31 Jan 2013 00:09:34 +0000
Message-ID: <201301310009.34426.arnd@arndb.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de> <201301301629.45511.arnd@arndb.de> <Pine.LNX.4.64.1301301743470.3113@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63538 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab3AaAJq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 19:09:46 -0500
In-Reply-To: <Pine.LNX.4.64.1301301743470.3113@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Wednesday 30 January 2013, Guennadi Liakhovetski wrote:
> On Wed, 30 Jan 2013, Arnd Bergmann wrote:
> 
> > On Wednesday 30 January 2013, Guennadi Liakhovetski wrote:
> > > > This means, that a multi-platform driver like, e.g. SDHCI cannot use the 
> > > > gpio "flags" cell and has to fall-back to always use "*-inverted" 
> > > > properties. Same holds for any other multi-arch driver, using GPIOs. So, 
> > > > we're stuck with this?
> > 
> > But the SDHCI driver itself would not interpret the flags anyway, would it?
> 
> Currently each driver, including SDHCI, does it on its own, the goal is to 
> do this centrally. And yes, in our specific MMC case, if we want to 
> support GPIO controllers with 1 cell, no mmc DT node, using GPIOs for WP 
> or CD should be using the inversion flag - even where possible.
> 
> > From the code, I understand that of_get_named_gpio() would return a gpio
> > line with the polarity already inverted if it's specified that way,
> 
> Sorry, don't understand. of_get_named_gpio() just returns a GPIO number, 
> not GPIO level. It doesn't even actually request the GPIO for the specific 
> user. Or do you mean, that gpio_chip::of_xlate() should request the chip 
> to invert the GPIO from now on?

I'm not saying that it should, I just thought that it did that already,
but I may be wrong with that. Where does the polarity of a gpio
line normally get set?

> > and
> > the SDHCI_QUIRK_INVERTED_WRITE_PROTECT flag can be used to invert it
> > independent of it.
> 
> Right, not sure about that flag. Isn't it used for SDHCI-native WP?

It's used in the sdhci_check_ro() function, independent of whether
the bit comes from the GPIO or from the SDHCI_PRESENT_STATE
register.

It gets set based on the presence of the wp-inverted or the
older sdhci,wp-inverted property, which both get interpreted
in the same way.

> > So you could actually express the same thing by either
> > putting the inversion into the gpio specifier or into the *-inverted
> > properties.
> > 
> > If you actually provide both, that would have the same meaning as not
> > inverting.
> 
> Hm, that'd be a weird way to configure the pin, perhaps.

Yes, it's silly and I don't see a reason why you'd do that, but I think
it should still be considered valid.

> > > BTW, just verified in the current "next": all platforms, using cd-inverted 
> > > or wp-inverted in the mainline
> > > 
> > > arch/arm/boot/dts/ccu9540.dts
> > > arch/arm/boot/dts/ea3250.dts
> > > arch/arm/boot/dts/phy3250.dts
> > > arch/arm/boot/dts/snowball.dts
> > > arch/arm/boot/dts/u9540.dts
> > > 
> > > use GPIO controllers with 2 or 3 cells.
> > 
> > What about those that don't use a GPIO line at all but instead use a
> > built-in write-protect and card-detect registers of the SDHCI controller?
> 
> The mmc.txt document specifies cd-inverted and wp-inverted _explicitly_ 
> for use with GPIOs. If we want to use them with built-in CD and WP pins, 
> we have to modify those definitions too.

Yes, that makes sense. The way that the specific esdhc binding is written
does not refer to gpio and could be interpreted the way that it is used
in the driver (for both gpio and internal wp), but it's certainly a
good idea to clarify it in the common binding.

	Arnd
