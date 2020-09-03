Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08FEC433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE752206EB
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgICOmA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgICOix (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 10:38:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113BC0619D0
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 06:29:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 30B0D29AF80
Received: by earth.universe (Postfix, from userid 1000)
        id 542E83C0C82; Thu,  3 Sep 2020 15:29:26 +0200 (CEST)
Date:   Thu, 3 Sep 2020 15:29:26 +0200
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
Message-ID: <20200903132926.yc2lx25k2xbzglzc@earth.universe>
References: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
 <20200901114642.vhivtsfrarua6ce4@earth.universe>
 <VI1PR04MB5294C1AE26EA2D0DA163F307902F0@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <20200902134906.uqyoejyv4atljm46@earth.universe>
 <AM0PR04MB52835B3EF15DA576F6E46F8E902C0@AM0PR04MB5283.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksw64c6ovndzqk25"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB52835B3EF15DA576F6E46F8E902C0@AM0PR04MB5283.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ksw64c6ovndzqk25
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 03, 2020 at 02:10:43AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Sebastian Reichel [mailto:sebastian.reichel@collabora.com]
> > Sent: 2020=E5=B9=B49=E6=9C=882=E6=97=A5 21:49
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: dl-linux-imx <linux-imx@nxp.com>; linux-mmc@vger.kernel.org; Shawn =
Guo
> > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Baumgartner, Claus (GE Healthcare)
> > <claus.baumgartner@med.ge.com>
> > Subject: Re: mmc0: Timeout waiting for hardware cmd interrupt on i.MX535
> >=20
> > On Wed, Sep 02, 2020 at 11:24:52AM +0000, Bough Chen wrote:
> > > > -----Original Message-----
> > > > From: Sebastian Reichel [mailto:sebastian.reichel@collabora.com]
> > > > Sent: 2020=E5=B9=B49=E6=9C=881=E6=97=A5 19:47
> > > > To: dl-linux-imx <linux-imx@nxp.com>
> > > > Cc: linux-mmc@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>;
> > > > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > > Baumgartner, Claus (GE Healthcare) <claus.baumgartner@med.ge.com>
> > > > Subject: Re: mmc0: Timeout waiting for hardware cmd interrupt on
> > > > i.MX535
> > > >
> > > > Hi,
> > > >
> > > > [add i.MX architecture maintainers to Cc]
> > > >
> > > > On Tue, Sep 01, 2020 at 07:37:31AM +0000, Baumgartner, Claus (GE
> > > > Healthcare) wrote:
> > > > > We have a board with an i.MX535 using a Samsung eMMC as persistent
> > > > > storage connected to eSDHCv3. Every now and then we produce a
> > > > > build that causes emmc timeouts:
> > > > >
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: Timeout waiting for hardware
> > > > > cmd
> > > > interrupt.
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D SDHCI
> > > > > REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Aug 28 07:32:12 c=
smon kernel: mmc0:
> > sdhci: Sys addr:
> > > > > 0xe3f12000 | Version:  0x00001201 Aug 28 07:32:12 csmon kernel:
> > mmc0:
> > > > > sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001 Aug 28
> > > > > 07:32:12 csmon
> > > > kernel: mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Present:   0x01f80008 |
> > Host
> > > > ctl: 0x00000031
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Power:     0x00000002 |
> > Blk
> > > > gap:  0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Wake-up:   0x00000000 |
> > > > Clock:    0x0000011f
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Timeout:   0x0000008e |
> > Int
> > > > stat: 0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Int enab:  0x107f000b |
> > > > > Sig
> > > > > enab: 0x107f000b Aug 28 07:32:12 csmon kernel: mmc0: sdhci: ACmd
> > stat:
> > > > 0x00000000 | Slot int: 0x00001201
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Caps:      0x07eb0000 |
> > > > Caps_1:   0x08100810
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Cmd:       0x00000d1a |
> > > > Max curr: 0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[0]:   0x00400900 |
> > > > Resp[1]:  0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Resp[2]:   0x00000000 |
> > > > Resp[3]:  0x00000000
> > > > > Aug 28 07:32:12 csmon kernel: mmc0: sdhci: Host ctl2: 0x00000000
> > > > > Aug
> > > > > 28 07:32:12 csmon kernel: mmc0: sdhci: ADMA Err:  0x00000000 |
> > > > > ADMA
> > > > > Ptr: 0xef041208 Aug 28 07:32:12 csmon kernel: mmc0: sdhci:
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Some extra information: The timeout always has cmd =3D 0x00000d1a
> > > > (MMC_SEND_STATUS) and resp[0] =3D 0x00400900 with resp[0] translati=
ng
> > > > to this IIUIC:
> > > >
> > > > Bit 8 =3D Ready for data
> > > > Bit 11 =3D CURRENT_STATE is TRAN
> > > > Bit 22 =3D Illegal command
> > >
> > > According to the code logic, since this cmd13 get hardware cmd
> > > timeout, which means this cmd13 do not get any response. Here the
> > > Resp[0] should be the previous command's response.
> > >
> > > So this means the previous command is an illegal command, cause the
> > > emmc internal firmware stuck, and can't response to the next cmd13.
> > >
> > > I think we need to firstly identify the specific place in emmc driver
> > > which trigger the log dump.
> >=20
> > My understanding is, that a missing response from the eMMC should trigg=
er
> > the Command Timeout Error Status IRQ in eSDHC after 64 SDCLK cycles (see
> > section 30.7.10 [ESDHCV3x_IRQSTAT] in the i.MX53 reference manual).
> > 64 SDCLK cycles means, that this should recover quickly and would not b=
e a
> > problem for most usecases.
> >=20
> > But what we are seeing is the software 10 seconds timeout. My understan=
ding
> > is, that this should not be triggered if the SDHCI controller works as =
expected
> > (e.g. by generating a IRQ for the timeout). This timeout is much more
> > problematic, since all eMMC accessing processes block for those 10 seco=
nds.
> >=20
>=20
> Agree, only one possibility, the cmd13 do not send out successfully.

I think there are two possibilities:

1. The command is not send out, so no IRQs are received.
2. The IRQ gets lost or is not generated

The esdhc_writel_le() has a workaround to avoid missing the card
irq. If that does not fully fix the issue, I would expect the SW
fallback to also cover that case.

> The count of 64 SDCLK cycle only trigged by the end of the sending
> command. If the command still not send out completely, then
> should trigger the 10s sw timeout. Let me double confirm with our
> IC team.

Ack.

> I still suggest that we need first to find which cmd13 in our mmc
> driver meet this issue.

We will try to figure that out and report back. Needs a bit of time,
since the error only appears after some hours on an affected kernel
and adding the necessary code potentially hides the problem due to
the alignment changes requiring another run with padding nops.

-- Sebastian

> > > > > Timeouts do not occur with every build. After some debugging I
> > > > > have found that timeouts seem to depend on code alignment of the
> > > > > esdhc_readl_le function. I have bisected the behavior by using the
> > > > > System.map and moving/padding the code with NOP instructions (mov
> > > > > r0,r0).
> > > > >
> > > > > My test case has 5 processes continuously creating a file, writing
> > > > > random long data, reading data and deleting the file. It seems
> > > > > that when the esdhc_writel_le is aligned on a certain address then
> > > > > the timeout will occur about 5 times/12h using my test case. If I
> > > > > add one more NOP, the timeout will not occur at all. If I continue
> > > > > adding some more NOPs the timeouts come back. Seems that it
> > > > > doesn't matter where in the code I add NOPs as long as the address
> > > > > is below the address of esdhc_writel_le.
> > > > >
> > > > > We also run the same software on a dual core i.MX6 without any
> > > > > timeout issues.
> > > >
> > > > And the same kernel binary is also used on an i.MX6 single core
> > > > (albeit with different SW) withot triggering the problem so far.
> > > >
> > > > > I have reproduced this with kernel version 4.19.94 and 5.8.3 and
> > > > > we have compiled with both gcc8 and gcc9. I'm still searching for
> > > > > the root cause and I would appreciate any thoughts about where to=
 go
> > next.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > -Claus-
> > > >
> > > > To me it looks like it might involve an unknown hardware errata for
> > > > i.MX53, but there has been one similar report before (unfortunately
> > > > without the full register dump) involving virtualization:
> > > >
> > > > https://patchwork.kernel.org/patch/10705823/
> > > >
> > > > Note, that Claus' kernel has been built with CONFIG_PREEMPT_NONE=3D=
y.
> > > >
> > > > -- Sebastian

--ksw64c6ovndzqk25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9Q76cACgkQ2O7X88g7
+ppxHA/+Nug7kVnYprmKlNYt+SZ5t2CxG68vqOfZUvBMcpIuwotsEE55S75vlj1u
pby8hWGzrGO5vwAIHugIgCzhLyPvG26cYH4lmtdPfx08x0HqObD0H7/x1Ow4u33J
WjFofDUMdA3cCFYq/21L8HJA+vRXyXkx6G7y0JvpLkVW+VRr7ehiyU/Juv/RjVtZ
1HL7HMZDOgucPvJP2WcPetXyXO59v9kzkREfOm+J12ANlBPRRA8i2YtCIy7bnZob
8LO8vHoNSzaI2li5HXDQUG6U1hsqm/KAE1at4wquOc7vcx8JmaWuIGpQg9LlN/EL
RIOTxAYPIX40iCg1+4PfWwtN0cEr2NdD75cG7ANzuGTH/aBaFJRHvvnGL/0hu0LH
efPlVPzzO12Fg7/grsdjMkPGu4pbl2/Wi+2YLfRwy/IeCJ6R4NuivId154E6iPv+
rOx13KQh0QYdauYQ0sxAahqoPwZQzWSJrp3CK+0NBqXP7Fnoszi2jg1E/6xkuqqn
1GRrd+JerWS6ajca8f+FM0VLCGZfesCXDLdHTQAX5oU2ok70rkaMEASwll33dcQa
BlDHc7+5+Dy64/2JeWiDBFt/5JYabC2lD8EqV1tsw2v68/3ECAZ9HlRz8mYLnv1f
SPmWgXVS1Qxgp3Kyz33GpJd3d4TQPFsLLIuS9mPTaPy6M3nM+9Y=
=z14K
-----END PGP SIGNATURE-----

--ksw64c6ovndzqk25--
