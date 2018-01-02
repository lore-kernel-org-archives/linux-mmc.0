From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 10/22] mmc: tmio: support IP-builtin card detection
 logic
Date: Tue, 2 Jan 2018 13:58:38 +0100
Message-ID: <20180102125838.ikrw7tw7njk4pcqk@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftqswrhthbutkg2e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--ftqswrhthbutkg2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:45AM +0900, Masahiro Yamada wrote:
> A card detect GPIO is set up only for platforms with "cd-gpios"
> DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
> core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
> if ctx->cd_gpio is unset.
>=20
> The bit 5 of the status register provides the current signal level
> of the CD line.  Allow to use it if the GPIO is unused.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

As mentioned before (sorry, I lost this thread :( ), I like the
refactoring to select in probe() which function to call depending on
GPIO usage or not. If you like, we can do the same for read_only, too.

Thanks!


--ftqswrhthbutkg2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpLgf4ACgkQFA3kzBSg
KbbMEw/8DK8hfB3NUOun6cgZHwcC33xvWTxUqqTS3qysYwTwH4j0ibfyuxRxrZLU
El87XIObB4kk1tvy6/YxksOmF/p3/aTX1/eRICnszu18h2wuyDwfi66BqU4X85ql
d+1RaAUGYi6WyTlv72ANQ6FvDz7O4J6adiErAXtRqQP+4aGoVu/NnFiiubC8v13t
0wvOSzbdQO3VgFLtoYDkReShNBQfTj76B4v+fN3CY6AxNh/xyzVxAhaJHxbFpGMx
zHhIl6jVR7xfzeGICHdaLcLYL/zAqzqlsVD56GO5IKx8OdZh2vbXxJ0hpITuOPDW
pflZu2fxxLXL9MuEpXDEYBVXpNRSh8eMeFtjoULwGmHF8Z+ZdWSfTUguYPTk3Tgk
m/VeGQ7G6tUrClK+kC5sLxyBRISHOUAxLR8xheuTuowdjf+cdaIwyOoZTt4B+n2T
d220InTQLWVlR39LP94ROyepFL5jueIbrEmrkJQq326FZw44nTzqers76TOZlrPO
X/WKcAQIzzjgCh9s4ExDKfouKelxyo5DtUqy6Idce9X4I41CBT9z/npQRjQARp98
I5hTToTFuTZmpOPEGmNd8Voai3/ceTjdpBimTflo45d8YZ4tWqaJP7wSv2u77Pti
ex7z5mV29L6AQLJG+rolT20ifz9eiUp/9E0aqsBdHMYrbUPqYt0=
=Rhf5
-----END PGP SIGNATURE-----

--ftqswrhthbutkg2e--
