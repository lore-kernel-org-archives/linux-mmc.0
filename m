From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: sdhci(imx6): misbehaves while installing debian jessie, "Got data
 interrupt 0x00100000"
Date: Tue, 19 May 2015 23:23:21 +0100
Message-ID: <20150519222320.GM2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58124 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbESWX0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 18:23:26 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

iMX6 with a Samsung EVO UHS-1 16GB card.

There's actually two problems here.

1. SDHCI chooses to impose a 10 second timeout on any data operation.
   This magic value of 10 seconds is rediculous.  Consider that SD
   cards are typically slower than ATA, and ATA has a timeout of more
   than one minute for a stuck command...  And yes, I've had this fire
   a good 10 seconds before I then got...

2. "Got data interrupt 0x00100000 even though no data operation was in progress."

   That's SDHCI_INT_DATA_TIMEOUT.

   Unfortunately, I have no other information, as the registers are
   dumped at pr_debug() level, which means that they're all compiled
   out in normal kernel builds.  In any case, I have no way to copy
   information off of the installing system; debian does not start up
   a ssh daemon during the install, so remote login is not possible.
   Nor can I photograph the rather reflective TV screen.

The side-effect of this is that the entire MMC IO subsystem locks up
and I'm left with lots of processes stuck in IO-wait state, with the
hungtask detector spewing onto the console.

This happens while installing Debian Jessie, which is an "expensive"
operation: not only in time (it takes 45 minutes or so to reproduce,
requiring the stupid debian installer to be babysat during that time)
but also because it's having to download the entire distro for each
attempt (which eats into my monthly bandwidth allowance, so I can
_only_ do this after 8pm local time.)

I've tried twice tonight (which is about the limit that I can do in an
evening), the second time after having up-ed the stupid 10 second limit
to 60 seconds.  However (2) still occurs.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
