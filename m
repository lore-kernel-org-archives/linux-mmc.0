From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V9 3/3] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Mon, 21 Jan 2019 11:44:32 +0100
Message-ID: <20190121104432.GE16756@ulmo>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:03:52AM -0800, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++=
++++--
>  drivers/mmc/host/sdhci.c       |   9 +++-
>  drivers/mmc/host/sdhci.h       |   2 +
>  4 files changed, 124 insertions(+), 5 deletions(-)

Looks good to me. It might be worth splitting off the SDHCI core changes
into a separate patch, but that's for Adrian and Ulf to decide. From a
Tegra point of view:

Acked-by: Thierry Reding <treding@nvidia.com>

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFopAACgkQ3SOs138+
s6Hxlg/9HITuwlKXqMJqQliyTbhELbKNJkPdJdBo4IDdYP3JLJIP4MmJfWsmEem2
vAvMWal7V7J+IOq9sTrwcGXhglYiqnIoD51RPZdfO252/8jF4yxd/M+GNLKkaxAF
EDQD6Jes6D7PQO2ff20Tu9Prhjy/YTfvEo2RhtGlhn59bSgYoD3RWyFgMv6bjZWX
Zs6zoTcXisWfqb4iHvLgFWptqi++EpCv09TouNxQpb1BSjJye5EztlPbqp0aWc3a
NfAog1bce3JeEfwgzrMVrjS7UHYtaxJxuW1ttSFvOkMy9I/Uf8oUcMpVaf6lYHNe
/dGpgJkqAzXtnvskDJOxYdV6BizdTI8EdEg73E2CZEHjqUz9VjZUn6Fy8t0KUgqH
+1VpMAnqNGvkrNFfBnbnjVDasT7V8dobsOpEZBvzfK4tUubpnyRhPV4+lW6YsS+x
IlSWMH/c1UaieE7tVAIQsDWP4KcSJzgBilRkqH/vFU+IF5w+EbNM0jfx2DtMASnh
EINeheFHdNtEivfOq1ohKUQNo7gT1XOfZCQvIGKZzVia41DIQKoOUnOdI/Iwi0JO
LvDwSE66C4gRYx4gwP7bKUJ3V8x8cS+dxJL2BEcBNszWkrt0mx6ojc47OXf+kRRU
ndD4n3+C15ewPbiwHfWA9mUFJwnPEI3RbzyB0SRYue0izYIQihU=
=vgaz
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
