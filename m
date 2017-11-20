From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/6] mmc: tmio: move mmc_host_ops to struct tmio_mmc_host
 from static data
Date: Mon, 20 Nov 2017 21:48:34 +0100
Message-ID: <20171120204834.c4ckog3rxeeojh2b@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-5-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o3axn3omayfqnokn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50769 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbdKTUsg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:48:36 -0500
Content-Disposition: inline
In-Reply-To: <1510042172-27220-5-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--o3axn3omayfqnokn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	struct mmc_host_ops     mmc_host_ops;

Just came to think of it: maybe a shorter name?

 host->ops

is still nicely readable, I'd think...


--o3axn3omayfqnokn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTP6IACgkQFA3kzBSg
KbYf1A//dyP7hYph1h/fOG/ZgEy1gV8MAj9LI2GETsZCgirC9We0XWCJnzwIEOsr
RK24+u5hZh2Sc2qELUUl6zHdA7+jaSPmhT/hRz0nAwYiZl1b+/Vb/iBqxn3A6Vxm
wdp9Ndt5NpVm8voXrDXokf2QgcYrXOzUgQUjKYKtoxlZXWH+PlyyEI9peC6wI9Ox
GBuGydwgi64NhXEg9osC5Gvlxc7I9AmdU1u85kmq7rEX3N65AZYbN8KhHbeGnzRt
Onx4ZyU5sTgjkI0C0WXzbjkMcHv+En9uZk12osenhpjU6twwqMY2iLeg2F+BbvhC
t9NZB6319zydVqbWb6Wy782vy0dSQx65Kg65m4J7LvTMtk/iFXdmwLlBvBzDFKuR
jNT2asHMR+m19o0eaNbBjNY8WM7+vuOQrn/pV9msYQdk7Vd/R14yypdozJmSu/id
VzRCQWqTog3NsdbjTEq35diCmuEKPTozs2CH9IPdOtMQ88ODWKyiYHgLT1ZIC9V1
kMd1DWALlluHYZaUFL3HmmnLetTT/K2nZQqKyIRKB9vvGaYLneg+rxQYk+Sq5jVd
SNM6PgYOAof+QEFow6IPlS0bsE7Wvcjnu8oiwbueePkqkd+SBOdZfVcm6x1uqYTm
v/gwdCrbdlj5aZL8SL9ht6YtyxjjKwumf4yRVrMV2PfHvxMGsC0=
=Tm4c
-----END PGP SIGNATURE-----

--o3axn3omayfqnokn--
