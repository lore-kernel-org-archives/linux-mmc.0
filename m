From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 00/24] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 12:58:51 +0000
Message-ID: <20151221125851.GA7041@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39944 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbLUM65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 07:58:57 -0500
Content-Disposition: inline
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Mon, Dec 21, 2015 at 11:39:56AM +0000, Russell King - ARM Linux wrote:
> - Fixing the SDHCI timeout calculation code to correctly round timeouts
>   up rather than down, and correctly calculate the time (in microseconds)
>   for a certain number of card clocks.

What I didn't point out, but should have, is the obvious issue.

Given that the overall effect of the currently broken code is that the
calculated timeout microsecond value is smaller than it should be, and
in the case of a card which specifies a number of clock cycles, it will
be _substantially_ smaller than it should be, I think that _all_ users
of SDHCI_QUIRK_BROKEN_TIMEOUT_VAL are suspect mis-diagnosis of this
driver bug.

Once this series goes in, I'm intending to completely rip out the
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL quirk, so diagnosis of any problems can
restart from a correct timeout calculation, and we will see how many
SDHCI implementations _actually_ have an issue.

If anyone knows for certain that the timeout hardware is broken, then
they need to reply to this point.  Otherwise, it would be useful if
people could try removing this quirk with these fixes in place, and
submit patches removing it from the drivers which are fixed by this
change.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
