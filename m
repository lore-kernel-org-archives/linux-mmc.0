From: =?ISO-8859-1?Q?Ren=E9_K=F6cher?= <shirk@bitspin.org>
Subject: Support for NetXtreme BCM57765 Memory Card Reader?
Date: Sat, 11 Jun 2011 13:15:05 +0200
Message-ID: <1307790907.3615.8.camel@horo.kamakura>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab1FKJPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 05:15:10 -0400
Received: by fxm17 with SMTP id 17so1983016fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 11 Jun 2011 02:15:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

The card reader mentioned in the subject is part of the Broadcom
NetXtreme BCM57765 chip which provides a card reader as well as a
network interface[=C2=B9].

It is recognized by the sdhci-pci driver however it won't read any card
(tested with different SD, SDHC, SDXC cards).

I'm not sure if it is recognized by its advertised features or if it's
really supported (unlikely).

lspci -v / lspci -vn
> (02:00.0 0200: 14e4:16b4 (rev 10))
> (        Subsystem: 14e4:16b4)
>=20
> 02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57765 =
Gigabit Ethernet PCIe (rev 10)
>         Subsystem: Broadcom Corporation NetXtreme BCM57765 Gigabit Et=
hernet PCIe
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at b0400000 (64-bit, prefetchable) [size=3D64K]
>         Memory at b0410000 (64-bit, prefetchable) [size=3D64K]
>         Capabilities: [48] Power Management version 3
>         Capabilities: [58] MSI: Enable- Count=3D1/8 Maskable- 64bit+
>         Capabilities: [a0] MSI-X: Enable- Count=3D6 Masked-
>         Capabilities: [ac] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [13c] Device Serial Number XX-XX-XX-XX-XX-XX-XX=
-XX
>         Capabilities: [150] Power Budgeting <?>
>         Capabilities: [160] Virtual Channel
>         Kernel driver in use: tg3

> (02:00.1 0805: 14e4:16bc (rev 10) (prog-if 01))
> (        Subsystem: 14e4:0000)
>=20
> 02:00.1 SD Host controller: Broadcom Corporation Device 16bc (rev 10)=
 (prog-if 01)
>         Subsystem: Broadcom Corporation Device 0000
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Memory at b0420000 (64-bit, prefetchable) [size=3D64K]
>         Capabilities: [48] Power Management version 3
>         Capabilities: [58] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [ac] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [150] Power Budgeting <?>
>         Capabilities: [160] Virtual Channel
>         Kernel driver in use: sdhci-pci
>         Kernel modules: sdhci-pci

[=C2=B9] http://www.broadcom.com/products/Ethernet-Controllers/Enterpri=
se-Client/BCM57765

Cheers,


