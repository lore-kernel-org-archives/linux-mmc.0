From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] mmc: core: Allow building PWRSEQ_SD8787 with
 LIBERTAS_SDIO
Date: Sun, 4 Nov 2018 12:27:48 +0100
Message-ID: <20181104112748.GA23864@amd>
References: <20180924085632.448693-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924085632.448693-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-24 10:56:32, Lubomir Rintel wrote:
> The sd8686 "libertas" SDIO adapter's power is controlled with WLAN_RST
> and WLAN_PD pins -- pretty much the same way as sd8787. Allow building
> the power sequencing driver along with the libertas Wi-Fi driver.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve17QACgkQMOfwapXb+vKWNgCeMzaGv4KnWlTqZ6vX2L3EPoUm
FLcAniiholgipOF0kEebW1kfEzuvIps8
=G8ky
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
