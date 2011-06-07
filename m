From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Tue, 07 Jun 2011 20:36:54 +0200
Message-ID: <4DEE6FC6.9040308@hartkopp.net>
References: <4DEBCA3F.8050205@hartkopp.net>	<BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>	<4DED05C4.7050903@hartkopp.net> <m3hb82wx6m.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:54786 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab1FGSgw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 14:36:52 -0400
In-Reply-To: <m3hb82wx6m.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "S, Venkatraman" <svenkatr@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 06.06.2011 21:56, Chris Ball wrote:
> Hi Oliver,
> 
> On Mon, Jun 06 2011, Oliver Hartkopp wrote:
>>>> dmesg is a bit more detailed:
>>>> [    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
>>>> [    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>>>> [    6.245788] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
>>>> [    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled
> 
> If you get a chance to do some bisecting, that would be extremely
> helpful -- even just building 3.0 from *before* the MMC tree was
> merged would help a lot, since if the problem still happens before
> the MMC merge we might be looking at some kind of generic PCI bug.
> 


Hi Chris,

i just reverted this pull of your merge window patches in my 3.0.0-rc2 tree:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8c1c77ff9be27137fa7cbbf51efedef1a2ae915b;hp=f3ae1c75203535f65448517e46c8dd70a56b6c71

And you were right: The problem still exists. So it might be from the PCI subsystem :-(

[    6.167106] sdhci: Secure Digital Host Controller Interface driver
[    6.167108] sdhci: Copyright(c) Pierre Ossman
[    6.194731] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    6.195140] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf6970000
[    6.196423] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
[    6.196429] sdhci-pci 0000:03:00.1: found 1 slot(s)
[    6.196447] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    6.196451] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
[    6.196459] sdhci-pci 0000:03:00.1: PCI INT B disabled

Well then, i'll reset my tree and look for differences in the PCI boot messages.

Thanks,
Oliver
