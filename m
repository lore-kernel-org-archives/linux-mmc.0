From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 24 Oct 2016 12:37:41 +0000
Message-ID: <SG2PR06MB11652837573C5B7049AD00418AA90@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161020132852.GB4177@katana>
 <SG2PR06MB11652EB5B1A40583636F8FB28AD50@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161020231245.GB2199@katana>
 <SG2PR06MB1165F5878C8417068E7364628AD40@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20161021215639.GB1450@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:29965 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933580AbcJXMhr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 08:37:47 -0400
In-Reply-To: <20161021215639.GB1450@katana>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

> > > This SWAP register exists on R-Car as well. Out of curiosity, what
> > > is the register value of 0xE804E0E4?
> >
> > 0xE804E0E4 =3D 0x0001
> >
> > So...something is there!
>=20
> I am quite convinced there is this BUSWIDTH register. If you are
> interested, try setting this to 0 and see if it works without the 32 bit
> register patches.

Well, it looks like I can't write that register location to 0.
It always keeps a value of 0x0001. So, it must be read-only.

It was a good idea though.
Still, I might try to find out what is there at that location out of curios=
ity.

Without my the 32-bit write patch, I get a lot of these messages:

    sh_mobile_sdhi e804e800.sd: timeout waiting for SD bus idle



Chris

