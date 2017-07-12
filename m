From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] mmc: tmio-mmc: fix bad pointer math
Date: Wed, 12 Jul 2017 17:51:10 +0200
Message-ID: <20170712155110.5xxc37onihkq72da@ninjato>
References: <20170712154001.75712-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gokxf7m6pvdacojx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753169AbdGLPvM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jul 2017 11:51:12 -0400
Content-Disposition: inline
In-Reply-To: <20170712154001.75712-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dan Carpenter <dan.carpenter@oracle.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--gokxf7m6pvdacojx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 08:40:01AM -0700, Chris Brandt wrote:
> The existing code gives an incorrect pointer value.
> The buffer pointer 'buf' was of type unsigned short *, and 'count' was a
> number in bytes. A cast of buf should have been used.
>=20
> However, instead of casting, just change the code to use u32 pointers.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 8185e51f358a: ("mmc: tmio-mmc: add support for 32bit data port")
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--gokxf7m6pvdacojx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllmRW4ACgkQFA3kzBSg
KbYTBA//c3VH5714m0j9ZOvblWZMR5s+3HjEwLw1KmyPp7zvTmYDufdhUWPmunuL
NFHTOrKRwk0zUggjNdPN5wEwr5Jypiwk7uTuU2cTQTfuc6QVaE7CLD+ZwUs2j+/Z
BIMKb4uHs0S0jLVi9zh4a/RVm4mLXMmidSitSmFrzbVKD9J+fv/Bj3UhL9llDZqq
oQc5/erxjESdq/BHjZZpV3fegNjMA3Cz8/zDqzOdX8AVaRL0GZhdOODaw3qIGdH4
ggeenJr4tFOmGsC2PIloDeUCgaJTZI088WGsjRBSsx5WqP/NEB6yvcfKpNOtfo+3
wSloY+AW/x9I8UCNnFSI4+QfNR7q8/jl43ZkvSD047hbEfE3MOVir61OZltfNs7z
UzyK+6YkYbMp59mPOL+9moSOlAYYwcpsHYpICoMN2AA8ly+i+xl+CXpJ6DqhY+x0
9RfVVYORElnRcUueOwNCtOt5DDJMRgOzLv9cSUtYARatG72QX3aajNkdvFtoAkQN
VHwRHlRUkBuKrmI8wv4HszAA8kTU8ysBxIRZJsyhIEdQ2iTh19RfAXJrp90qMf3k
yKlGTHJJAP2+tmk473CgHOLUqjiL3I4lTIwJByOFpOAyDBJC82SHVP5ycQhZpfJl
VJOsbaY9wplzw051yhbok9naW6926OfUPrE35Ny8CFfLWy9Usrg=
=dTdv
-----END PGP SIGNATURE-----

--gokxf7m6pvdacojx--
