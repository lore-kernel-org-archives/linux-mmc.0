From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
Date: Sat, 19 Aug 2017 10:23:07 +0200
Message-ID: <20170819082307.GB1460@katana>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:48:34PM +0200, Andrea Adami wrote:
> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, w=
ith
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
>=20
> Thus, we need to extend tmio_nand_data to consider the partition parsers.
>=20
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmX9WsACgkQFA3kzBSg
KbariRAAqnCcAwVocasrASmcK04yf2GlYWVYTog7mipSU6+yPqUpZsf2skHfj7qa
eii2bChkQIXQLzCk8ACdn6qop7NidyHATIhEeGL+aBAMmaAkU33bjT4RNVMO6M8x
ZPo8AjJGTdmfxqsjQihQYyt0Mwn9irkM7g0fR4Hbw2BvyZ2PgP3+BnURe8g/AJYV
bgXBLvVIhpN2MCM6QRMGqwfsoRbVjNvJBc8MJqWcH12qm3RauBlZJ4qRY28LFcfX
JNYO88cq1kwBQceQn4xRMvb1Gzr7H3e9CqkR18ufPHPCRXvhS8dL1omqFMu6gLws
0i/WMi7AYdhDEC1AAxYsT5BlUGAoxXtXG/s6SxGKM7wd+rHlnbV3NHuro5pdOcIN
+ETnhAaQ2IKA0L2aCSRP9QQpMGZvS+hWb1s/nyDiIqFcrpqGt4GACzZJ3z+BJ85/
7eSMQfJTHfCO4DPyakpFO/fDi5cGBQvW0C9C7Teeq7RCM/ZO7zuD4hTSPz/3QfvJ
kHxjxyVHpErB7xSb6QmDyjeLu7qvOaMuXD1pVyv+Qj4BEi2ndnKuu+seLZA3HVYu
s25q+kyNSERl7k4J0QGfsd60WTLSgx86x/EN3/yzMUhS5s5w+XBcKEVpn97rmlb+
SdEfeK3F35S7RpspltL3g+hOXipI7Fc8QvO/vZ0GvIXySvzXkv4=
=J7e1
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
