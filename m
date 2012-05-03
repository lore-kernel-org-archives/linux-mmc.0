From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/29] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Thu, 3 May 2012 16:42:53 +0100
Message-ID: <20120503154252.GO3955@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jx/LfW4V5TfZLeq7"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--jx/LfW4V5TfZLeq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2012 at 05:05:36PM +0200, Guennadi Liakhovetski wrote:

> +	ret =3D mmc_regulator_get_ocrmask(supply);
> +	if (ret > 0)
> +		mmc->ocr_avail =3D ret;
> +
> +	if (regulator_can_change_status(supply)) {
> +		mmc->caps |=3D MMC_CAP_POWER_OFF_CARD;
> +		return supply;
> +	}
> +=20
> +	devm_regulator_put(supply);
> +
> +	if (ret <=3D 0)
> +		dev_warn(dev, "Ignoring useless (dummy?) regulator\n");

This code seems very tricky and a bit confusing - you're checking that
either you can change the voltage or change the status but you're doing
it in a fairly abstruse way and it'll come out as saying that a fixed
voltage regulator is a useful regulator to have which probably isn't what
you want if it's worth ignoring a dummy regulator.

You may also run into trouble on boards that use the ability to disable
unused regulators at the end of boot - they'll power things off even
without the ability to change status at runtime.

It'd at least be nice to write things more directly, or add some
comments.

--jx/LfW4V5TfZLeq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoqdyAAoJEBus8iNuMP3dkEwP/3rccjC0RZHYdRPMk9E2zJ3F
yHaqe8NmEMx+KpnilEnd4ww8vO32GNPM83oWsvPq84bsp6QSjQCO3FmdPTIBpZ6p
6tel9qSu7E/ue+0k5GhQab/DgsF8pL8rFNntA6fUqDU7YaQ5PlBk9KJb8JIR/sT1
Qlvj7Eak8pGOxc3CRMcpRc5AD4bzCE1Oi2RsgVan1JSJL6nDkccvFJ4l2/xWpJE8
0/rlGcKQtbVCwNNVAUNaGlP4J4iabLCNahnxM0SAfBYkWckDizaNr4ZklccnDIk+
MWiAJidH1XFwoRIbeYLKTStIYuuT+6AGuOb5o39l58WP5NgBO0XoIOWW+/uJ1dLE
Ym1E2TBMKz481h6cL9MeIakJfGmhC+2iEabDHyZWorKTjmCarWRJ/0V2BaycSTRl
kipeoKo2pfJ0fpaIR7bvWYbC4mOJoF1TR6PoUVG/MdKuV0rGNPY0k0gnBz78VK0I
uDxVu8UEKKOHCpT4GQ/uGOEN78dhFVqFzMXBw2b3OWLyjCcz8+UKNdNVBhWSMnug
0PEnoQYhhWit6G4fjzmrtki5pEYLWwICJKYRR5QCroGcLJ6YL+SO6GwO8r2B0U/f
NXimkyMt0o82FM54aWkdJzmQbtotWxB2IjMy5xyAwE6ktUSbSw6v3FYdcPUT07QQ
AMe4SwyrLu4vOm+eebNw
=F/m7
-----END PGP SIGNATURE-----

--jx/LfW4V5TfZLeq7--
