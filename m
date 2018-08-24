From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Fri, 24 Aug 2018 11:11:03 +0200
Message-ID: <20180824091103.GA9100@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--RnlQjJ0d97Da+TV1
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

Ulf, Adrian,

Aapo just reminded me of this small series that also has a dependency on
the UHS signalling series posted earlier. I think it's easiest if I just
stash this on top of the existing branch that I have and send this along
with the rest as part of a pull request early after v4.19-rc1.

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt/y6QACgkQ3SOs138+
s6Geow/8CNBjRVUWrjNn8USykHyGclhdyCpr/77F6uuL3MmDMAVZGt1U7o0RTDYb
T55DEJ+4e1uoaWjSbd+DnPQ+IHKON+sSykG0rrGJvQxnEWEYZjnzfKkmfpnQZPna
R13JQlTVtRCa4/QYBJUMu1Do9e4kCgrA5Kd8h1cRTrAerQkJXWX6mELxnYx8Bk6R
zYefZ7pPxjQCoRLD3sMiLLsd+hxdLKsuIda5ztEySErZWQYZzhHGgltvDPkfeZ//
N9ZmGHyLSpwsGj2WL13SzRCbgqUt8s6ZtgtEz4W3WqNq+Dw1Gid0WtdUeVvzQHH8
eK6F2keTobhlMEqQCgyWd3HGiugnZCFaEa2nAa8lcGXNhxKWLVxDfJ7QGtSeATVj
5zL+sm7obWV+juGM3U/IHW/u4wn8N+BgAT1sm0f91rDTMcOQyOIh8gBhX/vNm60h
OJaoZKVv0NnDK9E3VJ+Iw3a4b1DODnTl8AX5wpBYMk+QdG8OiLJjGPLGwBFN1vtg
xnzRej7hSSkQOaFB8GZGppXibn63qZ19gLM1j1GIJElQGVVUtBTmXKcdZ2WwwIAB
fmSAj0yItCi6UacuoVzTkdaYb60F86wDF9ohUlehD1fLJOFWpxZzfq6sZQpJyMie
x7OGxoHF6l84SSz6pUVXNn4LByqu4n6Nweh3FcrpWEvjJEiNbdc=
=gC/o
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
