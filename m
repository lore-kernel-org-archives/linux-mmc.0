From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Write errors on Cherrytrail eMMC
Date: Fri, 16 Oct 2015 12:08:15 +0200
Message-ID: <1444990095.4432.9.camel@hadess.net>
References: <1444436356.28661.47.camel@hadess.net>
	 <56186468.80805@rock-chips.com> <1444585510.28661.68.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:55042 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbbJPKIt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 06:08:49 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 58AA247ECEE
	for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 12:08:24 +0200 (CEST)
In-Reply-To: <1444585510.28661.68.camel@hadess.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>

On Sun, 2015-10-11 at 19:45 +0200, Bastien Nocera wrote:
> On Sat, 2015-10-10 at 09:05 +0800, Shawn Lin wrote:
> >=20
> <snip>
> > No, sdhci finally complete the tansfer. So, you can try to augment
> > the=20
> > timeout [here, mod_timer(&host->timer, timeout)] to see how the
> > things=20
> > going.
>=20
> I applied this patch to get some more debug, and increase the default
> timeout. I'm not certain this was actually used for all the
> codepaths,
> but I certainly saw that it was getting applied at least in some
> cases.
>=20
> What would those errors be this time?

Looks like one of:
commit 66c39dfc92f9d35ed9f713833156547842086891
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:=C2=A0=C2=A0=C2=A0Thu May 7 13:10:21 2015 +0300

=C2=A0=C2=A0=C2=A0=C2=A0mmc: sdhci: Change to new way of doing re-tunin=
g
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0Make use of mmc core support for re-tuning inst=
ead
=C2=A0=C2=A0=C2=A0=C2=A0of doing it all in the sdhci driver.
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0This patch also changes to flag the need for re=
-tuning
=C2=A0=C2=A0=C2=A0=C2=A0always after runtime suspend when tuning has be=
en used
=C2=A0=C2=A0=C2=A0=C2=A0at initialization. Previously it was only done =
if
=C2=A0=C2=A0=C2=A0=C2=A0the re-tuning timer was in use.
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Adrian Hunter <adrian.hunter@int=
el.com>
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Ulf Hansson <ulf.hansson@linaro.=
org>

commit b69587e2d5b09a192c45c604ea1f9e8d51f4c3a1
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:=C2=A0=C2=A0=C2=A0Fri Feb 6 14:13:01 2015 +0200

=C2=A0=C2=A0=C2=A0=C2=A0mmc: sdhci-pci: Enable HS400 for some Intel hos=
t controllers
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0Enable detection of HS400 support via capabilit=
y bit-63
=C2=A0=C2=A0=C2=A0=C2=A0for some Intel host controllers.
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Adrian Hunter <adrian.hunter@int=
el.com>
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Ulf Hansson <ulf.hansson@linaro.=
org>

is responsible for the errors seen on this device. Reverting those 2
allowed me to perform the installation without the controller timing
out.

I'll try to pinpoint which one of the two is responsible for the
timeout errors on this Surface 3.

Cheers

