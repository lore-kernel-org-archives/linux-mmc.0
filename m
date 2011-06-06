From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: sdhci-pci fails on 3.0.0-rc1 on Dell E6510
Date: Mon, 6 Jun 2011 11:43:25 +0530
Message-ID: <BANLkTin_WHuy5MExNBHdeLiDmdmn7SZYkg@mail.gmail.com>
References: <4DEBCA3F.8050205@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44056 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703Ab1FFGN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Jun 2011 02:13:26 -0400
Received: by mail-pw0-f50.google.com with SMTP id 3so1925740pwi.9
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2011 23:13:25 -0700 (PDT)
In-Reply-To: <4DEBCA3F.8050205@hartkopp.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

As a E6410 user on Ubuntu, I came across this
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/605043

But looking at your logs, ADMA is not enabled on your system, so it
might not be applicable.

Best regards,
Venkat.

On Sun, Jun 5, 2011 at 11:56 PM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> Hi all,
>
> in 3.0.0-rc1 (and if i remember correctly earlier in the merge window=
 before
> the tag too) my built-in SD/MMC slot does not work as it did with 2.6=
=2E39.
>
> Any ideas/patches? Does it help to enable mmc-debugging?
>
> Regards,
> Oliver
>
>
> Linux version 2.6.39
>
> Jun =A05 13:40:28 mybox kernel: [ =A0 =A06.209758] sdhci: Secure Digi=
tal Host Controller Interface driver
> Jun =A05 13:40:28 mybox kernel: [ =A0 =A06.209761] sdhci: Copyright(c=
) Pierre Ossman
> (..)
> Jun =A05 13:40:28 mybox kernel: [ =A0 =A06.366993] sdhci-pci 0000:03:=
00.1: SDHCI controller found [1180:e822] (rev 3)
> Jun =A05 13:40:28 mybox kernel: [ =A0 =A06.367017] sdhci-pci 0000:03:=
00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> Jun =A05 13:40:28 mybox kernel: [ =A0 =A06.367847] mmc0: SDHCI contro=
ller on PCI [0000:03:00.1] using DMA
>
>
> Linux version 3.0.0-rc1-00180-g0792644 (the very latest from Linus' l=
inux-2.6 git tree)
>
> Jun =A05 13:58:16 mybox kernel: [ =A0 =A06.119533] sdhci: Secure Digi=
tal Host Controller Interface driver
> Jun =A05 13:58:16 mybox kernel: [ =A0 =A06.121400] sdhci: Copyright(c=
) Pierre Ossman
> (..)
> Jun =A05 13:58:16 mybox kernel: [ =A0 =A06.242510] sdhci-pci 0000:03:=
00.1: SDHCI controller found [1180:e822] (rev 3)
> Jun =A05 13:58:16 mybox kernel: [ =A0 =A06.244168] sdhci-pci 0000:03:=
00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> Jun =A05 13:58:16 mybox kernel: [ =A0 =A06.247609] sdhci-pci 0000:03:=
00.1: PCI INT B disabled
>
> dmesg is a bit more detailed:
> [ =A0 =A06.242510] sdhci-pci 0000:03:00.1: SDHCI controller found [11=
80:e822] (rev 3)
> [ =A0 =A06.244168] sdhci-pci 0000:03:00.1: PCI INT B -> GSI 19 (level=
, low) -> IRQ 19
> [ =A0 =A06.245788] sdhci-pci 0000:03:00.1: BAR 0 is not iomem. Aborti=
ng.
> [ =A0 =A06.247609] sdhci-pci 0000:03:00.1: PCI INT B disabled
>
> lspci says:
>
> 03:00.0 CardBus bridge: Ricoh Co Ltd Device e476 (rev 02)
> 03:00.1 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev =
03)
> 03:00.4 FireWire (IEEE 1394): Ricoh Co Ltd FireWire Host Controller (=
rev 03)
>
> Used config:
>
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_PCI=3Dm
> # CONFIG_MMC_RICOH_MMC is not set <<-- was set in the 2.6.39 mmc conf=
ig (see below)
> # CONFIG_MMC_SDHCI_PLTFM is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SDRICOH_CS is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set <<-- the only difference to 2.6.39 mmc=
 config
> # CONFIG_MMC_USHC is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
>
> Enabling/disabling CONFIG_MMC_RICOH_MMC does not have any effect.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
