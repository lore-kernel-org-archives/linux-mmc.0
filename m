From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] mmc: renesas_sdhi: implement R-Car Gen[123]
 fallback compatibility strings
Date: Wed, 18 Oct 2017 09:25:05 +0200
Message-ID: <20171018072505.zsevamypcxpfoa2p@ninjato>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
 <20171018070023.3878-4-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lzkq2zurqiyziid"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018070023.3878-4-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--5lzkq2zurqiyziid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 09:00:23AM +0200, Simon Horman wrote:
> Implement fallback compatibility strings for R-Car Gen 1, 2 and 3.
>=20
> In the case of Renesas R-Car hardware we know that there are generations =
of
> SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationsh=
ip
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>=20
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appea=
rs
> to be compatible with the IP blocks on SoCs within a given generation.
>=20
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme is being adopted for
> drivers for Renesas SoCs.
>=20
> Also, improve readability by listing the shmobile fallback compatibility
> string after the more-specific compatibility strings they provide a
> fallback for.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--5lzkq2zurqiyziid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnnAdEACgkQFA3kzBSg
KbYxvQ/9Ee9X4vHZ3V1zW9v5LAyHcoe1uv7N0u79Y02jr5+XoDwmlWC/30od97sR
pkbzMTv2blXXZFlzDL8fdXm8jlkir+AyUvmSWC8jCNhoDeR3qB3lAn5nZEyvgP6m
2W/u6jMoHNCAt8JKxM9/zyPRjwNvvT83G9tpsDjFxEfv+MeWl1Z9roC1+8o3EECy
2lmLlgEBEZkIBbZ/cWRdw6FzDYil1wyu5opK4ujlURX/s1M9R/P79xAdCO8nSuUm
KDJNVk7wWQHqyWzhb+KXTCnQ7EW7Tz7Ot7c8PMn0ihH7CXRoxUgBC8wS6y6QyEmp
wJ1LDinv3MzdBgHpO4T8ZSpSAD9iXv1QNoIyc8yZMOc6F5FAsLsFvT/NyZwwMSI2
rkjV/D1u10lyveDFppzP1kvzoz6a84iuUM1Nm7R2CUn2Bpeh0Z2ElvNl/Wt90JGl
l4W+0NQJ66N0o1sfIleWPMWEoTlEzw2l+tobtlP+/XdYu1VQjjDPXK24uEQ8hkuD
EQIsYf+XgiLxi8a57UIwazSzdfIlQf2+Ep42l59NYTbC+VjGMmDGaZURCZ99Yumo
TC3srbU97x39O4ywA6WQgtdSwdvaikycD+tAC8LYgPdEjzY0zC7Ry71ge/jHhGGM
Lt69M56EXiASiH8BsPknMYR5s9m6kHKwqRtqD1KcRCwAC1cwp78=
=UD5X
-----END PGP SIGNATURE-----

--5lzkq2zurqiyziid--
