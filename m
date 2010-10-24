From: Luca Tettamanti <kronos.it@gmail.com>
Subject: sdhci_pci: card insertion not detected after s2disk
Date: Sun, 24 Oct 2010 14:36:54 +0200
Message-ID: <20101024123540.GA14424@nb-core2.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574Ab0JXMg5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Oct 2010 08:36:57 -0400
Received: by wyf28 with SMTP id 28so2419059wyf.19
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2010 05:36:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
I noticed that after resuming from s2disk the controller does not
detected when a card is inserted into the slot. The controller seems to
work fine after s2ram. I'm currently running kernel 2.6.36, this is the
hardware:

09:01.1 SD Host controller [0805]: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter [1180:0822] (rev 22)
	Subsystem: ASUSTeK Computer Inc. Device [1043:14e7]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at feaff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: sdhci-pci
00: 80 11 22 08 06 01 10 02 22 00 05 08 08 40 80 00
10: 00 f4 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

09:01.2 System peripheral [0880]: Ricoh Co Ltd R5C843 MMC Host Controller [1180:0843] (rev 12)
	Subsystem: ASUSTeK Computer Inc. Device [1043:14e7]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: sdhci-pci
00: 80 11 43 08 06 01 10 02 12 00 80 08 08 40 80 00
10: 00 f0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

There are changes in the PCI configuration space after resume.

dmesg:

sdhci-pci 0000:09:01.1: SDHCI controller found [1180:0822] (rev 22)
sdhci-pci 0000:09:01.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
sdhci-pci 0000:09:01.1: Will use DMA mode even though HW doesn't fully claim to support it.
Registered led device: mmc0::
mmc0: SDHCI controller on PCI [0000:09:01.1] using DMA
sdhci-pci 0000:09:01.2: SDHCI controller found [1180:0843] (rev 12)
sdhci-pci 0000:09:01.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Registered led device: mmc1::
mmc1: SDHCI controller on PCI [0000:09:01.2] using DMA

Resume says:

[54440.612047] sdhci-pci 0000:09:01.1: BAR 0: set to [mem 0xfeaff400-0xfeaff4ff] (PCI address [0xfeaff400-0xfeaff4ff]
[54440.612094] sdhci-pci 0000:09:01.1: restoring config space at offset 0x3 (was 0x800000, writing 0x804008)
[54440.612110] sdhci-pci 0000:09:01.1: restoring config space at offset 0x1 (was 0x2100000, writing 0x2100106)
[54440.628042] sdhci-pci 0000:09:01.2: BAR 0: set to [mem 0xfeaff000-0xfeaff0ff] (PCI address [0xfeaff000-0xfeaff0ff]
[54440.628089] sdhci-pci 0000:09:01.2: restoring config space at offset 0x3 (was 0x800000, writing 0x804008)
[54440.628104] sdhci-pci 0000:09:01.2: restoring config space at offset 0x1 (was 0x2100000, writing 0x2100106)
[...]
[54440.785245] sdhci-pci 0000:09:01.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[54440.785248] sdhci-pci 0000:09:01.1: Will use DMA mode even though HW doesn't fully claim to support it.
[54440.786263] sdhci-pci 0000:09:01.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17

No errors that I can see. After rmmod sdhci_pci && modprobe sdhci_pci
the controller works fine again.
Should I try adding additional quirks?

Luca
