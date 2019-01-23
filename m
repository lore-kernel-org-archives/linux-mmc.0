From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V10 4/4] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Wed, 23 Jan 2019 10:20:12 +0100
Message-ID: <20190123092012.GC24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
 <1548186993-6229-4-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548186993-6229-4-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:33AM -0800, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
> 	into seperate patch=20
>=20
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 114 insertions(+), 4 deletions(-)

Sowjanya,

it's good practice to collect the various tags that you've received on
patches when resending. I had already acked patches 1 and 3 of v9, so
you should've added the Acked-by for at least this patch 4/4 because it
is unchanged from v9. The Acked-by on patch 1 was also valid because you
only moved the documentation, but it is otherwise unchanged.

No worries, though, just something to keep in mind when you send v11
with the typofix that Adrian pointed out.

Acked-by: Thierry Reding <treding@nvidia.com>

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMcwACgkQ3SOs138+
s6HjCg/7BEzZlYzmxabweiblsUj1bl1Cab3v45QDeCgs88YXI1MKXY69Z5BL483E
2dk680JImRyLxh3elk838WgLAxn/fNRAO284BXKy0kB66bLZBpUXc96lSoWjpPKD
+hLZmy85NLMuv966QGLxwMbKeIFgsWkPIH3VJ1noixtrKNNFiVjXAUdBqyj4sdXY
8YigDcSMyL6jp+oourgLPuTUYPkYCb9h+rYrJe/tjhqTXRaXQ9VMv7NE97WYjjXA
yf9m9Bn4weOnLBClVd2NEQQiy2YAQbNM/EL8I01vOTqZRU+/i4/PwhQo9s+5zAEk
Mqz+NqkyBnFlhgRLkXG+Xqoip49rraP1h6JgiqUJlDYbI5VAuEK+3D06Nkid8sdK
rwf7esBXV4z3m9iZ5O/3mEmdRrekCqcOn6QTFF1kR8U6D0sSl4heQyiAYTRBUqyv
TysZgJ5F3l+s6JPsIL8N2jD+O3z6bL5sPK1ieUHjQ935QFdVyc8iSrpYA7uWSZkA
gRo/AxlXLQ/xNFeGThZPDouOwwfGlcOv+DqsIOk3Rju8jdKsUil/jqwkI/8UDWsG
aqE1cY9qZqoJhWRnbJ/JwXkUrhW8ZQUia87xCg9zOXhCVY/Nbe5FpSsqOIelxlib
IX2UrsQatNWBnMqex421w6wWqbRGLvs12R3is8sZruv3iMDasCo=
=hvy0
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
