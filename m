From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] mmc: renesas_sdhi: clean-up and fix CONFIG stuff for
 renesas_sdhi
Date: Wed, 8 Nov 2017 18:58:00 +0100
Message-ID: <20171108175800.rd36g5mrldzqdmpe@ninjato>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g2paxnjzyb7uyjcy"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33568 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbdKHR6C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Nov 2017 12:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--g2paxnjzyb7uyjcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:57:20PM +0900, Masahiro Yamada wrote:

Ulf, Yamada-san:

All of Yamada-san's patches look good from a glimpse. However, I am
currently swamped with work and will probably need 1-2 weeks for review.
I am sorry about that! However, since 4.16 is far away enough, I don't
think this will cause a miss for the next merge window. I'll try to
review it earlier but please bear with me.

>=20
>=20
>=20
> Masahiro Yamada (2):
>   mmc: renesas_sdhi: consilidate DMAC CONFIG options
>   mmc: renesas_shci: remove wrong depends on to enable compile test
>=20
>  drivers/mmc/host/Kconfig  | 5 ++---
>  drivers/mmc/host/Makefile | 8 ++------
>  2 files changed, 4 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--g2paxnjzyb7uyjcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloDRagACgkQFA3kzBSg
KbZe3w/+MBR4ph4k0nh3+mRP7ho30un97c553yTA9OXolKMCJQoYLDPGtbUUyJge
N6NJHxE4w2MWq3veheBsIC816kuTXzpIWQzZJM/HODdUG/ks8vT5fMX5Ko7hK784
wbH3j8Q9j8pUOUnPMogn7wxMMLRgVYrBZYJgaOFz+DOvo6KXMugXFqR8ltNeaa5L
jnrAukhE9+zzko56WpAcO4/OnHZ0nlBLHRhAr8jYhgfnYOGl4vvzQNvRbOhhZkhM
fbH0c2j5h5OxgJZRpxg6VwO+Z3xnbPeJzsgxFW9JuoST4AGQ4gyh2lHk0Ap2DKg5
mfA6WE4pPN/bwf5+yd/+pE6DQuGiY1Ot+b5n3gTbeYhnTBk/wzovrH26HhdwquBT
xa0Btje1GodSM2t2qfXLYlm3Fc+kAGsg/KEV8SVqXURQtbCbFk7icVetrs4GBDLk
6L9PBaFqmKiCT/qnqJGwfCj/YJrDeHoFn790vpGuaK3gG/IS9jBEt5ZNjt6MRjbW
m/k2KwSwVWy9RjQPTxp5V6F4taQJRgTOaSURE1COJkUw/WEyrk4fr9aVsobYMCkl
koCtwPeadgI4bFze5j9jlQAMJnAmZfLHc5ImGkBW4/GABEUsF8Hjyt1HWtViWVB1
GpE7NZy18jwTQfPUn3+QnpQzaloHUPyZmbJmPkEj1WuK3BAH0gY=
=DRVa
-----END PGP SIGNATURE-----

--g2paxnjzyb7uyjcy--
