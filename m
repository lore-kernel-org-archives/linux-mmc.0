From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Wed, 17 Feb 2016 23:35:00 +0000
Message-ID: <20160217233500.GN19428@n2100.arm.linux.org.uk>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
 <CAOMZO5DzhVMaE76Y_ZVzRMpCMyovSs4seWXKyCqeA9f=nb2CJg@mail.gmail.com>
 <20160217211818.GI19428@n2100.arm.linux.org.uk>
 <CAEG3pNDW6FefMhrgmJAFj+hGcoOZTuFDOx+NaA9sNSfD-ko+dQ@mail.gmail.com>
 <20160217221136.GL19428@n2100.arm.linux.org.uk>
 <20160217230226.GA27645@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59296 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423667AbcBQXfM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 18:35:12 -0500
Content-Disposition: inline
In-Reply-To: <20160217230226.GA27645@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Fabio Estevam <festevam@gmail.com>
Cc: Laszlo Fiat <laszlo.fiat@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Feb 17, 2016 at 11:02:26PM +0000, Russell King - ARM Linux wrote:
> From what I remember - I debugged a problem in this area, I sent a
> _tested_ patch, which you changed before merging because you had
> the above conflicting patch.  Unfortunately, the conflicting patch
> is the cause of this problem...

... and, no surprises, if I undo the changes in that original patch
and implement exactly what I sent you on January 2nd, then everything
starts working again.

And we finally have a sort-of answer on the SDHCI problem: it works
here with my _original_ set of patches I sent to the MMC list, so I
don't think this is a problem with my original set of SDHCI patches.
It could be a problem introduced by Adrian modifying my patches
before applying (which, if so, sounds just like what's happened with
clk-gpio.c all over again.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
