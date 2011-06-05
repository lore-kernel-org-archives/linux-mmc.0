From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Sun, 05 Jun 2011 20:26:07 +0200
Message-ID: <4DEBCA3F.8050205@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30593 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab1FES0H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2011 14:26:07 -0400
Received: from [192.168.178.39] (p5B0B1761.dip0.t-ipconnect.de [91.11.23.97])
	by post.strato.de (cohen mo4) (RZmta 25.18)
	with ESMTPA id h013d6n55HQuhC for <linux-mmc@vger.kernel.org>;
	Sun, 5 Jun 2011 20:26:04 +0200 (MEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

in 3.0.0-rc1 (and if i remember correctly earlier in the merge window before
the tag too) my built-in SD/MMC slot does not work as it did with 2.6.39.

Any ideas/patches? Does it help to enable mmc-debugging?

Regards,
Oliver


Linux version 2.6.39

Jun  5 13:40:28 mybox kernel: [    6.209758] sdhci: Secure Digital Host Controller Interface driver
Jun  5 13:40:28 mybox kernel: [    6.209761] sdhci: Copyright(c) Pierre Ossman
(..)
Jun  5 13:40:28 mybox kernel: [    6.366993] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
Jun  5 13:40:28 mybox kernel: [    6.367017] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jun  5 13:40:28 mybox kernel: [    6.367847] mmc0: SDHCI controller on PCI [0000:03:00.1] using DMA


Linux version 3.0.0-rc1-00180-g0792644 (the very latest from Linus' linux-2.6 git tree) 

Jun  5 13:58:16 mybox kernel: [    6.119533] sdhci: Secure Digital Host Controller Interface driver
Jun  5 13:58:16 mybox kernel: [    6.121400] sdhci: Copyright(c) Pierre Ossman
(..)
Jun  5 13:58:16 mybox kernel: [    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
Jun  5 13:58:16 mybox kernel: [    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
Jun  5 13:58:16 mybox kernel: [    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled

dmesg is a bit more detailed:
[    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
[    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    6.245788] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
[    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled

lspci says:

03:00.0 CardBus bridge: Ricoh Co Ltd Device e476 (rev 02)
03:00.1 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 03)
03:00.4 FireWire (IEEE 1394): Ricoh Co Ltd FireWire Host Controller (rev 03)

Used config:

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set <<-- was set in the 2.6.39 mmc config (see below)
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set <<-- the only difference to 2.6.39 mmc config
# CONFIG_MMC_USHC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

Enabling/disabling CONFIG_MMC_RICOH_MMC does not have any effect.

