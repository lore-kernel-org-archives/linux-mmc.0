From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v5 6/13] mmc: sunxi: Add EMMC (MMC2) controller compatible
Date: Mon, 30 Jan 2017 12:05:46 +0100
Message-ID: <20170130110546.6q5xb3p2uvncrrmf@lukather>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
 <bcbeeb726c5638361590bd4c295279ef92d44209.1485553113.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFr3cnFux4NRzZ9UAn93MOVb6RaQQ+PHDxGztciDHZSX9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oblaussuvw2woeht"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46546 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbdA3LGL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 06:06:11 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr3cnFux4NRzZ9UAn93MOVb6RaQQ+PHDxGztciDHZSX9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>


--oblaussuvw2woeht
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 11:06:05AM +0100, Ulf Hansson wrote:
> On 27 January 2017 at 22:38, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The MMC2 controller on the A64 is kind of a special beast.
> >
> > While the general controller design is the same than the other MMC
> > controllers in the SoC, it also has a bunch of features and changes that
> > prevent it to be driven in the same way.
> >
> > It has for example a different bus width limit, a different maximum
> > frequency, and, for some reason, the maximum buffer size of a DMA
> > descriptor.
> >
> > Add a new compatible specifically for this controller.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index 6bbe61397b7c..f0f6922bca8a 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -5,6 +5,7 @@
> >   * (C) Copyright 2013-2014 O2S GmbH <www.o2s.ch>
> >   * (C) Copyright 2013-2014 David Lanzend=EF=BF=BDrfer <david.lanzendoe=
rfer@o2s.ch>
> >   * (C) Copyright 2013-2014 Hans de Goede <hdegoede@redhat.com>
> > + * (C) Copyright 2017 Sootech SA
> >   *
> >   * This program is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU General Public License as
> > @@ -1096,12 +1097,19 @@ static const struct sunxi_mmc_cfg sun50i_a64_cf=
g =3D {
> >         .needs_new_timings =3D true,
> >  };
> >
> > +static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg =3D {
> > +       .idma_des_size_bits =3D 13,
> > +       .clk_delays =3D NULL,
> > +       .can_calibrate =3D true,
> > +};
> > +
> >  static const struct of_device_id sunxi_mmc_of_match[] =3D {
> >         { .compatible =3D "allwinner,sun4i-a10-mmc", .data =3D &sun4i_a=
10_cfg },
> >         { .compatible =3D "allwinner,sun5i-a13-mmc", .data =3D &sun5i_a=
13_cfg },
> >         { .compatible =3D "allwinner,sun7i-a20-mmc", .data =3D &sun7i_a=
20_cfg },
> >         { .compatible =3D "allwinner,sun9i-a80-mmc", .data =3D &sun9i_a=
80_cfg },
> >         { .compatible =3D "allwinner,sun50i-a64-mmc", .data =3D &sun50i=
_a64_cfg },
> > +       { .compatible =3D "allwinner,sun50i-a64-emmc", .data =3D &sun50=
i_a64_emmc_cfg },
>=20
> This should be documented in the DTS docs for sunxi as well. I expect
> you to send a patch on top to take care of that.

You're right, I'll send a patch today.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--oblaussuvw2woeht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYjx4FAAoJEBx+YmzsjxAgnrgQAL9WNqCgJS+ZEk/dtAw7w6du
77+AhO2R9K4oovlZ5Fg3NcQDhahZ6ZUUg1rTI/P7YaTTuv/IjgNA8vIIzLRUnNo9
+gMSJ4VIrrzPCWs4QCMkgZnNJ/d0aNlFdu23ODNI00j6J4s6Ka/n6gUChGf+hBZ2
MxG94H9BRqcDFCUU/2UhjUsvFbiMoAQv5MSoEFyctZuNlRSJn41QvO6Squz7uPiw
zTnVe9NNVcLnAhAJozr2sQ2ez5+FfPQSsSkCSnZxcA3kd0QTqgYkbunx6aWBbzA9
FhftkRxrSt24Sl2Vqn/Qk4PNfC4gv5JZtkYQN3mjJVydRFs9huKEHL1pVHQHl0Rc
nmYDQ2tNlVJiENguROy56XtOQf/pqSnO5upIyHWT/IxKOx/6ZG925UTSlPufQVnT
hu7o+JXjU2qb4L3yVBOHOGDDIX+7NZHPYNmHe9o8KKOR7Y441TADQ06BDMVFca1R
qZGKo+dIPr/jm6l4kp4jInv7i1zQ5J+4d6kVKcx0bDlGZxwHkW+d7HmOk7qX4fUI
7EpMlPjrMimNSLnw/Q1XLUdcZR3zYlBJBHK9U74aQ5i8UJkUR8frA+LtrUwol5RI
oT7zJEYb0v0juiqcxgtTD59D2kAL3UX6/Zq+dV62LgDCXYT14a0P/5XNMhoc0c7a
CkGZOpbUXyVX1CrwaNT7
=3xFx
-----END PGP SIGNATURE-----

--oblaussuvw2woeht--
