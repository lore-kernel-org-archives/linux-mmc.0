From: Chris Ball <cjb@laptop.org>
Subject: Re: Libertas/SDIO deep sleep mode
Date: Fri, 04 Jun 2010 10:59:14 -0400
Message-ID: <m3631y7sjh.fsf@pullcord.laptop.org>
References: <20100604121245.GW2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53914 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab0FDO5Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Jun 2010 10:57:16 -0400
In-Reply-To: <20100604121245.GW2695@buzzloop.caiaq.de> (Daniel Mack's message
	of "Fri, 4 Jun 2010 14:12:45 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: libertas-dev@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>

Hi,

   > Hi, I read about the recently added features in the libertas
   > driver to send the chip to its deep-sleep mode when the system
   > suspends, so the wakeup phase is shortened.

I think there might be a bit of terminology confusion here -- as
I understand it, "deep sleep" refers to putting the 8686 into a
power-saving mode after a certain amount of idle time, while the
rest of the system is running.

If you want to preserve power to the 8686 over a system suspend,
that's a largely different set of code, which isn't complete in
mainline yet; as you've seen, the MMC and SDHCI side of it is
upstream, but not libertas or pxamci code yet.

   > * The "Parentless device registered during a PM transaction"
   > looks like a bug to me. Note that I added kobject_name(&dev->kobj)
   > to the output to get a clue about what's going on.

Not sure what's going on there.

   > * The firmware survives the suspend/resume transition and works
   > fine after that. I just wonder why, as the voltage was switched
   > off?

That's odd.  Perhaps the 8686 is being alternatively powered somehow
on your hardware?

   > * I believe that if we need to keep the power switched on, there
   > should be a call to sdio_set_host_pm_flags(MMC_PM_KEEP_POWER)
   > somewhere in the libertas_sdio layer, right? How should the
   > pxamci core get to know it shouldn't switch off its regulator?

That's right.  We're using this code at OLPC, to go into system
suspend with the 8686 powered and then be woken when a new packet
arrives.  The libertas side of that code hasn't been submitted yet,
but you're welcome to check it out at our git repo:

http://dev.laptop.org/git/olpc-2.6/commit/?h=olpc-2.6.31&id=db09aa1f537f7d5eae6e52ecf59cdf3571150ee6
http://dev.laptop.org/git/olpc-2.6/log/drivers/net/wireless/libertas?h=olpc-2.6.31

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
