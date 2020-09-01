Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B3EC433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8D6206EB
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIALrV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgIALqt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2020 07:46:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CD2C061244
        for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2020 04:46:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 062A7296213
Received: by earth.universe (Postfix, from userid 1000)
        id 1DCCB3C0C82; Tue,  1 Sep 2020 13:46:42 +0200 (CEST)
Date:   Tue, 1 Sep 2020 13:46:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-mmc@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Baumgartner, Claus (GE Healthcare)" <claus.baumgartner@med.ge.com>
Subject: Re: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Message-ID: <20200901114642.vhivtsfrarua6ce4@earth.universe>
References: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juz373rbwhruhhy3"
Content-Disposition: inline
In-Reply-To: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--juz373rbwhruhhy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[add i.MX architecture maintainers to Cc]

On Tue, Sep 01, 2020 at 07:37:31AM +0000, Baumgartner, Claus (GE Healthcare=
) wrote:
> We have a board with an i.MX535 using a Samsung eMMC as persistent
> storage connected to eSDHCv3. Every now and then we produce a
> build that causes emmc timeouts:=20
>=20
> Aug 28 07:32:12 csmon kernel: mmc0: Timeout waiting for hardware cmd inte=
rrupt.
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Sys addr:  0xe3f12000 | Versio=
n:  0x00001201
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Blk size:  0x00000200 | Blk cn=
t:  0x00000001
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Argument:  0x00010000 | Trn mo=
de: 0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Present:   0x01f80008 | Host c=
tl: 0x00000031
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Power:     0x00000002 | Blk ga=
p:  0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:=
    0x0000011f
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Timeout:   0x0000008e | Int st=
at: 0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Int enab:  0x107f000b | Sig en=
ab: 0x107f000b
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot i=
nt: 0x00001201
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Caps:      0x07eb0000 | Caps_1=
:   0x08100810
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Cmd:       0x00000d1a | Max cu=
rr: 0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1=
]:  0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3=
]:  0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Host ctl2: 0x00000000
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA P=
tr: 0xef041208
> Aug 28 07:32:12 csmon kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Some extra information: The timeout always has cmd =3D 0x00000d1a
(MMC_SEND_STATUS) and resp[0] =3D 0x00400900 with resp[0] translating
to this IIUIC:

Bit 8 =3D Ready for data
Bit 11 =3D CURRENT_STATE is TRAN
Bit 22 =3D Illegal command

> Timeouts do not occur with every build. After some debugging I
> have found that timeouts seem to depend on code alignment of the
> esdhc_readl_le function. I have bisected the behavior by using the
> System.map and moving/padding the code with NOP instructions (mov
> r0,r0).
>=20
> My test case has 5 processes continuously creating a file, writing
> random long data, reading data and deleting the file. It seems
> that when the esdhc_writel_le is aligned on a certain address then
> the timeout will occur about 5 times/12h using my test case. If I
> add one more NOP, the timeout will not occur at all. If I continue
> adding some more NOPs the timeouts come back. Seems that it
> doesn't matter where in the code I add NOPs as long as the address
> is below the address of esdhc_writel_le.=20
>=20
> We also run the same software on a dual core i.MX6 without any
> timeout issues.

And the same kernel binary is also used on an i.MX6 single core
(albeit with different SW) withot triggering the problem so far.

> I have reproduced this with kernel version 4.19.94 and 5.8.3 and
> we have compiled with both gcc8 and gcc9. I'm still searching for
> the root cause and I would appreciate any thoughts about where to
> go next.=20
>=20
> Thanks,
>=20
> -Claus-

To me it looks like it might involve an unknown hardware errata for
i.MX53, but there has been one similar report before (unfortunately
without the full register dump) involving virtualization:

https://patchwork.kernel.org/patch/10705823/

Note, that Claus' kernel has been built with CONFIG_PREEMPT_NONE=3Dy.

-- Sebastian

--juz373rbwhruhhy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9ONI8ACgkQ2O7X88g7
+pqXPxAAol9/2DT8+tYPvY11oKDyN5ppdW0D3iQmEVZGXvMMCRLfW1tyrvnG5+Ad
QJLi+D8Q3Kr9k2ER2Xn+G/qAwD0mhBVHbHkzLvsAB2CQsqIYnbkFI9guyV08ruuC
v/BTaBbkjsrCn5rfP2JHqZsy6RXfYG2pp0+h1p2j19GYrEdWRgvkgsGgglctWLZP
wt16PFFjTQVMjv0rfap/7+noounLzvYeEi3F8GYvaEQk9dYwz56w1Bhy//mdkCrW
rBW/6aH7sqz9Sj8Ga+EzD9IvtKsKLlZ8rlVlAdq8OHcD5mN3Nos2Z03RiwViI5Re
98mIP23gjqR6g04AygnuP30G/hY4o00otoehIuXIC1N6faaGTKOTi7zfK10g57st
nZeFyNPitsu0Grxty6PRZzy3plYvLcHsiemnmQNGfdL+POZoUx+C4g7Y27pR6Yy6
aVnnOFDECGKjTDBNrXaOC7Z1mIw5oHD922jBaSr9gHHj9GlrK5wHtq/duh26c4cz
FcYVQ4Yj6WbA+WWV59GjeID/SeYlwjHOmG/XaKpc8t1g6YdsP/mfc1OZXWU1EAgs
ix3zMGea4N5cUNRL/naGRac3zxyiohByw7La1DETP313oeZ1rWXlbn09KZ1DxoB1
pBT7Ulf/bT5CZImm8GNRo9zWrqCHKZTLKk2Z0q99J/VtCocNPv0=
=2phV
-----END PGP SIGNATURE-----

--juz373rbwhruhhy3--
