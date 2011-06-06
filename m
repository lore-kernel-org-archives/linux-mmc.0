From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Mon, 06 Jun 2011 18:52:20 +0200
Message-ID: <4DED05C4.7050903@hartkopp.net>
References: <4DEBCA3F.8050205@hartkopp.net> <BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:8506 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1FFQwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 12:52:22 -0400
In-Reply-To: <BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 06.06.2011 08:13, S, Venkatraman wrote:
> As a E6410 user on Ubuntu, I came across this
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/605043
> 
> But looking at your logs, ADMA is not enabled on your system, so it
> might not be applicable.

No, this is probably not the problem. If so i would have had no success with the 2.6.39 ...

I upgraded to 3.0.0-rc2 and dmsg gives no new insights:

[    6.128616] wmi: Mapper loaded
[    6.131240] sdhci: Secure Digital Host Controller Interface driver
[    6.131388] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
(..)
[    6.136535] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf6970000
[    6.149829] sdhci: Copyright(c) Pierre Ossman
[    6.151030] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
(..)
[    6.176512] hub 2-0:1.0: 3 ports detected
[    6.213037] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
[    6.216810] sdhci-pci 0000:03:00.1: found 1 slot(s)
[    6.216832] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    6.220432] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
[    6.222342] sdhci-pci 0000:03:00.1: PCI INT B disabled
[    6.238102] cfg80211: Calling CRDA to update world regulatory domain

I just enabled debugging and the Ricoh tweak again:

$ diff config-3.0.0-rc1-00180-g0792644 config-3.0.0-rc2
3c3
< # Linux/i386 3.0.0-rc1 Kernel Configuration
---
> # Linux/i386 3.0.0-rc2 Kernel Configuration
2160c2160
< # CONFIG_MMC_DEBUG is not set
---
> CONFIG_MMC_DEBUG=y
2178c2178
< # CONFIG_MMC_RICOH_MMC is not set
---
> CONFIG_MMC_RICOH_MMC=y

Regards,
Oliver


> On Sun, Jun 5, 2011 at 11:56 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Hi all,
>>
>> in 3.0.0-rc1 (and if i remember correctly earlier in the merge window before
>> the tag too) my built-in SD/MMC slot does not work as it did with 2.6.39.
>>
>> Any ideas/patches? Does it help to enable mmc-debugging?
>>
>> Regards,
>> Oliver
>>
>>
>> Linux version 2.6.39
>>
>> Jun  5 13:40:28 mybox kernel: [    6.209758] sdhci: Secure Digital Host Controller Interface driver
>> Jun  5 13:40:28 mybox kernel: [    6.209761] sdhci: Copyright(c) Pierre Ossman
>> (..)
>> Jun  5 13:40:28 mybox kernel: [    6.366993] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
>> Jun  5 13:40:28 mybox kernel: [    6.367017] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>> Jun  5 13:40:28 mybox kernel: [    6.367847] mmc0: SDHCI controller on PCI [0000:03:00.1] using DMA
>>
>>
>> Linux version 3.0.0-rc1-00180-g0792644 (the very latest from Linus' linux-2.6 git tree)
>>
>> Jun  5 13:58:16 mybox kernel: [    6.119533] sdhci: Secure Digital Host Controller Interface driver
>> Jun  5 13:58:16 mybox kernel: [    6.121400] sdhci: Copyright(c) Pierre Ossman
>> (..)
>> Jun  5 13:58:16 mybox kernel: [    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
>> Jun  5 13:58:16 mybox kernel: [    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>> Jun  5 13:58:16 mybox kernel: [    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled
>>
>> dmesg is a bit more detailed:
>> [    6.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [1180:e822] (rev 3)
>> [    6.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
>> [    6.245788] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborting.
>> [    6.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled
>>
>> lspci says:
>>
>> 03:00.0 CardBus bridge: Ricoh Co Ltd Device e476 (rev 02)
>> 03:00.1 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 03)
>> 03:00.4 FireWire (IEEE 1394): Ricoh Co Ltd FireWire Host Controller (rev 03)
>>
>> Used config:
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> CONFIG_MMC_SDHCI=m
>> CONFIG_MMC_SDHCI_PCI=m
>> # CONFIG_MMC_RICOH_MMC is not set <<-- was set in the 2.6.39 mmc config (see below)
>> # CONFIG_MMC_SDHCI_PLTFM is not set
>> # CONFIG_MMC_WBSD is not set
>> # CONFIG_MMC_TIFM_SD is not set
>> # CONFIG_MMC_SDRICOH_CS is not set
>> # CONFIG_MMC_CB710 is not set
>> # CONFIG_MMC_VIA_SDMMC is not set
>> # CONFIG_MMC_VUB300 is not set <<-- the only difference to 2.6.39 mmc config
>> # CONFIG_MMC_USHC is not set
>> # CONFIG_MEMSTICK is not set
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=y
>>
>> Enabling/disabling CONFIG_MMC_RICOH_MMC does not have any effect.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

