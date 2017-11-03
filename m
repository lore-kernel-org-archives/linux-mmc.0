From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: Replace msleep() of 20ms or less with
 usleep_range()
Date: Fri, 3 Nov 2017 10:55:53 +0100
Message-ID: <20171103095553.kybpk2q7nvc2hlne@ninjato>
References: <20171103093628.13108-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oex5xmxogtrfkw5t"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38150 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753232AbdKCJzz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Nov 2017 05:55:55 -0400
Content-Disposition: inline
In-Reply-To: <20171103093628.13108-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--oex5xmxogtrfkw5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 10:36:28AM +0100, Simon Horman wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>=20
> As documented in Documentation/timers/timers-howto.txt
> as follows, replace msleep() with usleep_range().
>=20
> msleep(1~20) may not do what the caller intends, and
> will often sleep longer (~20 ms actual sleep for any
> value given in the 1~20ms range). In many cases this
> is not the desired behavior.
>=20
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Note that this will not affect R-Car Gen2 and Gen3 upstream, except for
the reset path. The rest only affetcs older SoC.


--oex5xmxogtrfkw5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln8PSUACgkQFA3kzBSg
KbYWCQ/+PYgWxSzkbQZXm7P5jXjQZXrcDgNYQ3xRjpb03vrLa5z+kUpzoZQYClgd
F83uny0zlpHqQstvNW4zCJdY++EsElu3lp7bXXQ1m9eucTzy05WV1qihHkVH7VF7
HpNmG1wvxCO50XwtEwbc0Yn/q3RmdNjuJPkSNBg/L5CmBhRmssUjwq3KNYTYac/o
7oDar07t7VlSxOCoizosYNRvYm0PP88+u8vu+TxnemZpVWenBrOeUbq7E/oeUh0m
pQANx+huWZumBSu+7hRrwg7vMefTqpWW4UpwL24VGEWFS7YKaI/yanRC0ycV8rXD
LPkc2ewDje3meEceJmYVY53O8HF8iHo5eAWlZwOWFnggBwNjJs/uLbdAbIxA73jD
s7LiBXCYzVKZkLetkErLUUaS8Ds45gXCXnO9I9gyPvtWPm0v5W3hL0doiqEU3vZK
w3130Zsyic9Pxxc4QNLCQ7HNh9F0/1Ok9UgbGJY2d19vRfBHSNf3jozrOoD5YkHP
EaY2pSzTil9BRtJea+UPsCGPcswgLKeGN80vsoYvkr+FHSLyzNV+JCmr6c/cEebP
wHwVT3AOkKPl1/blaJwlDiCzgm/y9OBi5GdHav6iC2+5Qs0L51sGC2FA5jHdVfWN
dxLPqb+9DsrbqwU0R0XSEGgY0Ez+rKS3O+kvDEAnGyqL3nVxRlQ=
=uNA8
-----END PGP SIGNATURE-----

--oex5xmxogtrfkw5t--
