From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-tegra: use generic
 sdhci_set_bus_width()
Date: Thu, 17 Aug 2017 13:18:16 +0200
Message-ID: <20170817111816.GD18789@ulmo>
References: <cover.1502740497.git.mirq-linux@rere.qmqm.pl>
 <7d6cf1b81c67e3448edbab526e36bfdca737fc45.1502740497.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7d6cf1b81c67e3448edbab526e36bfdca737fc45.1502740497.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:00:24PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Now that sdhci_set_bus_width() supports 8-bit bus widths based on the
> MMC_CAP_8_BIT_DATA capability flag, replace the tegra version with the
> generic sdhci version.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)

Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVe3gACgkQ3SOs138+
s6FCmQ//fSo/65w1dhxny53EQ1hT3jAPWeQpMaVyzeK79Ew4uE5BLlIMngl98hQ2
eDbLsanhLgpkGpo8kx9WrCEVtjD9m++/mhLs0dZfTvjFjnxpS2/EkEDRF6H97gGZ
AqW+BHStRypGdgc8R9aH4DHB7JzXxPLjptzAN3AdkWoFmJyQCk6sDHKD+6aklal7
vC2a+8MFqASPTYQmArow5dyFQNV3VbSJ1InnyGIfIcQSxPZ8kYfwox1Skcip16cL
HX+9iRYcRALIeLMcZnUDNitNeLr4VfWolHzx2f7SCB9RuMM1SHCfhxYohWLn8zoU
gTyaJc1pZSRaQXrk1C8wXDj6HJiEOIyfri8ABbnVe5GznsoOZiv0MnzwQwLxpPJy
b0l/9doQ6/PvDeEHl2K9qeEfnu9Au7gK/IrA5BLdJHqO/43mWvlyMKqbRrC2YkGx
V1pymKJeoSiOEuDRJCUcY8bISFyBtYiRiRvv+Cy6314A8jzZPPRDBkUgLYO3Nfz6
IDIOuXZYWcSVTc29EsePf22vFnTskwwd5Poycw3/wOA+wqpcXY+oQCxDo2356rwL
AosgYNLo2+SBtVhk6OssFg3i2Wd8H9vObIknMBIzpFuQVkyuboKvimoqYOWukn2A
u2k4qnPiJSvGBMS3qINsCKg1xirlR8VWdiSOPiHKa8ERJZpxyjo=
=GPKi
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
