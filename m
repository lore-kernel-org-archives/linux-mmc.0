From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Mon, 5 Oct 2015 07:35:32 -0700
Message-ID: <20151005143532.GA23801@atomide.com>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
 <20150924233756.GN23801@atomide.com>
 <20151001093325.GU21513@n2100.arm.linux.org.uk>
 <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
 <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55967 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbbJEOfh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Oct 2015 10:35:37 -0400
Content-Disposition: inline
In-Reply-To: <20151005112304.GZ23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "arm@kernel.org" <arm@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

* Tony Lindgren <tony@atomide.com> [151005 04:28]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [151001 03:07]:
> > On Thu, Oct 01, 2015 at 11:50:00AM +0200, Ulf Hansson wrote:
> > > On 1 October 2015 at 11:33, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Thu, Sep 24, 2015 at 04:37:56PM -0700, Tony Lindgren wrote:
> > > >> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150924 02:04]:
> > > >> > Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
> > > >> > SDP fail to boot due to lack of working MMC.  Both platforms fail to
> > > >> > find their rootfs, which is on a SD card.
> > > >> >
> > > >> > The breakage occurred somewhere between trees of September 9th (commit
> > > >> > 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
> > > >> > merge window.
> > > >>
> > > >> Yes sorry things got messed up in multiple ways :( I've summarized
> > > >> the mess here earlier:
> > > >>
> > > >> http://article.gmane.org/gmane.linux.kernel.mmc/33911
> > > >>
> > > >> And today commit b9c93646fd5c ("regulator: pbias: program pbias register
> > > >> offset in pbias driver") hit mainline so I'll send a pull request for
> > > >> the related dts change.
> > > >
> > > > It's still broken and untestable.  We're 8 days off it being a full
> > > > month worth of failed testing for OMAP3 and OMAP4 platforms.
> > > >
> > > > I think OMAP and MMC people need to do a post-mortem and work out why
> > > > this happened, and how to stop it happening again in the future.
> > > 
> > > You are probably right!
> > > 
> > > I think I should have been more persistent when asking on how to deal
> > > with these patches. Typically they should all have gone together via
> > > one tree, or we needed a slower way forward keeping changes more
> > > standalone.
> > > 
> > > Anyway, according to kernelci.org, which builds and boot my next
> > > branch omap3/4 seems to boot now...
> > > http://kernelci.org/boot/all/job/ulfh/kernel/v4.3-rc3-27-gf7734d097520/
> > 
> > It continues to fail here.
> > 
> > Okay, sod it, I'm at the point of just not giving a damn about whether
> > OMAP3 and OMAP4 boot anymore.
> > 
> > I'm taking all OMAP platforms out of my boot farm.  I'm totally fed up
> > with this kind of regression happening.  It's probably some config option
> > that someone's recently introduced which defaults to being off, thereby
> > breaking the ability for people to move forward without constantly having
> > to re-configure.  This is not acceptable.
> > 
> > STOP BREAKING THE KERNEL.
> 
> I totally agree, this is unacceptable. And I'm fed up chasing driver
> breakage and trying to test everything myself.
> 
> If Kihon is not starting to respond to these issues, we better start
> reverting some of the MMC patches. And I'd say in the future non-trivial
> patches really have to sit in linux next for two weeks before merging.
> 
> We have still the omap3 legacy booting issue remaining, and warnings
> at least on omap4 overo.

Sorry i mean Kishon instead of Kihon above.

Based on some tests it seems that the duovero unpaired regulator usage
is fixed by reverting:

c55d7a055364 ("mmc: host: omap_hsmmc: use regulator_is_enabled to
find pbias status")

And it seems that omap3 legacy MMC is broken earlier in the
series with:

7d607f917008 ("mmc: host: omap_hsmmc: use
devm_regulator_get_optional() for vmmc")

This one does not cleanly revert so have not yet tried reverting
it.

I'm at ELCE so there may be delays for me debugging stuff. Anybody
see obvious places to fix with those two patches above?

Regards,

Tony
