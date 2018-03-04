From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 15/16] mmc: tmio: clear force_pio flag before starting
 data transfer
Date: Sun, 4 Mar 2018 23:39:13 +0100
Message-ID: <20180304223913.ywpg2dohalxj53uf@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-16-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jm3jeqc6ly6lrrsy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-16-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--jm3jeqc6ly6lrrsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:15AM +0900, Masahiro Yamada wrote:
> Currently, force_pio is cleared when the driver exits.  Then, it
> resulted in clearing it in multiple places since MMC drivers in
> general have multiple exit points.
>=20
>  tmio_mmc_reset_work - bails out on timeout
>  tmio_process_mrq - error out when it cannot send a command
>  tmio_mmc_finish_request - successful exit
>=20
> This is error-prone since we may miss to cover all bail-out points.
>=20
> To simplify the code, the data structure should be initialized just
> before used since we have a single entrance.  force_pio is only used
> for data transfer, so tmio_mmc_start_data() will be a suitable place
> to clear this flag.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--jm3jeqc6ly6lrrsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqcdZEACgkQFA3kzBSg
Kbaocw/9G2gJCp9F4lNf1kMama9syRmreknA3I3dguGL7TBH5SxPIkm/Oric/ky1
Upi9d8oVGCUHeP3DeM9/4r+q7hHX9F2wPv1mpq2ep5nkuU1VqgzaAma17aJaRRg/
nQ58/CK5dpyl1rk200TtqxRkdWV1s1wh8TNhiT4kKJvNkHdJjT9/u89PCB5bAFBk
iCZK0NbQ5y2/QI17MVErjph49rgQPOb8AvKg1RuXMa/Qt8jTNi3HAF9B55kxjWPJ
dcnOsRVXLbZsAijkK0M33u/7h+LkIzAhW0Z2tLiKC+0fUETeR28wGAsxm49FuY6E
EBDdXW8t83+2GcBBqrBr2eHsAKz8berk+u80YKz5gbP8Yscra/khnIodErkaJ38d
09o6VgrLqcYdS7kdjCiDWB7zceeKrOjzlxwsb1o4LLKAOXbqXjrk9UY2tGn/Oqyz
A3sJ+vcQ58N2qiMOgXqoUDnAg/mKZs9G8Cs4myor8d/48l/aYjPiAMWJt35Zl77Z
3bNlMg0I/FQ4zsU/utFjcfP7v8N6tsQT79vnzCbaPIiGUS16w5Pu4908IIB7Px86
Eoy5obRhjgm5gRdgAUSMP1oZxxOHGAStcDIYC7GNnGfwrrimSibRpqvjuBja/QHy
sRH0BL38UqzYpPkSFCQL3vvgVKd4I5t8n3ij3iqotUE8lBd4pzg=
=f11D
-----END PGP SIGNATURE-----

--jm3jeqc6ly6lrrsy--
