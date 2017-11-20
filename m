From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 5/6] mmc: tmio, renesas_sdhi: set mmc_host_ops hooks
 directly
Date: Mon, 20 Nov 2017 21:46:11 +0100
Message-ID: <20171120204611.giorm6ujlqvwv6im@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzo3zil3xqq2ehy6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50748 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdKTUqN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:46:13 -0500
Content-Disposition: inline
In-Reply-To: <1510042172-27220-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--wzo3zil3xqq2ehy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:31PM +0900, Masahiro Yamada wrote:
> Drivers can set any mmc_host_ops hooks between tmio_mmc_host_alloc()
> and tmio_mmc_host_probe().  Remove duplicated hooks in tmio_mmc_host.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Yes, this is much cleaner. I like it!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--wzo3zil3xqq2ehy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPxMACgkQFA3kzBSg
KbZh+BAAq8vuz0zStvT2OnEhU5ZG5FCD0x9ysQn9RtNq8wbs0uF908UTZ7Y/kcFw
jGmjYUqUctIP/7UIuQStRj4N0jhW43kxZ6Uu05NDO2ld7M2+x+WyvlhE+AOSAgKf
uaBI+qvf6E2L9z2qJwJ8H3yGcwGve6tDrZyjAAsoa1rtWaZGEt+dd2GklgtPoUhr
VSDD3ZV/UXWG1GQ5eFjJJygdak1L6Zwj/kJZbY6xVumKmQOljkFs2x1gAGYJZmUO
Er7iRwnBndHOn5bSBSmM6hv1HI9IoHzPbI/5HlK72Bk7eQhgvqlLCaNh5gFZFB3j
5BPqidKNp/McxE6BWZ6YeeGwuMw3rYQ+HXR0EfZY6q+W4MCfL3+BBEUmNzjhBkm5
PjirbBvpi+LxLh3ByZFFjLKmxrjPA5jNtLo9NB03LR4UBb9pDz1/JV4AtRSvpIXk
ZBjjyXENnSjGKcONLxb5ay7beCH8dqLc6OszqO1+dJREZwUStWJNS29rzGOZG80d
nf5wGKfyi6y5f6VeX5cGljwbPA1LQqCSbslQk+cz4kK0dVILyjjo1bN2Svn3261R
nOIjPxHU56eYrS5xGsOAEJUw9FQdcxoBP/jlYUfCyuZwM7sBHxh6gZg1Z3Ozir50
oCtTOuzyghLjdLwyclPV3Sic17V6AGGySlY/mJd6iBQpRGfPhhU=
=2rbi
-----END PGP SIGNATURE-----

--wzo3zil3xqq2ehy6--
