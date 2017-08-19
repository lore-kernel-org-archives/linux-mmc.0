From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 5/9] mtd: nand: tmio: Register partitions using the
 parsers
Date: Sat, 19 Aug 2017 10:22:37 +0200
Message-ID: <20170819082236.GA1460@katana>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-6-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502743720-28672-6-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:48:36PM +0200, Andrea Adami wrote:
> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, w=
ith
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
>=20
> Use now these parsers.
>=20
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmX9UkACgkQFA3kzBSg
KbYMMQ//f4ysg7YVairVcHrQl7UJWFHvdXyYGRd7DDZbRWiUv4JLpSbuT6C7YlIp
mnJ0q2h+fy07/kqPemEq9wZa/GMtjausBZIohz/zIG/+qH2IFq0s1dunT826f+2E
vUZf83J5ZX7TFdG4FfB2YcsUPXMOX1TJHImhAi4ckftpCgc6qYCWVK2IUY/11zRi
2+sJPolBFBUO/7SP36KGtnl8g9UM0qQHtlwQ5ohCW0DDsRv88tU1ny/Yf/11mjLX
iAf76Iuy8Tahf4yye6DFHeEWbW3QFF59e4U3InmnJNrHBu6aJJFCsfYGIsNVqd7B
erU9S/6UImDM+7GETI7TFOA06H0D96O3SmQtRauIhGAW17OUnuBKGFAgYZfO5rNN
WgfudhxNtepjqure8Zp3HxSu+/Ul2lkBcQWvNgTIdS413UMe8gtJbkx14nSDydFk
jFdjHo9twUxBuX3tKgz2YhchcPuEVn3R/5VNS1ISTa/cuRw22lIHU/q8vGtNn9Co
+PI+XZ2Gonv4NgB6IWmDpIRiGRhCNcfd3QsuIePOs9SN2T+pN5AbF9HM3U42aArd
VWXcNLvvAAhvBYnbLXet2KJuriXMnnRlPdRPDzJldeMB56g/yJQT30ZLiJX0DIxd
TNqSpW8Wbymf4G+zjsKjfu7FHSl8bqmRQiwfL6XfhvW4vau7/Co=
=kb0v
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
