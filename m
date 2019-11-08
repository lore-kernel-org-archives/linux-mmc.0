From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
Date: Fri, 8 Nov 2019 21:53:11 +0100
Message-ID: <20191108205311.GD23750@amd>
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-11-08 17:09:00, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>=20
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Pavel Machek <pavel@denx.de>

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXcXVtwAKCRAw5/Bqldv6
8i60AJ9+HnW7KWLQ4Gzd+50rSbaEhAlNzQCgvmtOhTJcKVQRoI00YK/ZOpkBmjg=
=+1yy
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
