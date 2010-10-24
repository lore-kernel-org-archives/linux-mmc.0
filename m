From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: sdhci_pci: card insertion not detected after s2disk
Date: Sun, 24 Oct 2010 23:55:54 +0200
Message-ID: <1287957354.24074.13.camel@maxim-laptop>
References: <20101024123540.GA14424@nb-core2.darkstar.lan>
	 <1287953183.24074.6.camel@maxim-laptop>
	 <20101024211759.GA6163@nb-core2.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35805 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab0JXV4A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Oct 2010 17:56:00 -0400
Received: by bwz11 with SMTP id 11so1878367bwz.19
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2010 14:55:59 -0700 (PDT)
In-Reply-To: <20101024211759.GA6163@nb-core2.darkstar.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Sun, 2010-10-24 at 23:17 +0200, Luca Tettamanti wrote:
> On Sun, Oct 24, 2010 at 10:46:23PM +0200, Maxim Levitsky wrote:
> > This is very strange.
> > I had quite a lot of similar problems with this device.
> > But these seem to be caused by CONFIG_MMC_RICOH_MMC
> > which you don't have enabled.
> > But you use my code that makes sdhci bind to mmc controller.
> > 
> > So that what I would be very happy if you do:
> > 
> > 1. post lspci output.
> 
> I guess you're interested in the Firewire controller :)
No, but to see if you have xD and memstick controller.
Hardware I wrote drivers for after all....

> 
> 00:00.0 Host bridge [0600]: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub [8086:2a00] (rev 03)
> 00:01.0 PCI bridge [0604]: Intel Corporation Mobile PM965/GM965/GL960 PCI Express Root Port [8086:2a01] (rev 03)
> 00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #4 [8086:2834] (rev 03)
> 00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 [8086:2835] (rev 03)
> 00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 [8086:283a] (rev 03)
> 00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD Audio Controller [8086:284b] (rev 03)
> 00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 [8086:283f] (rev 03)
> 00:1c.1 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 [8086:2841] (rev 03)
> 00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 [8086:2843] (rev 03)
> 00:1c.3 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 [8086:2845] (rev 03)
> 00:1c.4 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 [8086:2847] (rev 03)
> 00:1c.5 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 6 [8086:2849] (rev 03)
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 [8086:2830] (rev 03)
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 [8086:2831] (rev 03)
> 00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 [8086:2832] (rev 03)
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 [8086:2836] (rev 03)
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [8086:2448] (rev f3)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801HEM (ICH8M) LPC Interface Controller [8086:2815] (rev 03)
> 00:1f.1 IDE interface [0101]: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller [8086:2850] (rev 03)
> 00:1f.2 SATA controller [0106]: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller [8086:2829] (rev 03)
> 01:00.0 VGA compatible controller [0300]: ATI Technologies Inc M76 [Radeon Mobility HD 2600 Series] [1002:9581]
> 02:00.0 Ethernet controller [0200]: Atheros Communications L1 Gigabit Ethernet [1969:1048] (rev b0)
> 03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4229] (rev 61)
> 04:00.0 SATA controller [0106]: JMicron Technology Corp. JMB360 AHCI Controller [197b:2360] (rev 02)
> 09:01.0 FireWire (IEEE 1394) [0c00]: Ricoh Co Ltd R5C832 IEEE 1394 Controller [1180:0832] (rev 05)
> 09:01.1 SD Host controller [0805]: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter [1180:0822] (rev 22)
> 09:01.2 System peripheral [0880]: Ricoh Co Ltd R5C843 MMC Host Controller [1180:0843] (rev 12)
> 09:01.3 System peripheral [0880]: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter [1180:0592] (rev 12)
I have written a driver for this one too (posted to LKML many times).

> 09:01.4 System peripheral [0880]: Ricoh Co Ltd xD-Picture Card Controller [1180:0852] (rev 12)
> 
> > 2. Test if this is reproducible.
> 
> Will recompile and test ASAP. If I understood correctly 09:01.2 will be
> disabled, right?
Yes, but here on my system that makes s2ram sometimes hose that
controller (completely, its just dead).

Thats why I made sdhci work with mmc controler as opposed to disabling
it (that what is done in windows).
(Actually Andrew de Quincey found how to do that, I just implemented his
solution:
(http://list.drzeus.cx/pipermail/sdhci-devel/2007-December/002085.html)


http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ccc92c23240cdf952ef7cc39ba563910dcbc9cbe


Best regards,
	Maxim Levitsky