> Cheers
>=20
> Oct 11 12:12:53 localhost kernel: mmc0: starting CMD25 arg 06ec2808 f=
lags 000000b5
> Oct 11 12:12:53 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
blksz 512 blocks 1024 flags 00000100 tsac 1200 ms nsac 8000
> Oct 11 12:12:53 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
CMD12 arg 00000000 flags 0000049d
> Oct 11 12:12:53 localhost kernel: mmc0: SDHCI controller on ACPI[8086=
0F14:00], timeout is 10000, increasing to 100000=20
> Oct 11 12:12:53 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got i=
nterrupt: 0x00000001
> Oct 11 12:14:33 localhost kernel: mmc0: Timeout waiting for hardware =
interrupt.
> Oct 11 12:14:33 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Oct 11 12:14:33 localhost kernel: sdhci: Sys addr: 0x00000400 | Versi=
on:=C2=A0=C2=A00x00001002
> Oct 11 12:14:33 localhost kernel: sdhci: Blk size: 0x00007200 | Blk c=
nt:=C2=A0=C2=A00x000003f8
> Oct 11 12:14:33 localhost kernel: sdhci: Argument: 0x06ec2808 | Trn m=
ode: 0x0000002b
> Oct 11 12:14:33 localhost kernel: sdhci: Present:=C2=A0=C2=A00x1fff01=
06 | Host ctl: 0x00000035
> Oct 11 12:14:33 localhost kernel: sdhci: Power:=C2=A0=C2=A0=C2=A0=C2=A0=
0x0000000b | Blk gap:=C2=A0=C2=A00x00000080
> Oct 11 12:14:33 localhost kernel: sdhci: Wake-up:=C2=A0=C2=A00x000000=
00 | Clock:=C2=A0=C2=A0=C2=A0=C2=A00x00000007
> Oct 11 12:14:33 localhost kernel: sdhci: Timeout:=C2=A0=C2=A00x000000=
08 | Int stat: 0x00000000
> Oct 11 12:14:33 localhost kernel: sdhci: Int enab: 0x02ff000b | Sig e=
nab: 0x02ff000b
> Oct 11 12:14:33 localhost kernel: sdhci: AC12 err: 0x00000000 | Slot =
int: 0x00000000
> Oct 11 12:14:33 localhost kernel: sdhci: Caps:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00x446cc8b2 | Caps_1:=C2=A0=C2=A0=C2=A00x00000007
> Oct 11 12:14:33 localhost kernel: sdhci: Cmd:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00x0000193a | Max curr: 0x00000000
> Oct 11 12:14:33 localhost kernel: sdhci: Host ctl2: 0x0000008b
> Oct 11 12:14:33 localhost kernel: sdhci: ADMA Err: 0x00000000 | ADMA =
Ptr: 0x3fa28008
> Oct 11 12:14:33 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[8086=
0F14:00], timeout is 10000, increasing to 100000=20
> Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got i=
nterrupt: 0x00000003
> Oct 11 12:14:33 localhost kernel: mmc0: req done : 0: 00000000 000000=
00 00000000 00000000
> Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD25): 0: 00000900=
 00000000 00000000 00000000
> Oct 11 12:14:33 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
0 bytes transferred: -110
> Oct 11 12:14:33 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
(CMD12): 0: 00000d00 00000000 00000000 00000000
> Oct 11 12:14:33 localhost kernel: mmc0: starting CMD13 arg 00010000 f=
lags 00000195
> Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[8086=
0F14:00], timeout is 10000, increasing to 100000=20
> Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got i=
nterrupt: 0x00000001
> Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD13): 0: 00000900=
 00000000 00000000 00000000
> Oct 11 12:14:33 localhost kernel: mmc0: starting CMD13 arg 00010000 f=
lags 00000195
> Oct 11 12:14:33 localhost kernel: mmc0: SDHCI controller on ACPI[8086=
0F14:00], timeout is 10000, increasing to 100000=20
> Oct 11 12:14:33 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got i=
nterrupt: 0x00000001
> Oct 11 12:14:33 localhost kernel: mmc0: req done (CMD13): 0: 00000900=
 00000000 00000000 00000000
> Oct 11 12:14:33 localhost kernel: mmcblk0: error -110 transferring da=
ta, sector 116140040, nr 1024, cmd response 0x900, card status 0xd00
> Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev =
mmcblk0, sector 116140040
> Oct 11 12:14:33 localhost kernel: Buffer I/O error on dev mmcblk0p6, =
logical block 2676993, lost async page write
> Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev =
mmcblk0, sector 116140048
> Oct 11 12:14:33 localhost kernel: Buffer I/O error on dev mmcblk0p6, =
logical block 2676994, lost async page write
> Oct 11 12:14:33 localhost kernel: blk_update_request: I/O error, dev =
mmcblk0, sector 116140056
