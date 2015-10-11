From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Write errors on Cherrytrail eMMC
Date: Sun, 11 Oct 2015 19:45:10 +0200
Message-ID: <1444585510.28661.68.camel@hadess.net>
References: <1444436356.28661.47.camel@hadess.net>
	 <56186468.80805@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:52650 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbJKRyG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2015 13:54:06 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 85B7453538D
	for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2015 19:45:16 +0200 (CEST)
In-Reply-To: <56186468.80805@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org

On Sat, 2015-10-10 at 09:05 +0800, Shawn Lin wrote:
>=20
<snip>
> No, sdhci finally complete the tansfer. So, you can try to augment
> the=20
> timeout [here, mod_timer(&host->timer, timeout)] to see how the
> things=20
> going.

I applied this patch to get some more debug, and increase the default
timeout. I'm not certain this was actually used for all the codepaths,
but I certainly saw that it was getting applied at least in some cases.

What would those errors be this time?

Cheers

Oct 11 12:12:53 localhost kernel: mmc0: starting CMD25 arg 06ec2808 fla=
gs 000000b5
Oct 11 12:12:53 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bl=
ksz 512 blocks 1024 flags 00000100 tsac 1200 ms nsac 8000
Oct 11 12:12:53 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CM=
D12 arg 00000000 flags 0000049d
Oct 11 12:12:53 localhost kernel: mmc0: SDHCI controller on ACPI[80860F=
14:00], timeout is 10000, increasing to 100000=20
Oct 11 12:12:53 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 11 12:14:33 localhost kernel: mmc0: Timeout waiting for hardware in=
terrupt.
Oct 11 12:14:33 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oct 11 12:14:33 localhost kernel: sdhci: Sys addr: 0x00000400 | Version=
:=C2=A0=C2=A00x00001002
Oct 11 12:14:33 localhost kernel: sdhci: Blk size: 0x00007200 | Blk cnt=
:=C2=A0=C2=A00x000003f8
Oct 11 12:14:33 localhost kernel: sdhci: Argument: 0x06ec2808 | Trn mod=
e: 0x0000002b
Oct 11 12:14:33 localhost kernel: sdhci: Present:=C2=A0=C2=A00x1fff0106=
 | Host ctl: 0x00000035
Oct 11 12:14:33 localhost kernel: sdhci: Power:=C2=A0=C2=A0=C2=A0=C2=A0=
0x0000000b | Blk gap:=C2=A0=C2=A00x00000080
Oct 11 12:14:33 localhost kernel: sdhci: Wake-up:=C2=A0=C2=A00x00000000=
 | Clock:=C2=A0=C2=A0=C2=A0=C2=A00x00000007
Oct 11 12:14:33 localhost kernel: sdhci: Timeout:=C2=A0=C2=A00x00000008=
 | Int stat: 0x00000000
Oct 11 12:14:33 localhost kernel: sdhci: Int enab: 0x02ff000b | Sig ena=
b: 0x02ff000b
Oct 11 12:14:33 localhost kernel: sdhci: AC12 err: 0x00000000 | Slot in=
t: 0x00000000
Oct 11 12:14:33 localhost kernel: sdhci: Caps:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x446cc8b2 | Caps_1:=C2=A0=C2=A0=C2=A00x00000007
Oct 11 12:14:33 localhost kernel: sdhci: Cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00x0000193a | Max curr: 0x00000000
Oct 11 12:14:33 localhost kernel: sdhci: Host ctl2: 0x0000008b
Oct 11 12:14:33 localhost kernel: sdhci: ADMA Err: 0x00000000 | ADMA Pt=
r: 0x3fa28008
Oct 11 12:14:33 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[80860F=
14:00], timeout is 10000, increasing to 100000=20
Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000003
Oct 11 12:14:33 localhost kernel: mmc0: req done <CMD23>: 0: 00000000 0=
0000000 00000000 00000000
Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD25): 0: 00000900 0=
0000000 00000000 00000000
Oct 11 12:14:33 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 =
bytes transferred: -110
Oct 11 12:14:33 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(C=
MD12): 0: 00000d00 00000000 00000000 00000000
Oct 11 12:14:33 localhost kernel: mmc0: starting CMD13 arg 00010000 fla=
gs 00000195
Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[80860F=
14:00], timeout is 10000, increasing to 100000=20
Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD13): 0: 00000900 0=
0000000 00000000 00000000
Oct 11 12:14:33 localhost kernel: mmc0: starting CMD13 arg 00010000 fla=
gs 00000195
Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[80860F=
14:00], timeout is 10000, increasing to 100000=20
Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD13): 0: 00000900 0=
0000000 00000000 00000000
Oct 11 12:14:33 localhost kernel: mmcblk0: error -110 transferring data=
, sector 116140040, nr 1024, cmd response 0x900, card status 0xd00
Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 116140040
Oct 11 12:14:33 localhost kernel: Buffer I/O error on dev mmcblk0p6, lo=
gical block 2676993, lost async page write
Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 116140048
Oct 11 12:14:33 localhost kernel: Buffer I/O error on dev mmcblk0p6, lo=
gical block 2676994, lost async page write
Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 116140056
