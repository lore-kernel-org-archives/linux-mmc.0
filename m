From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Thu, 31 Jan 2013 09:00:56 +0000
Message-ID: <201301310900.56868.arnd@arndb.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de> <201301310009.34426.arnd@arndb.de> <Pine.LNX.4.64.1301310727590.14639@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3AaJBJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 04:01:09 -0500
In-Reply-To: <Pine.LNX.4.64.1301310727590.14639@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Thursday 31 January 2013, Guennadi Liakhovetski wrote:
> On Thu, 31 Jan 2013, Arnd Bergmann wrote:
> > On Wednesday 30 January 2013, Guennadi Liakhovetski wrote:
> > > On Wed, 30 Jan 2013, Arnd Bergmann wrote:
> > 
> > I'm not saying that it should, I just thought that it did that already,
> > but I may be wrong with that. Where does the polarity of a gpio
> > line normally get set?
> 
> Well, don't think we had a generic way to handle this until now. Each 
> driver handles GPIOs in its own way. The GPIO API only provides functions 
> to reserve GPIOs, specify their direction (out / in) and set or get level 
> respectively. Besides you could set some flags like GPIOF_OPEN_DRAIN etc. 
> After a driver, say, reads low level of a GPIO it has to decide itself 
> whether it's the "on" or the "off" level, for which many drivers often use 
> their own means to specify GPIO's "polarity."

Right, Chris also mentioned the of_get_named_gpio_flags() method that
drivers would need to use to get the flags, although currently
most of them don't.

> 
> > > > and
> > > > the SDHCI_QUIRK_INVERTED_WRITE_PROTECT flag can be used to invert it
> > > > independent of it.
> > > 
> > > Right, not sure about that flag. Isn't it used for SDHCI-native WP?
> > 
> > It's used in the sdhci_check_ro() function, independent of whether
> > the bit comes from the GPIO or from the SDHCI_PRESENT_STATE
> > register.
> 
> Right, but the MMC core already has a generic MMC_CAP2_RO_ACTIVE_HIGH 
> flag, so, this flag is redundant. Perhaps, the SDHCI OF glue will have to 
> set that flag if the MMC core reports MMC_CAP2_RO_ACTIVE_HIGH.

Makes sense. It seems that the MMC_CAP2_RO_ACTIVE_HIGH flag is only
evaluated by the generic mmc_gpio_get_ro() helper function you wrote
and that is currently used in only one host driver, while the
SDHCI_QUIRK_INVERTED_WRITE_PROTECT obviously is only used in SDHCI.
It certainly makes sense to unify those flags.

> > It gets set based on the presence of the wp-inverted or the
> > older sdhci,wp-inverted property, which both get interpreted
> > in the same way.
> 
> Right, which is already a mess...

Yes. It was worse before I introduced the common mmc binding, when
each driver had its own method. I left the sdhci specific one there
because there are (old) preexising users of that on powerpc that
would suffer from an incompatible change to the binding, but I
changed some of those that I knew had few existing users.

> > > > So you could actually express the same thing by either
> > > > putting the inversion into the gpio specifier or into the *-inverted
> > > > properties.
> > > > 
> > > > If you actually provide both, that would have the same meaning as not
> > > > inverting.
> > > 
> > > Hm, that'd be a weird way to configure the pin, perhaps.
> > 
> > Yes, it's silly and I don't see a reason why you'd do that, but I think
> > it should still be considered valid.
> 
> We can do that, sure, but I'm not sure we really have to apply both to end 
> up with a non-inverted pin, or just interpret it as resundant information 
> and invert once.

Fine with me, too. It's not a case I'm worried about for the practical
applications. My thought was that it would be just as easy and more logical
to combine the two using XOR as it is using OR logic wherever they get
interpreted, but if it's easier to use OR, then I don't object.

	Arnd
