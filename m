From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/3] mmc: tmio: correct treatment of errors during
 tuning
Date: Wed, 7 Feb 2018 22:52:52 +0100
Message-ID: <20180207215252.dirj5x7ky5bdznmk@ninjato>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-2-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj7xmhrloyxynxeq"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119133906.11280-2-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--gj7xmhrloyxynxeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 02:39:04PM +0100, Simon Horman wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>=20
> If the return value of mmc_send_tuning() is error other than -EILSEQ, the
> tuning fails and process goes out of for_loop.  But the correct processing
> is to judge their TAP as bad.

Ideally, we would have more specific reasons why this is correct processing.

What other codes could happen here?

> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2 [Simon Horman]
> * Added to patchset targeted at upstream
> * Minor revision of changelog
>=20
> v0 [Masaharu Hayakawa]
> ---
>  drivers/mmc/host/tmio_mmc_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index 6d8719be75a8..41767d33ef97 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -800,10 +800,7 @@ static int tmio_mmc_execute_tuning(struct mmc_host *=
mmc, u32 opcode)
>  		if (host->prepare_tuning)
>  			host->prepare_tuning(host, i % host->tap_num);
> =20
> -		ret =3D mmc_send_tuning(mmc, opcode, NULL);
> -		if (ret && ret !=3D -EILSEQ)
> -			goto out;
> -		if (ret =3D=3D 0)
> +		if (!mmc_send_tuning(mmc, opcode, NULL))

I'd prefer (mmc_send_tuning() =3D=3D 0) here instead of '!mmc_send_tuning()=
'.
This reads as 'is ok' while the other reads more 'if not ok'.

>  			set_bit(i, host->taps);
> =20
>  		usleep_range(1000, 1200);
> --=20
> 2.11.0
>=20

--gj7xmhrloyxynxeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7dTQACgkQFA3kzBSg
KbYIjg//a1DsxTmVYaw2HMDCncbkHYlkUL9KSeRFiRizv4XU0qoygtlFkM0/n0T9
Psm/GAm3zcqn8UhuCkQmhmYqHj9X10cBfHWtxMFaAZyE9AmBKksxSqPVyBkAaXx0
BrTDH1KayIwifyavVk48xR31ZKl5KMZOTYsyWvWK/nNxXAi6MXrTvk+4PmfnEx3Y
CTFyF10gAg0WTXqXOEy9h2VDxWKCSHOCPYQyoHsN/FX7PRPKGdcvfFD63QFNXQzE
7sNNLjKiuWr5n3jv2ZdgQ153CgBfn2N4ziigQdigHKa2gFF8cnoXWj4W1dDJRXyx
WkKE5RCiS2lvmsBQPUKBCuXXpAanpV+YBNLjPtrZiBlbwjPve6qsqpUwKCWX+/Hp
pdG8eh/l25rPjDlahvvpO3NPAoIcm3gy4fUkHxSO/Qvfxz9d317Xg1UAMwxmFJeU
AtG009oLCZOiD4Mvh7mGsSflFx8jgHFFoI9goX3PxlG0UJL57cx66m+Fe2XwhcTy
v6Z8dp8SybiMgksUPAodwfZvZ2hp0XZP2KNzNoMax+JCyMaXSW98l+FlHazW4pqE
1GnhSRMBXgCD5xrSfk5xwh4JXwfM6WauuyXXb01pH/3Z/A08CIdOCx5EmRB4HwqE
YdHVUbB9WdBi7eDGJKh0aTCWvagQXf/KTNj5NHROWiovqee5dfY=
=xZwc
-----END PGP SIGNATURE-----

--gj7xmhrloyxynxeq--
