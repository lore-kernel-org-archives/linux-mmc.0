From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Mon, 27 Aug 2018 12:08:26 +0200
Message-ID: <20180827100826.GA18542@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
> Hi all,
> This series implements support for HS400 signaling on Tegra210 and
> Tegra186. This includes programming the DQS trimmer values, implementing
> enhanced strobe and HS400 delay line calibration.
>=20
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>=20
> Changelog:
> v2:
> 	- Document in dt-bindings which controllers support HS400
> 	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
> 	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
> 	  value" commit message
> 	- Add spaces around << in tegra_sdhci_set_dqs_trim()
> 	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
> 	  message more detailed
> 	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
> 	- Add blank lines around if-else-block in
> 	  tegra_sdhci_hs400_enhanced_strobe()
> 	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
> 	- Make commit message of "mmc: tegra: Implement HS400 delay line
> 	  calibration" more detailed
>=20
> Aapo Vienamo (8):
>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>   mmc: tegra: Parse and program DQS trim value
>   mmc: tegra: Implement HS400 enhanced strobe
>   mmc: tegra: Implement HS400 delay line calibration
>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>   arm64: dts: tegra186: Enable HS400
>   arm64: dts: tegra210: Enable HS400
>=20
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>  drivers/mmc/host/sdhci-tegra.c                     | 84 ++++++++++++++++=
+++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)

Adrian,

any chance you could take a brief look at these? They are a prerequisite
for the 2-patch series ("[PATCH 0/2] Tegra SDHCI rerun pad calibration
periodically") that you already acked.

Thanks,
Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluDzZgACgkQ3SOs138+
s6H3hw/9HaeWCaPSJbgLBGq7COZn7QIwSefhS9Y6LS+y2WLqTHEG2BP2egIac67T
U8oUBCJXRQMUgoxVD2xppMS7jATTSo+DtMJ3kmIKoPfu0PNj42Cq55aOmZkxUlGc
N7PgbmFvrZm0/3jIRvJWUgQpplQsanqeFrY718rja9FwjEsArFmWhTg6QIEslfP6
+s18OrV3iYnj2ULr+DxIRua53LoGy2w90KhXvUmCLncTG9EZ49NyDlJB0cYWdVHX
x1yQDW6FHD6BgZGqjO8CqQ38H1fyLFzW66nkewSPvrJGTC7ySZS4HB/GQzkPher3
xb8ETt6LMgXV497wr/acnF65L3dnV85szaVCO9Xuqy7ugf8TmcpyvkA8mZ8FWrea
Nmhvuz1QSGIvGG5QytJxoOxe4Smmjuc4Zw3AidkLbaNMq280LVOkj0kkFaGbXHxm
rX6Q3fNm+jIu0gI0Pqojoj7RX9J3I/LeWC2yvSGZDZ0l39IbVR2aedDyRwFM/Jj7
YiCK7vkqMofsq5NZ2luhSFIb3YCDsXK/1hTfTzl/YB+u0Ff7KbwDa2ArD88FGAxu
5Om0Npyb0D2AYfnLBMHfQX3Lp3B1e3p1SmIXtJLG0U0BIqIccjlAO8SLD8j9xrrY
O3c0SxJNMijN6EJwi6J1TAbxttEGWTFsolHhLUL/R9o8GQPeegA=
=1iCJ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
