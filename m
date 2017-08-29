From: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH RESEND] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Tue, 29 Aug 2017 15:05:53 +0000
Message-ID: <TY1PR06MB0702FA2B782E1A29E40EEDCCB79F0@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <1504014726-17288-1-git-send-email-biju.das@bp.renesas.com>
 <20170829145852.j4epebxsb2j2i3d2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170829145852.j4epebxsb2j2i3d2@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 29 August 2017 15:59
>=20
> On Tue, Aug 29, 2017 at 02:52:06PM +0100, Biju Das wrote:
> > Add support for r8a7743/5 SoC.Renesas RZ/G1[ME] (R8A7743/5) SDHI is
> > identical to the R-Car Gen2 family.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > DT binding patch for r8a7743/5 SoC is applied for mmc next. But the
> > driver patch is still not applied for mmc next.So resending the driver =
patch.
>=20
> Didn't Chris Paterson volunteer to write a new patch introducing Gen2 gen=
eric
> compatibles? Or did I misunderstand?

I did :)

But after some off-ML discussion with Geert/Simon I decided to leave it to =
Simon as he's been doing a lot of similar work for all of the R-Car related=
 drivers.

This may not happen immediately, and we already have the bindings/DT patche=
s accepted based on this patch, hence the repost.

Sorry for the confusion!

>=20
> >
> > This patch is compiled and tested against mmc/next.
> >
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > index 160fbb2..df44654 100644
> > --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > @@ -98,6 +98,8 @@
> >  	{ .compatible =3D "renesas,sdhi-r7s72100", .data =3D &of_rz_compatibl=
e, },
> >  	{ .compatible =3D "renesas,sdhi-r8a7778", .data =3D
> &of_rcar_gen1_compatible, },
> >  	{ .compatible =3D "renesas,sdhi-r8a7779", .data =3D
> > &of_rcar_gen1_compatible, },
> > +	{ .compatible =3D "renesas,sdhi-r8a7743", .data =3D
> &of_rcar_gen2_compatible, },
> > +	{ .compatible =3D "renesas,sdhi-r8a7745", .data =3D
> > +&of_rcar_gen2_compatible, },
> >  	{ .compatible =3D "renesas,sdhi-r8a7790", .data =3D
> &of_rcar_gen2_compatible, },
> >  	{ .compatible =3D "renesas,sdhi-r8a7791", .data =3D
> &of_rcar_gen2_compatible, },
> >  	{ .compatible =3D "renesas,sdhi-r8a7792", .data =3D
> > &of_rcar_gen2_compatible, },
> > --
> > 1.9.1
> >
