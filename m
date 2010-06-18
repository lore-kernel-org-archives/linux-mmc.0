From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Anyone else seen this wierd sdhci problem?
Date: Fri, 18 Jun 2010 16:24:13 +0300
Message-ID: <1276867453.22527.14.camel@maxim-laptop>
References: <alpine.NEB.2.01.1006100007290.6369@jrf.vwaro.pbz>
	 <m3r5kfg1us.fsf@pullcord.laptop.org>
	 <alpine.NEB.2.01.1006100902200.15823@jrf.vwaro.pbz>
	 <1276162780.18013.3.camel@dell20>
	 <alpine.NEB.2.01.1006102243010.10395@jrf.vwaro.pbz>
	 <1276208162.3113.4.camel@maxim-laptop>
	 <alpine.NEB.2.01.1006102345450.23786@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:16697 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab0FRNYR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2010 09:24:17 -0400
Received: by fg-out-1718.google.com with SMTP id l26so407202fgb.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2010 06:24:16 -0700 (PDT)
In-Reply-To: <alpine.NEB.2.01.1006102345450.23786@jrf.vwaro.pbz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

We did some testing on this controller.

I came now to conclusion that I can't fix this problem for now.
Therefore I am posting here the results, in hope somebody else could
spot something interesting.

We are talking about Ricoh R5C822 controller, but not the one that is
part of R5C832 (firewire) multifunction chip, but rather, the one that
is part of R5C552 (firewire), RL5c476 II(cardbus).

The problem is that SD/SDHCI card just don't work.
This wasn't yet tested in windows, although I recommend doing so because
it might be just a hardware malfunction.

Also, it was found that enabling internal modem in bios makes this
problem show up a bit late that usual.

First card seem to work just fine, but after a while, it stops
responding completely:


mmc0: starting CMD17 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00408020
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000

mmc0:     0 bytes transferred: -84

mmc0: starting CMD13 arg b3680000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000

mmcblk0: error -84 transferring data, sector 0, nr 32, card status 0x900
end_request: I/O error, dev mmcblk0, sector 0

mmc0: starting CMD17 arg 00000200 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00408020
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000

mmc0:     0 bytes transferred: -84



I tested a patch that removes all but sd/sdhci support from mmc, and
card seem to 'last longer', that is block core is able to read partition
table.

Also we disabled DMA, high-speed mode, tried lowering initial clock, and
no effect was observed.

@Mark Hills, now I understand the test we did by skipping the read of
sector #0 was a red herring.

That is pretty much all.
Anybody else have seen it?

Best regards,
Maxim Levitsky


