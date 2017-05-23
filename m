From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas-sdhi: export renesas_sdhi_probe
Date: Tue, 23 May 2017 10:00:01 +0200
Message-ID: <20170523080001.zmeghtqn7tnwgofd@ninjato>
References: <20170522133339.798278-1-arnd@arndb.de>
 <CAPDyKFoCVyL1D9yUgOXO1ETMTEYdFER7WLdixiRedtXs_7238g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73hdmrzngmhlphyw"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:32948 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759874AbdEWIAD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 May 2017 04:00:03 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoCVyL1D9yUgOXO1ETMTEYdFER7WLdixiRedtXs_7238g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--73hdmrzngmhlphyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 05:51:57PM +0200, Ulf Hansson wrote:
> On 22 May 2017 at 15:33, Arnd Bergmann <arnd@arndb.de> wrote:
> > We now build the sdhi driver in separate modules, which means we
> > have to export the symbols that are called from another module:
> >
> > ERROR: "renesas_sdhi_remove" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko=
] undefined!
> > ERROR: "renesas_sdhi_probe" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko]=
 undefined!
> >
> > Fixes: 94418768f765 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac mai=
n module file")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Thanks, applied for next!

Wow, that was fast :) FWIW:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, Arnd!


--73hdmrzngmhlphyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkj6/0ACgkQFA3kzBSg
KbYujA//dbB08U6gPGe/32VktOs4XSHStJmbXnMKG32M5Y5QRLnN/2JEyU3o2I++
7HYCil0eIKImPuQvYL4n3Q6CvNjQomCPP4w1RHMxFSFD1NTZ6OVsp80XzNamsuyO
EcYEHUnz1k5FwG8P1GQ1052TzoVuRypZ7B7RzzeV9jAfYTxYA2qCl7elXRaQT1Ue
RuALtVGu4BJRWi2uuPjKOBCdO6sNnmEZXlgGwSgRb6HjIhREosze9OLR8fOC5d5D
gqFUF1WIOSg1HcBrHHuFz6onT0oOpJZuM4bYWrPLiWIOA4DR2Yc3of1U+ltWa4Js
nydjdJSqkAKsSyXvnZsrclL8knnTdk11O5kTWjPtxwWUvJ0Svj8n5Du5jUSmelF/
QOZMHEXaW1jwE1tXn8I3WQW2vWoBJGz3r21rl/j5P5gwg6pTPvZdsMjfEfcb4nUR
znlJVz7Mo+7jeZ+SBQKkFdlWlNBRGJm5PFBFxrRW3cIxMAxbxm2P7IDp4A0ILaKD
iAtXyWhSZJWJNKgSh4arFzJWaNMU44HJRxtSjPSWTnRIDWpjD7gjHVWnVQV3Xawh
Ha06rr+n0uIo8o9SW7Mm1sLvNvw2O5ZpoaQPJaKHNdf9DuRnYw+nu5T28ZT1GpEt
z27/uLfvJNuqTkV8gjP7ktUqI8EkKg+sD8U0BwnbDRbWz10d9KE=
=Urfr
-----END PGP SIGNATURE-----

--73hdmrzngmhlphyw--
