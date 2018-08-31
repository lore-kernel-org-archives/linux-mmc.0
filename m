From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Fri, 31 Aug 2018 16:02:21 +0200
Message-ID: <20180831140221.GC7926@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7qSK/uQB79J36Y4o
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

For patches 1-4:

Acked-by: Thierry Reding <treding@nvidia.com>

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSm0ACgkQ3SOs138+
s6G42w/9FFECWR0d1VfPjK22NxVRpLNi0S8yD9l63nPrfpgape2cpCFscZPIs6m/
DsbobOqn/5MDiRDeG5NAcYtYyjeiedCXDFcP42q3qw2HRuxtHew9MoX0JAa0VhtO
dCGy1uueuOjmoPJNh2S3JWNbCrRipyXmRPbb4sAGWPoXEh5+qqxfbC8A+NFXwfTZ
5VgdnJJOuIAWpw60iV9Lpn+RroIOUCY3mQL0rbGcctT6afWtGdzCh5JHQosCQhIg
Ijc2a2g97MyUjhP64BSKrrQ1XueVoC3tvrz8sj7JUo6iwZwscNMuEAny+V5omCkh
7BgPTlDpH2bJ+7tgRjjulvvuzNsAmOWxCojTpPwOBpM32GdL+BWPTjYPYKh7o4H9
0Fjn7G2Oq1HZPgxpGwLgn9XYUhCt0kE2XYgRdaObGiLBlUH04ubrtfHiYC2yo60P
Pq/b8FATrwe7twgOn7vDTQABNZuJ8lkN3F1iFgkfRvymoR1K6hPb4RWiMijffH8i
vSXushblghKfZRqUiARC6g0hSVnMd/A9T87aFPcymumlgWGtt/mR7MoYP89fgT7W
X7asGvLlEWMgQGimnJ9shxAEEzVRWsF09/u1PmM3i2g7BuhuRQhBR9XHxmQH/kMy
2mmo+SmTM4l9zQdtJLY3hP6Vt5LdqLYNuPUpMSigiAa8EPsaQ5w=
=/mTD
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
