From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Wed, 30 Mar 2016 21:39:04 +0100
Message-ID: <20160330203903.GJ19428@n2100.arm.linux.org.uk>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
 <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
 <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
 <20160324153056.GT19428@n2100.arm.linux.org.uk>
 <CAD=FV=VkQKaVBdR6gaoeXDso5L37aGaXV717=y=0tyAMwigpbA@mail.gmail.com>
 <20160324162220.GV19428@n2100.arm.linux.org.uk>
 <CAFqH_53Dsm5Cd6XzLai=_zGSvjQ_-uO4jQGKpBp-crztTXc-mg@mail.gmail.com>
 <20160330172604.GI19428@n2100.arm.linux.org.uk>
 <CAFqH_51sMLbURO4n7OTEuC8S-6w0Q4aRv47nEoCAmK8-MJ+Jbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43084 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcC3Ujh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2016 16:39:37 -0400
Content-Disposition: inline
In-Reply-To: <CAFqH_51sMLbURO4n7OTEuC8S-6w0Q4aRv47nEoCAmK8-MJ+Jbw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, Caesar Wang <wxt@rock-chips.com>, Alim Akhtar <alim.akhtar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Addy Ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Zhong <zyw@rock-chips.com>

On Wed, Mar 30, 2016 at 10:06:36PM +0200, Enric Balletbo Serra wrote:
> El dia 30/03/2016 19:26, "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> va escriure:
> > I'd really suggest that the dw-mmc folk place a moritorium on quirk
> > flags, and instead deal with situations like this without resorting
> > to this kind of thing.
> >
> > sdhci is a good example why the quirk flag approach is totally wrong,
> > and shows that it leads to an unmaintainable mess.  If dw-mmc people
> > don't want the driver to decend into the same state that sdhci is,
> > then things like this should not be quirks.  sdhci already has a
> > long-term moritorium on quirk flags until the resulting mess has been
> > cleaned up.
> >
> 
> You mean that was a mess in the past and now is cleaned up?

SDHCI is far from being "cleaned up" - the conclusion that I've put
forward, and Ulf appears to agree with is that the core SDHCI driver
needs to become a library.

We then need individual drivers, which make selective use of the
library functions, and the "quirks" implemented as either fixes to
the core code or implemented by replacement functions.

The problem with SDHCI is that it's not far off having every other
line of code being conditional on a quirk flag - I've submitted to
very large series of patches so far doing a series of code transforms
to reduce this, but the job is nowhere near complete.  Given the
number of drivers, it's something that needs to be done with care
and over a period of time.

This is why I'm warning about this as soon as I've heard another
driver going down the quirks route - hopefully you can avoid this
mistake early enough that it doesn't become a several year project
to sort out.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
