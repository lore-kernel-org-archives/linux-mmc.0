From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Mon, 27 Nov 2017 18:14:02 +0100
Message-ID: <20171127171401.o7ch26oot2au5oux@ninjato>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
 <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
 <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato>
 <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
 <20171122170815.o3o5umayra7kbdg3@ninjato>
 <CAPDyKFpuiurgT5Zwo--EcaWOjZOdmSYotHrwH=c-byq3nkaxYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2l3qhx34dcwof3c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753719AbdK0ROD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Nov 2017 12:14:03 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpuiurgT5Zwo--EcaWOjZOdmSYotHrwH=c-byq3nkaxYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--h2l3qhx34dcwof3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Another try:
> >
> >> # core
> >> obj-$(CONFIG_MMC_TMIO_CORE)           +=3D tmio_mmc_core.o
> >> # TMIO-builtin MMC
> >> obj-$(CONFIG_MMC_TMIO)                +=3D tmio_mmc_original.o
> >> # Reneses
> >> obj-$(CONFIG_MMC_SDHI)                +=3D tmio_mmc_sdhi_core.o
> >> # UniPhier
> >> obj-$(CONFIG_MMC_UNIPHIER)            +=3D tmio_mmc_uniphier.o
> >
> > I left the Kconfig symbols for easier updating and concentrated on the
> > filenames for now.
> >
>=20
> Looks good to me!

Yamada-san?


--h2l3qhx34dcwof3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocR9kACgkQFA3kzBSg
KbbuCA//fDEG8oEbayDZ/6bMeUxrR3glZrwF3sGSQDha2u0WYhcZ+2XIrusAe/jx
7seSux0IeqSS2awCvW4WYgkBQkNuiIdROo8vMb7SoFJcKL9Ms2Lyqh8jBHOO6f1x
DrxBdqwDuopK9FdASJt3JnbbdYoW4NY22eNSmNvFcBXclfVBKQgCBy6w2rd9QJx6
UNIiNbLT+0rONfTd4wg0tWU/2FSkxubrFu2tol1AFas0WHQ8wyV+viLQL5Zl1qZ9
G8Ucw531JhhzANEUGA0rRplz3kuQwGmHHeS+FdRZ/Rg4GZUyJVQxUIKj2HO2ojTN
aAqPRXcgIisQ62E3foOjf+G9vLq1FI+lBvtrP6utj6AJEa3wRlD4JrJj06CxtAHk
6NX/Or3HLeDltknZKW0gLS0T9K9k+abvLEY38kkYiBQ5k+b3o14uSG0nfW+e6Y28
g5AXruT3gODNOXreM5YBD/KmBeCRNmlyzgVwYf+VvU3JMb/AHHMNWfOPczwnO4gp
rY+rZnYAs+f8R4fql19ERYgX3X9dWQa5XcVugp4F7+pFQSFdvctPMdCwp6nfoHcq
c30Tq6PG+i8cQmLicC69OzT5sOef9iO/aw5xhIjwiTxPWbyVcYM5D1NBIBtYV/vD
xrg60tkLAx5DhCVeireOHCjgIDRVj2m2CBQSFoHOpJmUWXFLRQ0=
=VUG7
-----END PGP SIGNATURE-----

--h2l3qhx34dcwof3c--
