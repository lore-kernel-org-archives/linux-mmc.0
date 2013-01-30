From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and
 wp-inverted DT properties
Date: Wed, 30 Jan 2013 17:13:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301301709400.3113@axis700.grange>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
 <1358955158-1510-3-git-send-email-g.liakhovetski@gmx.de> <874ni16j6j.fsf@laptop.org>
 <201301301547.24961.arnd@arndb.de> <Pine.LNX.4.64.1301301656370.3113@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1301301656370.3113@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 30 Jan 2013, Guennadi Liakhovetski wrote:

> Hi Arnd
> 
> Thanks for your input.
> 
> On Wed, 30 Jan 2013, Arnd Bergmann wrote:
> 
> > On Monday 28 January 2013, Chris Ball wrote:
> > > On Wed, Jan 23 2013, Guennadi Liakhovetski wrote:
> > > > +cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
> > > > +instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
> > > > +that the default (as defined by the SDHCI standard) CD and WP polarity is
> > > > +active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
> > > > +clear, if the polarity is inverted.
> > > 
> > > Please use this text for your next version, fixing typos and a newline:
> > > 
> > > cd-inverted and wp-inverted properties are deprecated and shouldn't be used,
> > > instead please use the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings.
> > > Note that the default (as defined by the SDHCI standard) CD and WP polarity
> > > is active-low, so OF_GPIO_ACTIVE_LOW should normally be set, and only be
> > > left clear if the polarity is inverted.
> > 
> > Hmm, I wonder if this is possible in general. A lot of the GPIO bindings
> > allow passing flags, but I think that some of them do not, for historic
> > reasons. If we want to deprecate the behavior in eMMC, we should also
> > ensure that all gpio drivers are extended to support gpio specifiers
> > with flags. It should be possible to extend all drivers in a compatible
> > way, but someone has to do that.
> > 
> > When we introduced the MMC binding, the situation was already like this,
> > and it seemed easier to leave the {wp,cd}-inverted properties as optional.
> 
> This means, that a multi-platform driver like, e.g. SDHCI cannot use the 
> gpio "flags" cell and has to fall-back to always use "*-inverted" 
> properties. Same holds for any other multi-arch driver, using GPIOs. So, 
> we're stuck with this?

BTW, just verified in the current "next": all platforms, using cd-inverted 
or wp-inverted in the mainline

arch/arm/boot/dts/ccu9540.dts
arch/arm/boot/dts/ea3250.dts
arch/arm/boot/dts/phy3250.dts
arch/arm/boot/dts/snowball.dts
arch/arm/boot/dts/u9540.dts

use GPIO controllers with 2 or 3 cells.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
