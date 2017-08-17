From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] mmc: sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
Date: Thu, 17 Aug 2017 13:17:54 +0200
Message-ID: <20170817111754.GC18789@ulmo>
References: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
 <48d72c32067a8e4ae50c77ee9cc5c077bb2809ae.1502740497.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48d72c32067a8e4ae50c77ee9cc5c077bb2809ae.1502740497.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:00:24PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Hosts supporting 8-bit bus are marked accordingly. If MMC_CAP_8_BIT_DATA
> is not among host capabilities, 8BITBUS bit will never be set and it
> is not cleared in case some non-SDHCI3 host uses it for something else.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVe2IACgkQ3SOs138+
s6HcYg//eokHrNZ+jI6FGkdTbZq1F83/BTY+E/LosRaBwmcfYjzHy14yMd8pKxR/
WiIIELb+8h4+BirCPan2UMRtVR4Z223CC/mRIDIHX9eS6BrVQJm9KdTx9YGuH/Eb
S31nSr1jRtoehpexykScYNhL2THulO385j3Xze5hgHyPR+i37s3oONj0Ec5qzORB
eZmDrWTKsE07S350U2vqEwGwGMESahDXwUa4lpxpXEfeY3w51nvQn7jeRNC1M1aj
dH3NZaNykb3Us+DQO13bQCXkByINg2Fc8PYiKQuMOG9Y2jp+oMVZFPY002OadcXg
aVmG5QldRq+Nlm7XUwLLlcZ5x+4mtc7Xxo98p2u1VgMOWe5CaGsoVeRlIqCluJ36
dx385HDjUkLkC6I/R7s8M26/bZH7GOp22SpseKkhQyZPpNsoHtiB4bej+xTSexGi
1kZG4WzicJ7n7xTM0AeD9VWtIDDXCF27rj6PKsRhYcbxoWBsDX+Od8m3xAFqa+o/
YNDa7aQGDd2ipexb4sb9WvgFQo7bhnZCenMejh09TBDCcLMx9LuDBFKtuwDOPZO+
6Ss7/xxhRGt52dFbGThHa8RjKimhjNOHZwaiHzm0hqXc5hYI6NqYwq+fU7e4u2wq
3dLfUr7iH/Qc8PpHoT5UDt9NZiDfZj7JBzPi2CB4k/Y2eLQAQn0=
=5bRE
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
