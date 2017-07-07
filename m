From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Fri, 7 Jul 2017 01:20:39 +0000
Message-ID: <TY1PR06MB099216EB21FBD00BB0554119D8AA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
 <TY1PR06MB0992844258B8EE4C70C403D2D8D40@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <20170706063843.GC1418@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:40289 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753126AbdGGBUo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jul 2017 21:20:44 -0400
In-Reply-To: <20170706063843.GC1418@katana>
Content-Language: ja-JP
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, =?iso-8859-1?Q?Jan_Kl=F6tzke?= <jan.kloetzke@technisat.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, KOUEI ABE <kouei.abe.cp@renesas.com>, DUNG NGUYEN <dung.nguyen.aj@renesas.com>

Hi Wolfram-san,

> -----Original Message-----
> From: Wolfram Sang
> Sent: Thursday, July 6, 2017 3:39 PM
>=20
> > I and Dung-san are testing this patch.
> > However, this original code doesn't run by our test cases.
> > Do you know how this original code runs?
> > Anyway, we will try to make a test case somehow now.
>=20
> Thank you very much, Shimoda-san. I got it tested because a card needed
> re-tuning during a transfer.
>=20
> It might work if you manually induce an error bit in the driver
> somewhere. I'll try to find a good sport later, too. However, I am away
> from my boards today and tomorrow.

We tested this patch on H3 Salvator-X.
If we add debug code in this driver (e.g. 400th mmc request assumes an erro=
r),
this original code ran and the following message output:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  258.245349] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[  258.259245]  mmcblk1: p1
[  268.513997] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting=20
for hardware interrupt (CMD12)
[  273.633998] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting=20
for hardware interrupt (CMD12)
[  278.754000] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting=20
for hardware interrupt (CMD12)
[  283.873995] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting=20
for hardware interrupt (CMD12)
[  288.994000] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting=20
for hardware interrupt (CMD12)
[  289.042012] mmcblk1: error -110 sending stop command
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

And then, after we applied this patch, no regression happens and the follow=
ing
message output:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [   66.433902] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[   66.449161]  mmcblk1: p1
[   66.505322] mmcblk1: error -110 sending stop command
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So,

Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>

Best regards,
Yoshihiro Shimoda

