From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Mon, 06 Jun 2011 15:56:49 -0400
Message-ID: <m3hb82wx6m.fsf@pullcord.laptop.org>
References: <4DEBCA3F.8050205@hartkopp.net>
	<BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>
	<4DED05C4.7050903@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37711 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049Ab1FFT5N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Jun 2011 15:57:13 -0400
In-Reply-To: <4DED05C4.7050903@hartkopp.net> (Oliver Hartkopp's message of
	"Mon, 06 Jun 2011 18:52:20 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "S, Venkatraman" <svenkatr@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Oliver,

On Mon, Jun 06 2011, Oliver Hartkopp wrote:
>>> dmesg is a bit more detailed:
>>> [    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
>>> [    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>>> [    6.245788] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
>>> [    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled

If you get a chance to do some bisecting, that would be extremely
helpful -- even just building 3.0 from *before* the MMC tree was
merged would help a lot, since if the problem still happens before
the MMC merge we might be looking at some kind of generic PCI bug.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
