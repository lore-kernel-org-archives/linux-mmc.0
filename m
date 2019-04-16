From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
Date: Tue, 16 Apr 2019 10:14:33 +0200
Message-ID: <20190416081433.GA1012@kunai>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-23-fparent@baylibre.com>
 <2a384e4b-a23d-450b-ee37-57af8c097bae@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a384e4b-a23d-450b-ee37-57af8c097bae@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com, sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
List-Id: linux-mmc@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 09:58:09AM +0200, Matthias Brugger wrote:
>=20
>=20
> On 23/03/2019 22:16, Fabien Parent wrote:
> > Add binding documentation of i2c-mtk for MT8516 SoC.
> >=20
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
>=20
> applied to v5.1-next/dts64
>=20
> Wolfram let me know if you want to take it through your tree and I drop t=
he patch.

I'd like to take it via my tree to reduce conflicts. It already needs
rebasing on top of i2c/for-next because of Qii's MT8183 patches.


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly1juUACgkQFA3kzBSg
KbYvkBAAo8J4Hb7o2xSpDcB8bhSQ1zO7nKdqSNmT34i8lqsMct1Ou45q3AYaC3cg
pVFmgD0UWBqAw0WPxsWl2TMUuVn1BajUEr5iOYd7PrxGWXHEeFfZIRn4EGiQrtPl
4EH0eSgh5Oyh3DbwCuLAv94BaKkLom+RHcmdirrmePEkvlQGrnymlWkyK3MTNi09
bjcuB4TkVfjoYxq4f/KRQVcIseBwVNls5eGiESPZc4cDz3hUhTbWjRgo7lG21Bf6
3uEWyzN9zOwwrPssdem4GTLg4kgma+NMeZTlc0DVfzSf05jfCJLyJQraBoTGVrJ8
wIQYipa3kdpjKx9pqRW3BBAkGNms8o++1Ht3Cd2O7YeXwPmRiNW0mkAfcz8G68sP
bZIVt8Z/fYqPEvwVWj8XgNih1RLHxNLwTMrVkvvVGM+x9G39LiV6aZQU738FjsGm
/HuBzRyd+bUBLrJxFGQCpxp+ocdI825KEkCOW7XKPUUeSF+Gm01NeWM9h+CmmMbj
eX/o095Wj4cNXVhcMqNy8szkHuQbE1Ql5XnoML3eT6kg6POIZSDQzcf97SPHoqxN
sdUdqQslPz2cufPhdLQKXq5Hu1jL99pwoD0ff3uB7davdsnUxTmTD31GhX2eEDaj
Lo4dAVDImji28LAAtVhIPXhvZLqzWCUBXVM8hGd9ZSltSVq6DAk=
=72J6
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
