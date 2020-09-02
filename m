Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C6C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC35520767
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBNt1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:49:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40332 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgIBNtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 09:49:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 52A242753CB
Received: by earth.universe (Postfix, from userid 1000)
        id A7A3D3C0C82; Wed,  2 Sep 2020 15:49:06 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:49:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Baumgartner, Claus (GE Healthcare)" <claus.baumgartner@med.ge.com>
Subject: Re: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
Message-ID: <20200902134906.uqyoejyv4atljm46@earth.universe>
References: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
 <20200901114642.vhivtsfrarua6ce4@earth.universe>
 <VI1PR04MB5294C1AE26EA2D0DA163F307902F0@VI1PR04MB5294.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ze2yl4s4ujqonoqc"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5294C1AE26EA2D0DA163F307902F0@VI1PR04MB5294.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ze2yl4s4ujqonoqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 02, 2020 at 11:24:52AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Sebastian Reichel [mailto:sebastian.reichel@collabora.com]
> > Sent: 2020=E5=B9=B49=E6=9C=881=E6=97=A5 19:47
> > To: dl-linux-imx <linux-imx@nxp.com>
> > Cc: linux-mmc@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>; Shawn
> > Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Baumgartner, Claus (GE Healthcare)
> > <claus.baumgartner@med.ge.com>
> > Subject: Re: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
> >=20
> > Hi,
> >=20
> > [add i.MX architecture maintainers to Cc]
> >=20
> > On Tue, Sep 01, 2020 at 07:37:31AM +0000, Baumgartner, Claus (GE
> > Healthcare) wrote:
> > > We have a board with an i.MX535 using a Samsung eMMC as persistent
> > > storage connected to eSDHCv3. Every now and then we produce a build
> > > that causes emmc timeouts:
> > >
> > > Aug 28 07:32:12 csmon kernel: mmc0: Timeout waiting for hardware cmd
> > interrupt.
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
> > > DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Aug 28 07:32:12 csmon kernel: =
mmc0: sdhci: Sys addr:
> > > 0xe3f12000 | Version:  0x00001201 Aug 28 07:32:12 csmon kernel: mmc0:
> > > sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001 Aug 28 07:32:12 c=
smon
> > kernel: mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Present:   0x01f80008 | Ho=
st
> > ctl: 0x00000031
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Power:     0x00000002 | Blk
> > gap:  0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Wake-up:   0x00000000 |
> > Clock:    0x0000011f
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Timeout:   0x0000008e | Int
> > stat: 0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Int enab:  0x107f000b | Sig
> > > enab: 0x107f000b Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ACmd stat:
> > 0x00000000 | Slot int: 0x00001201
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Caps:      0x07eb0000 |
> > Caps_1:   0x08100810
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Cmd:       0x00000d1a |
> > Max curr: 0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[0]:   0x00400900 |
> > Resp[1]:  0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[2]:   0x00000000 |
> > Resp[3]:  0x00000000
> > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Host ctl2: 0x00000000 Aug
> > > 28 07:32:12 csmon kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA
> > > Ptr: 0xef041208 Aug 28 07:32:12 csmon kernel: mmc0: sdhci:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Some extra information: The timeout always has cmd =3D 0x00000d1a
> > (MMC_SEND_STATUS) and resp[0] =3D 0x00400900 with resp[0] translating to
> > this IIUIC:
> >=20
> > Bit 8 =3D Ready for data
> > Bit 11 =3D CURRENT_STATE is TRAN
> > Bit 22 =3D Illegal command
>=20
> According to the code logic, since this cmd13 get hardware cmd
> timeout, which means this cmd13 do not get any response. Here
> the Resp[0] should be the previous command's response.
>
> So this means the previous command is an illegal command, cause
> the emmc internal firmware stuck, and can't response to the next
> cmd13.
>
> I think we need to firstly identify the specific place in
> emmc driver which trigger the log dump.

My understanding is, that a missing response from the eMMC should trigger
the Command Timeout Error Status IRQ in eSDHC after 64 SDCLK cycles
(see section 30.7.10 [ESDHCV3x_IRQSTAT] in the i.MX53 reference manual).
64 SDCLK cycles means, that this should recover quickly and would not be
a problem for most usecases.

