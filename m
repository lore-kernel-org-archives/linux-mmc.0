From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 23:41:39 +0100
Message-ID: <20170120224137.GD1438@katana>
References: <20170120194332.1683-1-chris.brandt@renesas.com>
 <20170120194332.1683-3-chris.brandt@renesas.com>
 <20170120213901.GC1438@katana>
 <SG2PR06MB1165035F107F504185B525658A710@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:60418 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752058AbdATWlm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Jan 2017 17:41:42 -0500
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165035F107F504185B525658A710@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> It sounds like your suggestion is to just put the HW description in
> the DT bindings, but move the dirty details into the driver.
>=20
> Keep in DT:
>=20
> +- clocks: Most controllers only have 1 clock source per channel. However=
, on
> +	  some variations of this controller, the internal card detection
> +	  logic that exists in this controller is sectioned off to be run by a
> +	  separate second clock source to allow the main core clock to be turned
> +	  off to save power.
> +	  If 2 clocks are specified by the hardware, you must name them as
> +	  "core" and "cd".
> +	  If the controller only has 1 clock, naming is not required.
>=20
>=20
>=20
> Move somewhere in the driver (maybe where the 2nd clock is detected):
>=20
> +	  Unfortunately, the existing driver architecture
> +	  does not support such a separation of clocks.

"such" is not explained. Maybe "does not support a seperation of clocks.
It doesn't work with Runtime PM because ..."?

> +	  Additionally, it is prohibited to supply a clock to the core but not
> +	  to the card detect circuit. That leaves you with if separate clocks
> +	  are presented, you must treat them both as 1.
>=20
>=20
> Is this what you were thinking?

Exactly.


--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJYgpIhAAoJEBQN5MwUoCm21iEP9ivLnVX3LgSHxtqx8UYvJpKJ
3Q+v2sD61HZUcVzzoXCDr9sUCEVFq1juoor1TaNgzLWGx31cgCD0pFl+MEZ2S9A+
+rJz6xsYPOC/IITYAJvmC/8+GdK7pxkc+KWMFvlcBR/OAcZpzWHziMnkpQKKoW7o
kR+B411kA/8kwoQpta5U+hL8Jk4Z/aQXOfiTyEDVDeZjHDUGm3+EAcSXLH2SGLd0
EcZ5vyDbdQwAhljGtazfpnShkDM9Z4c0Jiuz+V2D9/lBYPWQBuiJmlJBf3SHKH2v
rfd4ZVPKM1in8vGqDTNpUcON9koTIa3E/rXeWddxlCXGPiprwmuLsgyTjIZcVBl7
EXqlvA2DQoqddXs6kulq/WAy4IeSDv8ePxe2h2R5z2opGiUXApXqm0vt7te0ert7
tsJ6VphnJ1kpZIv4SQCa05HNhiKscBV8c4Al5MmyMbz6bpn2YJQ31pH+MXMqTN7G
+OIZIQJ6ddz5L5XzEtMapXdjfGYUGw5zguQHNUjLywg8YYTTbYPsaHQFODT/CJ6I
P2uoqBhUIclhdStOFgWLsZZZr/vL9Mr40r2H7BfrSRB9Fg8gDVRSgtmW96/EUwv5
+/4NvjCqY06SSCbEIm89ccUhZ9Q3UEugUGPhjPTxN8wjfnHvzJKSTWKPlIfeE3y+
ItQGojn/LZaSPo2cXpU=
=HVRM
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
