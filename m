From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
Date: Mon, 30 Apr 2018 11:31:57 +0200
Message-ID: <20180430113157.37a09e5c@jawa>
References: <20180422213126.32756-1-lukma@denx.de>
        <CACRpkdbzvnSHPQOZjs3WcL9pOMz3R0W9P9Gre5n_G40udTMUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GQcZcnqHsueOF9j.h1LrYQo"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbzvnSHPQOZjs3WcL9pOMz3R0W9P9Gre5n_G40udTMUjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
List-Id: linux-mmc@vger.kernel.org

--Sig_/GQcZcnqHsueOF9j.h1LrYQo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Apr 2018 11:13:45 +0200
Hi Linus,

> On Sun, Apr 22, 2018 at 11:31 PM, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> >
> > On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> > that the imx53 rom boot code is unable to probe, resulting in
> > reboot hanging. Add a device tree property to disable sleeping
> > on suspend.
> >
> > For TQMa53 modules the exact commit to cause hang after reboot
> > (v3.10 -> v3.11):
> > commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC
> > bus_ops")
> >
> > [The exact discussion can be found here:
> > https://patchwork.kernel.org/patch/8881401/
> > "i.MX53 restart via watchdog does not work"
> >
> > Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
> (...)
>=20
> >  Optional properties:
> >  -broken-hpi : Use this to indicate that the mmc-card has a broken
> > hpi implementation, and that hpi should not be used
> > +-no-sleep-on-suspend : Do not put the card to sleep when
> > suspending.
> > +              There are boards with bootloaders that are unable
> > +              to probe such card when rebooting. =20
>=20
> As far as I understand this problem is not coming from the host
> controller itself,
> so it should not be tagged on to the host controller either. Rather
> the problem is how the specific system has integrated the host
> controller, the problem is in the fixture of this specific machine,
> as you say, in the i.MX53 ROM.
>=20
> In that case, I would say use this:
>=20
> if (of_machine_is_compatible("fsl,imx53")) {
>    ..activate quirk...
> }

I see. Thanks for pointing this.

>=20
> Yours,
> Linus Walleij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/GQcZcnqHsueOF9j.h1LrYQo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrm4o0ACgkQAR8vZIA0
zr2sFQgAv82zj0TyT0DP6MwwHWZ27wU8H3GjV0n6w1jRM5g9btdBLTHC9aHPzG7G
yIW0NNM8WSe29uDqd8THmfGrjbMtzdxa/1eAj3eQxtwJsKJd43w5KrZVmU8azPmk
+kQkxLalkjDqkUsRv7CiTAPCn+OGVngaA8dcCvV1EvDBkzgCKBzfc7ahBj2TWcK6
3ejEbPNw8i9ujLP8qtRdpEUAOtJlYWNPG7U6n9ddtQCIQH0JZ8pU0+Ff0iAI7150
2nqPtmCyIlQUZYlIYslf2KG7PpH45lJ09uKu2tM7lpaiRBQnuG+nYf7dxsPfnage
8aVTBQyZZg1gDZ3q/OUvAqTRDZkYnw==
=sbpo
-----END PGP SIGNATURE-----

--Sig_/GQcZcnqHsueOF9j.h1LrYQo--
