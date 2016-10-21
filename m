From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri, 21 Oct 2016 13:43:05 +0000
Message-ID: <SG2PR06MB1165F5878C8417068E7364628AD40@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161020231245.GB2199@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:15918 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755455AbcJUNnQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 09:43:16 -0400
In-Reply-To: <20161020231245.GB2199@katana>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

> > > * Does it have a version register (CTL_VERSION)? If so, what does it
> > >   say?
> >
> > 0x820B
>=20
> Okay, this is a version I have not seen before.

The SDHI IP came from the SH7269 (SH-2A device).

For the VERSION register, the low byte is the version of the IP, but the up=
per byte is a number that the design group that made the part gives it any =
time they make a change. So, since this IP was from a SH2A team, the number=
ing might look different than what the SH4A or R-Car teams have used in the=
 past.



> This SWAP register exists on R-Car as well. Out of curiosity, what is the
> register value of 0xE804E0E4?

0xE804E0E4 =3D 0x0001

So...something is there!



Chris
