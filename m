From: =?ISO-8859-1?Q?Ren=E9_K=F6cher?= <shirk@bitspin.org>
Subject: Can't get SDHC in MacBookPro8,2 to work
Date: Sun, 15 May 2011 18:58:13 +0200
Message-ID: <BANLkTimNC17ET689uLg-az2DwjUP5NK29A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61156 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1EOQ6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 12:58:33 -0400
Received: by gxk21 with SMTP id 21so1308853gxk.19
        for <linux-mmc@vger.kernel.org>; Sun, 15 May 2011 09:58:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'm experiencing serious trouble in getting the SDXC Slot working in
my MacBookPro8,2.
The built in controller is a Broadcom NetXtreme with included SD Host
Controller:

02:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme
BCM57765 Gigabit Ethernet PCIe [14e4:16b4] (rev 10)
02:00.1 SD Host controller [0805]: Broadcom Corporation Device
[14e4:16bc] (rev 10)

=46ollowing a few reports (on several forums, including Ubuntu) this
controller should work
out-of-the-box - which unfortunately it doesn't.

I'm running Gentoo Linux 64bit using a 2.6.39-rc6-git4 kernel with a fe=
w patches
applied to fix pure EFI boot on =A0MacBookPros.

Inspecting dmesg I get this info:

[ =A0 53.769305] sdhci: Secure Digital Host Controller Interface driver
[ =A0 53.769307] sdhci: Copyright(c) Pierre Ossman
[ =A0 53.775061] sdhci-pci 0000:02:00.1: SDHCI controller found
[14e4:16bc] (rev 10)
[ =A0 53.775096] sdhci-pci 0000:02:00.1: found 1 slot(s)
[ =A0 53.775109] sdhci-pci 0000:02:00.1: PCI INT B -> GSI 17 (level,
low) -> IRQ 17
[ =A0 53.775111] sdhci-pci 0000:02:00.1: Invalid iomem size. You may
experience problems.
[ =A0 53.775186] sdhci-pci 0000:02:00.1: setting latency timer to 64

The "Invalid iomem size." seems to be a problem (.. i think?..).
If a card is plugged in I get the following messages:

[ .. ] mmc0: Card removed during transfer!
[ .. ] mmc0: Resetting controller.
=2E. a few seconds later
[ .. ] mmc0: Timeout waiting for hardware interrupt.

Compiling with CONFIG_MMC_DEBUG results in (lots) of failed commands:

[ 1617.272622] mmc0: starting CMD5 arg 00000000 flags 000002e1
[ 1627.286136] mmc0: Timeout waiting for hardware interrupt.
[ 1627.286146] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DUMP (=
mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1627.286186] sdhci: Sys addr: 0x00000000 | Version: =A00x00001502
[ 1627.286195] sdhci: Blk size: 0x00000000 | Blk cnt: =A00x00000000
[ 1627.286204] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[ 1627.286212] sdhci: Present: =A00x1eff0001 | Host ctl: 0x00000001
[ 1627.286229] sdhci: Power: =A0 =A00x0000000f | Blk gap: =A00x00000000
[ 1627.286234] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x0000fa07
[ 1627.286238] sdhci: Timeout: =A00x00000000 | Int stat: 0x00000000
[ 1627.286243] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00ff00c3
[ 1627.286249] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[ 1627.286253] sdhci: Caps: =A0 =A0 0x176ec8b0 | Caps_1: =A0 0x03002177
[ 1627.286258] sdhci: Cmd: =A0 =A0 =A00x00000502 | Max curr: 0x00000000
[ 1627.286264] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[ 1627.286265] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[ 1627.288335] mmc0: req failed (CMD5): -110, retrying...

Commands range from CMD5,8,52 up to 55.

The SDHC I'm using is working fine in MacOS and in Win7 so it doesn't s=
eem to
be some card related issue.

Please be kind as this is my first post to the kernel lists.
Any help is more than welcome.

--
Cheers,
Rene'
