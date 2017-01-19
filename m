From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Thu, 19 Jan 2017 20:02:17 +0100
Message-ID: <20170119190217.GB1439@katana>
References: <20170118172502.13876-1-chris.brandt@renesas.com>
 <20170118172502.13876-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:60930 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754225AbdASTCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 14:02:34 -0500
Content-Disposition: inline
In-Reply-To: <20170118172502.13876-3-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 12:25:01PM -0500, Chris Brandt wrote:
> In the case of a single clock source, you don't need names. However,
> if the controller has 2 clock sources, you need to name them correctly
> so the driver can find the 2nd one.
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgQ04AAoJEBQN5MwUoCm2t7QP/RIS0PAurhJ17FcbYaJfZFdX
Ca3VEk47s0Z7ij8fgXlHE79GmSL4eWdNqexgYcvlCFrWHaGoVvxlKmy50n7pNkDs
jHxLs5Z6pwPwiSl3f0/MkwRXA2M7T5eWjyUSGdyit2m43qef1ucHG3MgWarWU4C6
aon+qMAidF3OxuT4vbH/7Yk6QMADq72kSEiXqvulgZK5RBeyxeVOhSgJkwOof5nd
1Z/f9IEHBIz6XijKTfcbynjm/87/dTotYRHrzF6zAdIMSgIf2uWjvyjexsgvft+O
bUJTjuP3ohlXGMNjJfyvPGoNr7tyVuJns6j32+PgJskyYgT9LQUfnDgWtS+e5sbE
eAY+oOYJrDwBgJbNgkZB+fOnoCUjkmrAN3xzOSimGTHF0UWYGs6F1RcLv36WEtzF
OJH0wTaGYQtWng8V2KnX1mf9c4FFBGKo/RlQJQS9fD26Zl7tLupoWk3x4nYc4ETI
bRTVck8AIb0KJXwALcqRCUJB2WTFgtlLBcirSLpQN4yqUs32CWa0mEDZfdJwFODx
O6ihp4bbfGJNMk6M2I1qhimtK11whbcQl8T2S8+cPkDM9H5k2nzMV12l2oGrv/V3
BkKU+dvpp5/DNPYnnTb6l9tg/3dAehsOG9ZnSp7iKmx2WGvsKFKOYaUHM07XCGMe
anmD4Bdv6h/aNmVlAPIX
=4ReP
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
