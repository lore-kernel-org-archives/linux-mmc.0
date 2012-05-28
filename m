From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap: Fix a section warning regression
Date: Mon, 28 May 2012 11:22:18 +0300
Message-ID: <20120528082217.GI18918@arwen.pp.htv.fi>
References: <20120528065347.GR17852@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120528065347.GR17852@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 27, 2012 at 11:53:47PM -0700, Tony Lindgren wrote:
> Commit b6e0703b (mmc: omap: make it behave well as a module) made some
> __devinit changes but missed one function causing a section warning:
>=20
> WARNING: vmlinux.o(.devinit.text+0x8604): Section mismatch in reference
> from the function mmc_omap_probe)
> The function __devinit mmc_omap_probe() references a function
> __init mmc_omap_new_slot()
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

>=20
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1300,7 +1300,7 @@ static const struct mmc_host_ops mmc_omap_ops =3D {
>  	.set_ios	=3D mmc_omap_set_ios,
>  };
> =20
> -static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
> +static int __devinit mmc_omap_new_slot(struct mmc_omap_host *host, int i=
d)
>  {
>  	struct mmc_omap_slot *slot =3D NULL;
>  	struct mmc_host *mmc;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPwzW5AAoJEIaOsuA1yqREAs0P/2SbGt3OdMz4V2zg8sc6fF1v
PwYssXuWGVnGngZpgufr/mKzpIkaowEyQuQuidxBBKA9hYp1VO8ONcksm38kFNj3
GuSANTzeFUqMDwGsA8CBIXMnY3NTO8OtotDE1Sb2Tf3TdrfD37/EUzIxyAOEccKI
8066X2GwySuN2j2yaldfeUjqlmWtD2f1xB88SGPyGbv9yJGDZETze2szOLYZFitw
c+JpTK0cTla2LdXM8WiprVlA+QdXg38UcIHt+0OGgr1dSgh8eGQEp4FKi2VeKLZ8
kqLnFCse1zxRLNYn/dC7TxY7VpNdTmM1H4/wQeth+PMEb+ulpCsfbYyDQFnJFzsw
UBrzJzxkgu+MP7qeOikPrprh0F4nTa/I2xKGpoWIpUoHiAigy0F8mqUc48vlTuR7
GbeiArm/ft9/y/sZThql7khAAsjUKXktHS3eSHbHBkMruwEHam9IbCxNy2dNu/oJ
PryrAzXzx8pmZUpJSPcrqtO1D8YgfaO1cmM0cOJHE3Wh9wXsWe/jEZ2PMtNyeQXH
c2duXHqirFNkiWiLBchdRO1T5RS8bAzq+T/MN7rKdNbWrL7WaM6XoFE4D68aE6vT
unDdfvv1TcA0uQY7Kh8Q3H4bNf9To7M3/JiGrCN9KSSU0cP4s2NFM73nrpj+6/dm
qK5Yfcz3j9kG8IriswYZ
=JQtB
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
