From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Tue, 6 Oct 2015 02:44:25 -0700
Message-ID: <20151006094425.GM23801@atomide.com>
References: <20150924233756.GN23801@atomide.com>
 <20151001093325.GU21513@n2100.arm.linux.org.uk>
 <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
 <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56213 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbbJFJo3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Oct 2015 05:44:29 -0400
Content-Disposition: inline
In-Reply-To: <20151006090015.GE21626@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 02:04]:
> On Mon, Oct 05, 2015 at 07:38:13PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 05, 2015 at 10:11:56AM -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [151005 07:57]:
> > > > * Tony Lindgren <tony@atomide.com> [151005 07:44]:
> > > > > * Tony Lindgren <tony@atomide.com> [151005 04:28]:
> > > > > 
> > > > > Based on some tests it seems that the duovero unpaired regulator usage
> > > > > is fixed by reverting:
> > > > > 
> > > > > c55d7a055364 ("mmc: host: omap_hsmmc: use regulator_is_enabled to
> > > > > find pbias status")
> > > > 
> > > > With commit c55d7a055364 my guess is that the PBIAS regulator is
> > > > already on from an earlier MMC probe and getting re-enabled when
> > > > a deferred probe happens?
> > > 
> > > Unless somebody has a better fix in mind for the above, I suggest
> > > we revert it for the -rc kernel.
> > 
> > Let me try reverting that in my build tree, and...
> > 
> > > > > And it seems that omap3 legacy MMC is broken earlier in the
> > > > > series with:
> > > > > 
> > > > > 7d607f917008 ("mmc: host: omap_hsmmc: use
> > > > > devm_regulator_get_optional() for vmmc")
> > > > > 
> > > > > This one does not cleanly revert so have not yet tried reverting
> > > > > it.
> > > > 
> > > > And with commit 7d607f917008 I'm guessing we can't return an
> > > > error if the PBIAS regulator does not exist as that's not there
> > > > for the legacy booting.
> > > 
> > > For omap3 legacy booting, we keep getting -EPROBE_DEFER for
> > > all the optional regulators.
> > > 
> > > Something like the following might be the minimal fix for the -rc
> > > cycle?
> > 
> > applying this patch.  If that gets things going again, then we
> > _definitely_ should get both of these to Linus ASAP.  The breakage
> > has been around far too long already.
> 
> Last night's build shows that this fixes the non-DT LDP3430 booting, but
> DT-based LDP3430 and SDP4430 both remain broken for the same reason -
> neither can find their SD cards.

Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
working for you with DT-based booting because you don't seem to have
CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
for both your omap3 and omap4 seed config files?

> We're at -rc4.  That means we're could be only three weeks away from 4.3
> being released, and DT OMAP has yet to boot _once_ here.
> 
> What I find *totally* unacceptable is the lack of reaction from the MMC
> and TI people: it's just like "we'll break your crap, and we'll ignore
> reports of regressions."  That is *not* acceptable in any shape or form,
> and people who do this _should_ have their future patches ignored until
> they demonstrate that they understand the need to not break stuff.
> 
> I'm at the point of suggesting that there should be a moritorium on all
> OMAP related development for 4.4: delay all development to 4.5, and have
> 4.4 as a pure bug-fixing _only_ cycle for OMAP.  If 4.3 is released and
> OMAP is still broken, then I don't think there's an option on that.
> 
> Maybe the idea that development work won't hit mainline for another 4
> months will help focus the minds on not breaking stuff and then ignoring
> regression reports.

I'm thinking along the same lines. In general, I do not and will not
apply any patches that are not fixes until all critical regressions are
out of the way. So not applying anything new for v4.4 until these MMC
regressions are fixed for v4.3.

Regards,

Tony

[1] http://muru.com/for-rmk/dmesg-ldp-v4.3-rc4-mmc-fixes.txt
