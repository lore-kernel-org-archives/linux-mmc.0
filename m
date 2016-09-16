From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 07/11] ARM: dts: alt: Enable UHS-I SDR-50 and SDR-104
Date: Fri, 16 Sep 2016 12:27:10 +0200
Message-ID: <20160916102710.GJ1411@katana>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-8-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473764228-24768-8-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2016 at 12:57:04PM +0200, Simon Horman wrote:
> Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,1}.
> And the sd-uhs-sdr104 property to SDHI0.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

If you drop sdr104 here for now as well:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX28j+AAoJEBQN5MwUoCm2/XwP/1xS9t8OQyN0PlzRiBT+teEv
mFcOmbZmGYg5p1brMCfmm7aCzNjj1uogE9rUFURXDrxpDAWxarEzJWxEJaGBA6lZ
RQLHYbYfSVqL9kqGuPuQ1vs4G8pi6ErLi8+wKdNKX4D3vIMR/QXvcjZQQLfwUAIU
FJNgVdmvCkKCyfJ2lmfxDzf73AlUSxWpwOK23ySwdOUymHeGaO0wXqaWPfBzmvLn
1BssSXtwRV+3RbgqjxouHrM1rJ4AyQP+Xb7fZNiFo5BNVZUdb1pzWQyTtxkHyfCQ
pMoYt79idxRU61F37y00MOrBodOOPqvQx5k+C2iKoGDsVhEvFICShp8aMMZFd6kH
V7k4twmUh9ikFIyWTWSzOejjKbrjmnyUF95t0S7LdHPtWQaDwjnG57FxjqH5B0WG
DheAdhEWw/HHOGzAZhPUR/MAc9KKZ1ztBn/QdVr2VmGuk212cPJGrR6zkJLXsfYJ
+QB9fV/yPpdb6uupQxSAIKSERWMc9F40RGhGK6MWttHdiJTOvnUi4FsvGuRZ8XiA
OeuzKu3rfaMHto54uuP03L/4IXz8GBJBj/CBBVqHVatxmKyX9rDMD+comN55SIla
03jht9hNb+EJfKCww32C+TLlvwSMllC+aAzcaxd7A1J/8AsvQIb8pCQxEMCvTBh0
/pkAvqOJ7Wwj6nUdXRje
=UkfD
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--
