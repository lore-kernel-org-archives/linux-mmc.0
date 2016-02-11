From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/8] pinctrl: sh-pfc: r8a7790: Implement voltage
 switching for SDHI
Date: Thu, 11 Feb 2016 14:53:55 +0100
Message-ID: <20160211135355.GA1520@katana>
References: <3375560.xz1gJhmReB@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3375560.xz1gJhmReB@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > b/drivers/pinctrl/sh-pfc/sh_pfc.h index 734f7a92229c..3eca740bba02 1006=
44
> > --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> > +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > @@ -272,14 +272,18 @@ struct sh_pfc_soc_info {
> >  		.enum_id =3D _pin##_DATA,					\
> >  	}
> >=20
> > -/* SH_PFC_PIN_CFG - Expand to a sh_pfc_pin entry (named PORT#) with co=
nfig
> > */
> > -#define SH_PFC_PIN_CFG(_pin, cfgs)					\
> > +/* SH_PFC_{PORT,GPIO}_CFG - Expand to a sh_pfc_pin entry with config */
> > +#define _SH_PFC_PIN_CFG(_pin, _name, cfgs)				\
> >  	{								\
> >  		.pin =3D _pin,						\
> > -		.name =3D __stringify(PORT##_pin),			\
> > -		.enum_id =3D PORT##_pin##_DATA,				\
> > +		.name =3D __stringify(_name),				\
> > +		.enum_id =3D _name##_DATA,				\
> >  		.configs =3D cfgs,					\
> >  	}
> > +#define SH_PFC_PORT_CFG(_pin, cfgs)				\
> > +	_SH_PFC_PIN_CFG(PORT##_pin, PORT##_pin, cfgs)
> > +#define SH_PFC_GPIO_CFG(bank, _pin, _name, cfgs)		\
> > +	_SH_PFC_PIN_CFG((bank * 32) + _pin, _name, cfgs)
> >=20
> >  /* SH_PFC_PIN_NAMED - Expand to a sh_pfc_pin entry with the given name=
 */
> >  #define SH_PFC_PIN_NAMED(row, col, _name)				\
> > --- END ---
> >=20
> > If you're happy with that, I'll re-send the series (hopefully for the
> > last time!) with the r8a7790 changes squashed into "pinctrl: sh-pfc:
> > r8a7790: Implement voltage switching for SDHI" and the SH_PFC_PIN_CFG
> > macro change as a new patch before it.
>=20
> That looks good to me. I'd split it in two patches though, one that rewor=
ks=20
> the existing macros (the drivers/pinctrl/sh-pfc/sh_pfc.h changes) and one=
 that=20
> implements voltage switching for SDHI on r8a7790.
>=20
> I would also avoid renaming SH_PFC_PIN_CFG to SH_PFC_PORT_CFG to avoid=20
> modifying unrelated files, you can name the low-level macro __SH_PFC_PIN_=
CFG=20
> and add
>=20
> #define SH_PFC_PIN_CFG(_pin, cfgs)				\
> 	__SH_PFC_PIN_CFG(PORT##_pin, PORT##_pin, cfgs)
>=20
> Additionally, your new SH_PFC_GPIO_CFG macro seems identical to _GP_GPIO =
now.=20
> It would make sense to merge the two.

It is identical. And since we meanwhile also have PORT_GP_CFG_32, I
wonder if we can't simply do this in CPU_ALL_PORT?

@@ -30,7 +31,7 @@
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_30(1, fn, sfx),						\
 	PORT_GP_30(2, fn, sfx),						\
-	PORT_GP_32(3, fn, sfx),						\
+	PORT_GP_CFG_32(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),		\
 	PORT_GP_32(4, fn, sfx),						\
 	PORT_GP_32(5, fn, sfx)
=20
And skip all the macro refactoring?

I'll test this once I have access to my Lager again, but though I'll let
you know already...

Thanks,

   Wolfram

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvJJyAAoJEBQN5MwUoCm2cCoP/RSfWbMuCrwlOZsMd3ouWppi
xdFXAWoPWDpUuL+82wSunph92foeFZFI3HgBB3SdcnsKSTSdPL3XP9tFpDwp0/aY
7F/3SmZ3jHkUD/jBHMmVB/Um6eJLMZMmaVQXV0tKNrzABo0GagtPNS0uiELMylG4
i7e3Gf1RE3igD04sR3VgZSTIm2bGDvhdIhDtwTruX40rvlX+bkDJrwS3Tc/bQ2kh
uDi9GCrY1X8PVg1KYQ1qLSluTK9xbeXQOAUeUx7JdC6dMChAvlZmVndwItiqR1oe
BrhiZxIkf/7oJDA5XJgl4gY9ck8f9r4giWmY4fVJQwzXS/DvH4V17qbmNGlwS0oY
pPhWKpvxLFuELBB1PLyXR+t5eoNRbkQuVcyuglRNjy8rpwK1PGGRqFIsTPSOpy/G
sMhkQHUOCikyi8nTb4Unz5w0WiWKSSbVGJ3QssHWrotHPJAnALWH+SwN8qC6pmq1
DziR4cQOvo7SF6VgyfJbpf120FV+dalvtI8/cHzqvFB1lsOjM7/4+O/45IyFa9BM
6xI0ZJMYlulzif8BiAq++p4fk7qwQmQ2tAGE/HIGtJjvzFT1ePwzk4v8CgPj/J6f
awlLmYI3jA1xjuR7s1VE20at2gFxorm5tqWC3Ph3GjQVyWDQl46VTafbI/IsDWFu
Fu7Io08rKNvjz64wBB+b
=O7Zg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
