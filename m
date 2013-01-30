From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Wed, 30 Jan 2013 16:29:45 +0000
Message-ID: <201301301629.45511.arnd@arndb.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de> <Pine.LNX.4.64.1301301656370.3113@axis700.grange> <Pine.LNX.4.64.1301301709400.3113@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49693 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab3A3Q3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 11:29:55 -0500
In-Reply-To: <Pine.LNX.4.64.1301301709400.3113@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Wednesday 30 January 2013, Guennadi Liakhovetski wrote:
> > This means, that a multi-platform driver like, e.g. SDHCI cannot use the 
> > gpio "flags" cell and has to fall-back to always use "*-inverted" 
> > properties. Same holds for any other multi-arch driver, using GPIOs. So, 
> > we're stuck with this?

But the SDHCI driver itself would not interpret the flags anyway, would it?
>From the code, I understand that of_get_named_gpio() would return a gpio
line with the polarity already inverted if it's specified that way, and
the SDHCI_QUIRK_INVERTED_WRITE_PROTECT flag can be used to invert it
independent of it. So you could actually express the same thing by either
putting the inversion into the gpio specifier or into the *-inverted
properties.

If you actually provide both, that would have the same meaning as not
inverting.

> BTW, just verified in the current "next": all platforms, using cd-inverted 
> or wp-inverted in the mainline
> 
> arch/arm/boot/dts/ccu9540.dts
> arch/arm/boot/dts/ea3250.dts
> arch/arm/boot/dts/phy3250.dts
> arch/arm/boot/dts/snowball.dts
> arch/arm/boot/dts/u9540.dts
> 
> use GPIO controllers with 2 or 3 cells.

What about those that don't use a GPIO line at all but instead use a
built-in write-protect and card-detect registers of the SDHCI controller?

The Freescale ESDHC on powerpc mpc83xx seems to do that, and require 
the wp-inverted flag.

	Arnd
