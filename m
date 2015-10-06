From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: All OMAP platforms: MMC is broken
Date: Tue, 6 Oct 2015 16:00:09 +0100
Message-ID: <20151006150009.GF21626@n2100.arm.linux.org.uk>
References: <20151001093325.GU21513@n2100.arm.linux.org.uk>
 <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
 <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42858 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbbJFPAY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 11:00:24 -0400
Content-Disposition: inline
In-Reply-To: <20151006094425.GM23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 02:04]:
> > On Mon, Oct 05, 2015 at 07:38:13PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Oct 05, 2015 at 10:11:56AM -0700, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [151005 07:57]:
> > > > > * Tony Lindgren <tony@atomide.com> [151005 07:44]:
> > > > > > * Tony Lindgren <tony@atomide.com> [151005 04:28]:
> > > > > > 
> > > > > > Based on some tests it seems that the duovero unpaired regulator usage
> > > > > > is fixed by reverting:
> > > > > > 
> > > > > > c55d7a055364 ("mmc: host: omap_hsmmc: use regulator_is_enabled to
> > > > > > find pbias status")
> > > > > 
> > > > > With commit c55d7a055364 my guess is that the PBIAS regulator is
> > > > > already on from an earlier MMC probe and getting re-enabled when
> > > > > a deferred probe happens?
> > > > 
> > > > Unless somebody has a better fix in mind for the above, I suggest
> > > > we revert it for the -rc kernel.
> > > 
> > > Let me try reverting that in my build tree, and...
> > > 
> > > > > > And it seems that omap3 legacy MMC is broken earlier in the
> > > > > > series with:
> > > > > > 
> > > > > > 7d607f917008 ("mmc: host: omap_hsmmc: use
> > > > > > devm_regulator_get_optional() for vmmc")
> > > > > > 
> > > > > > This one does not cleanly revert so have not yet tried reverting
> > > > > > it.
> > > > > 
> > > > > And with commit 7d607f917008 I'm guessing we can't return an
> > > > > error if the PBIAS regulator does not exist as that's not there
> > > > > for the legacy booting.
> > > > 
> > > > For omap3 legacy booting, we keep getting -EPROBE_DEFER for
> > > > all the optional regulators.
> > > > 
> > > > Something like the following might be the minimal fix for the -rc
> > > > cycle?
> > > 
> > > applying this patch.  If that gets things going again, then we
> > > _definitely_ should get both of these to Linus ASAP.  The breakage
> > > has been around far too long already.
> > 
> > Last night's build shows that this fixes the non-DT LDP3430 booting, but
> > DT-based LDP3430 and SDP4430 both remain broken for the same reason -
> > neither can find their SD cards.
> 
> Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
> Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
> working for you with DT-based booting because you don't seem to have
> CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
> for both your omap3 and omap4 seed config files?

This is precisely the kind of crap I'm objecting to.  New kernel versions
come along, and things break because people add extra Kconfig symbols that
previous versions did not rely upon - and there's no communication of
what's required for new kernel versions.

This stuff needs documenting, so that people are aware what changes they
need to make - please put something in Documentation/arm/OMAP which
tracks what new additions are required to the Kconfig to keep things
working.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
