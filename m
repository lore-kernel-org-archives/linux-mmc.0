From: Bastien Nocera <hadess@hadess.net>
Subject: Write errors on Cherrytrail eMMC
Date: Sat, 10 Oct 2015 02:19:16 +0200
Message-ID: <1444436356.28661.47.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60404 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbJJATV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 20:19:21 -0400
Received: from mfilter38-d.gandi.net (mfilter38-d.gandi.net [217.70.178.169])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id CEC66A80AC
	for <linux-mmc@vger.kernel.org>; Sat, 10 Oct 2015 02:19:19 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter38-d.gandi.net (mfilter38-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id bBhIabB8yOLr for <linux-mmc@vger.kernel.org>;
	Sat, 10 Oct 2015 02:19:18 +0200 (CEST)
Received: from coal (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D3FCEA80AD
	for <linux-mmc@vger.kernel.org>; Sat, 10 Oct 2015 02:19:17 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Heya,

On a Cherrytrail device (the MS Surface 3), trying to install to the
internal eMMC, I get write errors with the controller timing out.

I'm using a self built 4.3.0-0.rc4.git3.2.fc24.x86_64.

Any ideas?

Cheers

Oct 09 18:09:24 localhost kernel: mmc0: starting CMD25 arg 05ba4800 fla=
gs 000000b5
Oct 09 18:09:24 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bl=
ksz 512 blocks 1024 flags 00000100 tsac 1200 ms nsac 8000
Oct 09 18:09:24 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CM=
D12 arg 00000000 flags 0000049d
Oct 09 18:09:24 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 09 18:09:34 localhost kernel: mmc0: Timeout waiting for hardware in=
terrupt.
Oct 09 18:09:34 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D REGISTER DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oct 09 18:09:34 localhost kernel: sdhci: Sys addr: 0x00000400 | Version=
:=C2=A0=C2=A00x00001002
Oct 09 18:09:34 localhost kernel: sdhci: Blk size: 0x00007200 | Blk cnt=
:=C2=A0=C2=A00x00000203
Oct 09 18:09:34 localhost kernel: sdhci: Argument: 0x05ba4800 | Trn mod=
e: 0x0000002b
Oct 09 18:09:34 localhost kernel: sdhci: Present:=C2=A0=C2=A00x1fff0106=
 | Host ctl: 0x00000035
Oct 09 18:09:34 localhost kernel: sdhci: Power:=C2=A0=C2=A0=C2=A0=C2=A0=
0x0000000b | Blk gap:=C2=A0=C2=A00x00000080
Oct 09 18:09:34 localhost kernel: sdhci: Wake-up:=C2=A0=C2=A00x00000000=
 | Clock:=C2=A0=C2=A0=C2=A0=C2=A00x00000007
Oct 09 18:09:34 localhost kernel: sdhci: Timeout:=C2=A0=C2=A00x00000008=
 | Int stat: 0x00000000
Oct 09 18:09:34 localhost kernel: sdhci: Int enab: 0x02ff000b | Sig ena=
b: 0x02ff000b
Oct 09 18:09:34 localhost kernel: sdhci: AC12 err: 0x00000000 | Slot in=
t: 0x00000000
Oct 09 18:09:34 localhost kernel: sdhci: Caps:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x446cc8b2 | Caps_1:=C2=A0=C2=A0=C2=A00x00000007
Oct 09 18:09:34 localhost kernel: sdhci: Cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00x0000193a | Max curr: 0x00000000
Oct 09 18:09:34 localhost kernel: sdhci: Host ctl2: 0x0000008b
Oct 09 18:09:34 localhost kernel: sdhci: ADMA Err: 0x00000000 | ADMA Pt=
r: 0x3fbf90e0
Oct 09 18:09:34 localhost kernel: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000002
Oct 09 18:09:34 localhost kernel: mmc0: req done <CMD23>: 0: 00000000 0=
0000000 00000000 00000000
Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD25): 0: 00000900 0=
0000000 00000000 00000000
Oct 09 18:09:34 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 =
bytes transferred: -110
Oct 09 18:09:34 localhost kernel: mmc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(C=
MD12): 0: 00000d00 00000000 00000000 00000000
Oct 09 18:09:34 localhost kernel: mmc0: starting CMD13 arg 00010000 fla=
gs 00000195
Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD13): 0: 00000900 0=
0000000 00000000 00000000
Oct 09 18:09:34 localhost kernel: mmc0: starting CMD13 arg 00010000 fla=
gs 00000195
Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got int=
errupt: 0x00000001
Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD13): 0: 00000900 0=
0000000 00000000 00000000
Oct 09 18:09:34 localhost kernel: mmcblk0: error -110 transferring data=
, sector 96094208, nr 1024, cmd response 0x900, card status 0xd00
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094208
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094216
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094224
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094232
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094240
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094248
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094256
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094264
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094272
Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mm=
cblk0, sector 96094280
