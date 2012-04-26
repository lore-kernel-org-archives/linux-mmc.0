From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] mmc: tmio: add regulator support
Date: Thu, 26 Apr 2012 13:11:51 +0100
Message-ID: <20120426121150.GJ3207@opensource.wolfsonmicro.com>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
 <1335285707-22707-6-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1335285707-22707-6-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-mmc@vger.kernel.org


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 06:41:45PM +0200, Guennadi Liakhovetski wrote:

> +	host->vdd =3D regulator_get(mmc_dev(mmc), "SD Vdd");
> +	if (IS_ERR(host->vdd)) {
> +		host->vdd =3D NULL;
> +	} else {

This silently ignoring errors really isn't good practice :(

> @@ -1052,6 +1079,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *hos=
t)
> =20
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	regulator_put(host->vdd);

devm_regulator_get() is there now.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmTt5AAoJEBus8iNuMP3dOAEP/2TpHFZ4qWRRxwVDDJx9LXrf
iyewmSvTOu9aJe+RmPhibFJ4TvVXQeRv9QJkV/Nj9E+ofiFdULo4c1tIoyuGEaTp
BvSnuc79CDwiGcHDbsFGKycHSBVolpi3NYGjvAioecOwhSnDUL4nvdmbZyQuNpPJ
BC4ydJQsHuVWgLMIojOimeREnnqHYcaypyFnVBfk7rPzoWqn0LzIq2nQZUZwY4rr
eGGVEEqtaoOUPLYtjp4r6niTHVeW0d3K+u+CkUuDU8c237ekvR03ISmSpbCvx2vV
iJjoD2TajZXCxmJFYlXQZ3bdvDvYg5ufSDwMfdjxI9J1yNoam+F4kS/53l3uW//t
7nBusWmH4Dfq+fE2xng/yjwLmu5EXvNVLKkoofd4vHihWt/ra089bl+34tjz50vL
MHYgR55/Pih6PSdYGen35VN3PZ0DRHWGTcpiA20qSlXXkvbQHn6FAsQGzAt8j7u0
NZfWQqbRw2eeZCx+gUxoG+Wc9xD59Pr8j3K+GcNsfJD2xkQf7TnZ0oMyB3wsJYYT
OnH+cd/uE87eZ3s91uB4fXbmgohjazXTxDZ7PNXf5eikaVLBMjG9uXWVLmfemCgJ
GO4JBBYK0hfVOapOeZAArdXDm2BOpKpzLbo+a1dTTQ50rLYheVGWsBcQYgeOK08l
Fdmc52OBQyTNXbol9Fuy
=7ckQ
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
