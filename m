From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 00/24] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 13:41:38 +0000
Message-ID: <20151221134138.GB8644@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <CAPDyKFogxmczEzXbXACrfn4F2wfM=ZKPVnpK8WSLJA3UT5SKiw@mail.gmail.com>
 <20151221125120.GZ8644@n2100.arm.linux.org.uk>
 <CAPDyKFrxJBAiic44VRWRW-53vz6GqosH+6_qbFSgQnJ5aew=BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40028 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbLUNlq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 08:41:46 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxJBAiic44VRWRW-53vz6GqosH+6_qbFSgQnJ5aew=BQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Mon, Dec 21, 2015 at 02:23:17PM +0100, Ulf Hansson wrote:
> On 21 December 2015 at 13:51, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 21, 2015 at 01:35:36PM +0100, Ulf Hansson wrote:
> >> I decided to try to apply it for my next branch, to get some good test
> >> coverage. Although, it failed when reaching patch 8. Would you mind
> >> posting yet another new re-based version, please.
> >
> > Given that these are _fixes_ and need to be applied to -rc kernels, they
> > are based on -rc6.  I don't see the point of rebasing them onto non-rc
> > kernels to test, because then you're not testing against where they
> > should be applied.
> 
> I see your point, but I would rather not aim for rcs with these
> changes, unless you insist.
> 
> Not because they aren't fixes, but because it's old errors. Instead we
> can "cc stable" or use the fixes tag as we are in quite late stage of
> the rc. This approach will also allow us to get a bit better test
> coverage.

Even if we do this, we still need to get _these_ tested because _these_
will be the ones which need to be applied to stable trees such as the
4.4 stable series.

What I suggest is applying them against -rc6, and then merging them
into your -next branch, and fixing the resulting conflicts.  We then
have the patches ready for -rc, but which can still be tested in -next
(for what that's worth.)  If people find problems, they can always
re-test these patches without all the development stuff.

If I were to give you a set of patches suitable just for -next, then
people can only test with all the development stuff included, and we'll
have no idea whether any new problems are the result of development or
these patches.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
