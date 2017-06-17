From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 2/4] mmc: tmio, renesas-sdhi: add complete to
 DMA ops
Date: Sat, 17 Jun 2017 17:01:05 +0200
Message-ID: <20170617150105.esceda3kiavhmu5x@ninjato>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3fa7uv6ufoyadd4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45931 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdFQPBJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 17 Jun 2017 11:01:09 -0400
Content-Disposition: inline
In-Reply-To: <1497607134-10241-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--u3fa7uv6ufoyadd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 11:58:52AM +0200, Simon Horman wrote:
> Add complete to DMA ops to allow DMAC implementation dependent
> handling of DMA completion.
>=20
> Also implement the operation for SDHI.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Codewise, I am all fine with this patch. There is one naming, however:

> +	void (*complete)(struct tmio_mmc_host *host);

I'd rather call it 'dataend'. For internal DMAC, it is the same. But for
SYS-DMAC there is difference between DATAEND and DMA_COMPLETE. This is
exactly the reason we have commit 52ad9a8e854ca1 ("mmc: tmio: ensure end
of DMA and SD access are in sync").

Basically, something like %s/complete/dataend/g would do it for me...


--u3fa7uv6ufoyadd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllFRDEACgkQFA3kzBSg
KbZHcA//X/bDO+ivuX3fMAylOLTqede/7WGrq6L2qKq+Uk0BNewIuxLbSB2u5s3F
RaPT5cuVCawp7u6BNujVADqOutXWrRQWpHwVEk2cEhEVb2MAQ0dI8GM7rwDpx9y7
i+vKWkl4JZlKAji0nyeQI9kbCZ2KBJDXEtyO8IPDlYGaMz0bPd95z6VLBgXFdMWa
OkTFj/1/vVHuR8k+cpu8ZUnCExIhhIvKDGm/Op4ObjDzsJdLbQPWXoZiRQfX+z7A
h85XN+kzscGUZSH/FNQnF9lfThAiTHrO7RBEBmqKsjciaIKQF0KGCOUK3Jns+zNz
TJc/ZanBRhIEckFjGvNxYpE7qPF1jzXrfovQ5D+d+kpkR4IwQKDl6kvv1DvouyZ/
ivD0eeHIHICQeJmHAU836NA/65TL0BPWRfhvZyqAM75jkwLltCuSXJNoLMm4ge1g
Gq3cZ3rX2qGDKt04Y0/dsPwYEziNjrggkyzoI687kYnKn7v9Wp+x0rEsoVGw4xk0
PWCZ+SF6neitdqRnbpNDSy9eXoyLNoUo7POlC5zORZE08t7/Muk3dclgBDJRL4yz
httZoe0qpmpgiH5f2M4lU6JuCX8eI4jenw3BOp7tcWnPjO/MisgF49cSLBovoEq6
dHzLtRQiGNqMTLc8zKMAwHIYesmZUsO/uCMhp1Vx1r/RGqoc/p0=
=109z
-----END PGP SIGNATURE-----

--u3fa7uv6ufoyadd4--
