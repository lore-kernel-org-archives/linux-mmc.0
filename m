From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Wed, 30 Jan 2013 15:47:24 +0000
Message-ID: <201301301547.24961.arnd@arndb.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de> <1358955158-1510-3-git-send-email-g.liakhovetski@gmx.de> <874ni16j6j.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <874ni16j6j.fsf@laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Monday 28 January 2013, Chris Ball wrote:
> On Wed, Jan 23 2013, Guennadi Liakhovetski wrote:
> > +cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
> > +instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
> > +that the default (as defined by the SDHCI standard) CD and WP polarity is
> > +active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
> > +clear, if the polarity is inverted.
> 
> Please use this text for your next version, fixing typos and a newline:
> 
> cd-inverted and wp-inverted properties are deprecated and shouldn't be used,
> instead please use the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings.
> Note that the default (as defined by the SDHCI standard) CD and WP polarity
> is active-low, so OF_GPIO_ACTIVE_LOW should normally be set, and only be
> left clear if the polarity is inverted.

Hmm, I wonder if this is possible in general. A lot of the GPIO bindings
allow passing flags, but I think that some of them do not, for historic
reasons. If we want to deprecate the behavior in eMMC, we should also
ensure that all gpio drivers are extended to support gpio specifiers
with flags. It should be possible to extend all drivers in a compatible
way, but someone has to do that.

When we introduced the MMC binding, the situation was already like this,
and it seemed easier to leave the {wp,cd}-inverted properties as optional.

	Arnd
