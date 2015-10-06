From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Tue, 6 Oct 2015 08:37:11 -0700
Message-ID: <20151006153710.GS23801@atomide.com>
References: <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
 <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56304 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbbJFPhQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Oct 2015 11:37:16 -0400
Content-Disposition: inline
In-Reply-To: <20151006150009.GF21626@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 08:04]:
> On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
> > 
> > Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
> > Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
> > working for you with DT-based booting because you don't seem to have
> > CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
> > for both your omap3 and omap4 seed config files?
> 
> This is precisely the kind of crap I'm objecting to.  New kernel versions
> come along, and things break because people add extra Kconfig symbols that
> previous versions did not rely upon - and there's no communication of
> what's required for new kernel versions.
> 
> This stuff needs documenting, so that people are aware what changes they
> need to make - please put something in Documentation/arm/OMAP which
> tracks what new additions are required to the Kconfig to keep things
> working.

Good idea, how about something like the following? AFAIK that's the
only .config option needed as MFD_SYSCON is selected by Kconfig
already.

Regrds,

Tony

8< ----------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 6 Oct 2015 08:33:16 -0700
Subject: [PATCH] Documentation: ARM: List new omap MMC requirements

Earlier the PBIAS regulator was optional, not so with recent
omap_hsmmc changes. To make things easier for people with
custom .config files, let's add minimal documentation for it
as suggested by Russell King <rmk+kernel@arm.linux.org.uk>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- /dev/null
+++ b/Documentation/arm/OMAP/README
@@ -0,0 +1,7 @@
+This file contains documentation for running mainline
+kernel on omaps.
+
+KERNEL		NEW DEPENDENCIES
+v4.3+		Update is needed for custom .config files to make sure
+		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
+		properly.
