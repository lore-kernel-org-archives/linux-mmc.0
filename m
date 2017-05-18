From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/6] mmc: renesas-sdhi: refactor DMA support
Date: Thu, 18 May 2017 22:14:36 +0200
Message-ID: <20170518201436.umh3d22rf25cqh2b@ninjato>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="icrln2wct4gezue2"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org


--icrln2wct4gezue2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 11:25:24AM +0200, Simon Horman wrote:
> Hi Wolfram, Hi Ulf, Hi Arnd, Hi all,
>=20
> the intention of this patch-set is to refactor the DMA support in
> the Renesas SDHI driver in order to make it easier to add support
> for using the SDHI hardware with different DMA implementations.
>=20
> This is based on earlier work, posted as "[PATCH/RFC v3 0/6] mmc:
> renesas_sdhi: add R-Car Gen-3 DMA support". It attempts to implement
> the reworking of the driver proposed by Arnd[1] in his review of that
> patch-set.
>=20
> [1] http://www.spinics.net/lists/linux-mmc/msg38004.html
>=20
> Unlike that patch-set this patch-set does not add support for
> R-Car Gen-3 DMA. Rather it focuses on refactoring the code.
>=20
> Changes between RFC and v2:
>=20
> * Drop filenames from comment at top of source
> * Consistently check for if (host->dma_ops) before using dma_ops.
>=20
>=20
> Simon Horman (6):
>   mmc: tmio: drop filenames from comment at top of source
>   mmc: renesas-sdhi, tmio: make dma more modular
>   mmc: tmio: rename tmio_mmc_{pio =3D> core}.c
>   mmc: renesas-sdhi: rename tmio_mmc_dma.c =3D> renesas_sdhi_sys_dmac.c
>   mmc: renesas-sdhi: rename sh_mobile_sdhi.c =3D> renesas_sdhi_core.c
>   mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file

Thanks Simon for this series! The file layout looks in deed much better
now. And some light testing on my Lager didn't show any regressions. I
have only minor comments which do not have anything to do with the code,
so already here:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

The comments:

* MAINTAINERS file needs updating because of the new filenames
* I'd prefer the _GPL variant of EXPORT_SYMBOL unless we have a reason
  to not use it?
* maybe this is also a good time to update the Renesas copyrights in
  file headers?
* checkpatch reports some whitespace errors on patch 6. I assume they
  were already there in the code you moved around. Still, it might be
  a nice occasion to fix those?

Thanks again, nice work!

   Wolfram


--icrln2wct4gezue2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkeAKcACgkQFA3kzBSg
KbZHzg//e7NN3rmB3CJlBXswtI+6tXwbtzJlKoJGDZiVEqrfhMarEnUcOGWwwcvi
Yy2lV+ffLsC5cSjLc33/8b8C9J5DttPI6PFuNR+eJ6E4EM4PS1gfIym+ym3zJcKJ
Pn3aft3cO/4KeBTJq2lZcMoJidNy4Ma0u3lRdovGZ70fqHybmJKcyk6QJOesFE5Z
f5IFw7dbkn4ovxgvVuc/UOtyw6G6sXOT7fuLPEbEjI8pyGGEiNHSaI6H/fqmQ8KK
wq13ZH3fUIrljLnBtEdEIufFDOiZbj+lFL2nvjz/95K05fdfip5235qZ6/QKLFKm
pCTb60shCzEm4aXAAlIwOo12C/SoDdzX1yqGq8aRgzqlAnsRGjtJ8RmYJWFY1pDf
Nz5ADaW64tErsjRZG7uM3YU/HnU4YAtm1KHTEDBaUhP5Bh6e+g5OGbKW+dWyM2HN
UjycjtchbGK4Erbbt6bzMKSWnQckPsS6U7NFIKUZZgoUpGOMvHrsGT+aVf6/f6Ai
Sg9AuTK5ZGeEJKWXC5rtJZOe+emfbNsFM+E3h7PRslfLmrJti0W4ssP7/2mZlSOp
PkzCVa3Ppr3nf6uhoqndSv7s2Hp7P2dWdmD31qrABXYPGAq+Gnja1jbeQSBBMJaa
rT9X+nNBYzsWFq5XwHUw21SXgVqxTCLOfNT+Nh7fQwOAzXERxbg=
=OBDc
-----END PGP SIGNATURE-----

--icrln2wct4gezue2--
