From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Wed, 22 Nov 2017 08:59:38 +0100
Message-ID: <20171122075937.knc2soqu5axdufzy@ninjato>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
 <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
 <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato>
 <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfa7ghjlplwohzr6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57010 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdKVH7k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Nov 2017 02:59:40 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--nfa7ghjlplwohzr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If we use "tmio_mmc" prefix (like "dw_mmc"),
>=20
> # core
> obj-$(CONFIG_MMC_TMIO)          +=3D tmio_mmc.o
> # TMIO-builtin MMC
> obj-$(CONFIG_MMC_TMIO_TMIO)     +=3D tmio_mmc_tmio.o
> # Reneses
> obj-$(CONFIG_MMC_TMIO_SDHI)     +=3D tmio_mmc_sdhi.o
> # UniPhier
> obj-$(CONFIG_MMC_TMIO_UNIPHIER) +=3D tmio_mmc_uniphier.o
>=20
>=20
> tmio_mmc_tmio.o  is a crazy name, but the syntax is clear.
>=20
> The first "tmio_mmc"  means the IP name
> (since we decide this is the right name)
>=20
> The second "tmio" is the platform name
> the comes from the TMIO MFD.

Also fine with me.


--nfa7ghjlplwohzr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloVLmUACgkQFA3kzBSg
KbYzdQ//bYQIoocztY1SQsKldVAuJs1Evkq0jkt304ruYFnhGbu2vLwOrPsAYkRj
cvpF+ZyHmZby/AtN92wmSaZ8Br1/F1u0DURvJNJpT2/LtpF1pWYtTZOprpp+iUgq
ohwpXUbpEPig5t5i1wN4GBdWQAEX8vU9jh9drLO/cDZlIz85BgVX8tfRKCfdKcb2
DdQ7h85XqEQnXWxiWpouMnskMgNy2PXKqfQPCCoLv88q0UYvlWCP85cpMrHLg56F
bN0bM5H6IBQQTMDb2HpGg3ZTlyBkWe3JvrhlAcuU/zmjZsd2jfEONvMXjzkYx/o7
ei3p8qejI+8fZSqC6R8ek/XzMWkUuck8c14lyNyx2U9gKEuXFdOiuAgdujO4mdAc
oTM0wjRy6vCVbOuGgh1XJ5Jh7mEmlpY51GrkMuzq/mPX1ByZOZ6ESobXgo9ul+v1
9Rdf5tR34X6/FRJK0vhn1P4ORSxRN05NarVDuqVDq57gZ40GTrZ6DhbxGUgVDlkp
y4RpOMpWm7dnkNTf8UdB+Ki0MZugTP8Ib9w46VA0RwMdSRHkEm0hPs41ejSIVi8I
c3l+ztD+DeVt4lE+FAkgEVthav0GU6hIw8WNiOF2NPIuBYwaSNEUuqMfeZ4Ijq/6
6qimSFjx+i3w7hRkxLr0pdQKm7skNNdfm5c7EtHTmnNeD9mfxhA=
=HizX
-----END PGP SIGNATURE-----

--nfa7ghjlplwohzr6--
