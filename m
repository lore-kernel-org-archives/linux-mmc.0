From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] mmc: tmio: move MFD variant reset to a platform
 hook
Date: Mon, 15 Oct 2018 13:32:10 +0200
Message-ID: <20181015113210.bmrn5jxfhh43yl5v@ninjato>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
 <1539143492-32605-2-git-send-email-yamada.masahiro@socionext.com>
 <20181014222757.GB3260@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3tih2gcnk2ua3tyl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181014222757.GB3260@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--3tih2gcnk2ua3tyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:27:58AM +0200, Wolfram Sang wrote:
> On Wed, Oct 10, 2018 at 12:51:31PM +0900, Masahiro Yamada wrote:
> > CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
> >=20
> > Add a new hook host->reset() for performing a platform-specific
> > reset sequence, and move CTL_RESET_SDIO over there.
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions. I
pulled the SD card out during transfer to ensure the reset function will
surely be called.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--3tih2gcnk2ua3tyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEerYACgkQFA3kzBSg
KbYc9RAApdABe3wiKFrfOU4fkWeHcMNIInga/R+oYrKZJS1zEWwGN+swrNlEhPOk
iQ6FR3VC+HWJG6ExLehDUKyQSl5YFeBKNWN9+T4jwZAZ6uQsrEBMjesjxWhuh6GJ
xSFS875l3CezsDruRS57wHLI0G5VBIvJZBMg/pWa0BwZ5tkOiEwB3Y7+ZXzCB/Dx
4aTURpq/TfotoF9XlLpR0kaQiR9WEbtrQk8GAJgD6lfnAJfOMDr+h605ojG/oeej
ouv6m/1uOm7QpM5i3+vh7QCC8BkALl5nH+EiLJ6BuJwzSpcPnd4/rk17bOEwwwAz
ivEcosBYHzFqV7nVS4TYYwhAKhJXQENxcU7Hirwxrrt2ktZVsKkrD9AraWd96Pde
mq+AE3USSbLVjHERA6kCccMBW6wvoxUMyfW59qjpBGWmZEqkFfojkCNT+2EwD9ke
5UWFj3/H8xiv66YfX6sTfPHWEIYgcq5ML8u2gonkiN7A6/qkY2DZCNyQyxh29ACo
Vd6zvoKo07RzRfLMYZiFsaaUs1ctzPgMqnsLIor3QCfJ5E6tEo6pNCjN1Dq/AxuU
H07+8pHKlYdmp/6sztqRTPmUXPSiqmg4a8C9wk3V8AuZQXAMYAyTCOjydExZAfSQ
1A9UWN4IWjinaBx0EDfrU1iWVo0FoNkWhdusPHnfyz1FshQrbF4=
=2CYy
-----END PGP SIGNATURE-----

--3tih2gcnk2ua3tyl--