But what we are seeing is the software 10 seconds timeout. My understanding
is, that this should not be triggered if the SDHCI controller works as expe=
cted
(e.g. by generating a IRQ for the timeout). This timeout is much more
problematic, since all eMMC accessing processes block for those 10 seconds.

-- Sebastian

> Best Regards
> Haibo Chen
>=20
> >=20
> > > Timeouts do not occur with every build. After some debugging I have
> > > found that timeouts seem to depend on code alignment of the
> > > esdhc_readl_le function. I have bisected the behavior by using the
> > > System.map and moving/padding the code with NOP instructions (mov
> > > r0,r0).
> > >
> > > My test case has 5 processes continuously creating a file, writing
> > > random long data, reading data and deleting the file. It seems that
> > > when the esdhc_writel_le is aligned on a certain address then the
> > > timeout will occur about 5 times/12h using my test case. If I add one
> > > more NOP, the timeout will not occur at all. If I continue adding some
> > > more NOPs the timeouts come back. Seems that it doesn't matter where
> > > in the code I add NOPs as long as the address is below the address of
> > > esdhc_writel_le.
> > >
> > > We also run the same software on a dual core i.MX6 without any timeout
> > > issues.
> >=20
> > And the same kernel binary is also used on an i.MX6 single core (albeit=
 with
> > different SW) withot triggering the problem so far.
> >=20
> > > I have reproduced this with kernel version 4.19.94 and 5.8.3 and we
> > > have compiled with both gcc8 and gcc9. I'm still searching for the
> > > root cause and I would appreciate any thoughts about where to go next.
> > >
> > > Thanks,
> > >
> > > -Claus-
> >=20
> > To me it looks like it might involve an unknown hardware errata for i.M=
X53, but
> > there has been one similar report before (unfortunately without the full
> > register dump) involving virtualization:
> >=20
> > https://patchwork.kernel.org/patch/10705823/
> >=20
> > Note, that Claus' kernel has been built with CONFIG_PREEMPT_NONE=3Dy.
> >=20
> > -- Sebastian

--ze2yl4s4ujqonoqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9PoroACgkQ2O7X88g7
+pqX6BAAjeDUfqwwuWIksopqGcqnEtHrhJaQTxrDTD3WCaSwo/eiJRzgAV522XsK
BmPng4ISHfXg4QbOdUOcp0glDpybqjFrVpPsJlNciI7Jme4nZd4cHjDAvccqrjbr
PLVzvMbfLBM1fv1Zp4Ltu4I2FPctI1ugDIGgDeWnap+DImdSm7mjjNlzxmk+65LI
4O5K+BXN2amwmIPvGNkXfY6LtK5ZowabPyHg0FDD5ci1NYfZVCraS27WG3UG2Rpg
c8QtQ1PhVX7NPYcC5JwVPy9qZtg2AgvxeuP5SN/s5759OgzoGGUW/RaTMn8fDFQe
nCYbxv0PZzkBHU8soR0UySH+d+bUVXzyMZlJSKrCYA/rkc96kJT4VG4RT8tonzpf
aqIrd4hDDLDwsM+7OLThdWDwp06xNf01QkNMZ9jfyOyNhg7bZYXVXYYcqLHfoWaH
tJ3ZyAWg2ky7pzAIGgEIwXklZj7GKaee2z5Dt2QhdN7oSvRqQ+4hBeJOgcPOmc01
gYyaknT82dL1fn0WMi0LBTlbcVfbAE92rYYSfyTd4uLpCmcPwxldh/ISMEnqZ4gT
gwMmiB9V7QtBkKQ2AWPFCgLePNpRadVi5cbQUrivLQKTIGoUdG+SXtOtbqxa/So/
8ppXK2MIKJJ5SL1fIoCBYaibjdZMhs3VByUNcE0fmRRlFFd3nqE=
=LjTc
-----END PGP SIGNATURE-----

--ze2yl4s4ujqonoqc--
