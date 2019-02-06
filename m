From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported modes declared
 in the device tree
Date: Wed, 6 Feb 2019 13:20:08 +0100
Message-ID: <20190206122008.ykldbk7kcfjfjxtv@flea>
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6r42epslv3udyodi"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205154225.14264-3-wens@csie.org>
Sender: stable-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Chris Blake <chrisrblake93@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--6r42epslv3udyodi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:42:24PM +0800, Chen-Yu Tsai wrote:
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>=20
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>=20
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>=20
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6r42epslv3udyodi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQ+AAKCRDj7w1vZxhR
xVkkAP9N0HH9HJ0MV1En3HP7Ygb/UhglPAPAQA32AQ+OgFmxTAD9HB/mP3Wg05ux
a/NdR+KsNS6hOmibmoCOuF4ym3tNWAA=
=zFwy
-----END PGP SIGNATURE-----

--6r42epslv3udyodi--
