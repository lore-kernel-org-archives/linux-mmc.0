From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Date: Thu, 23 Aug 2018 10:47:04 +0200
Message-ID: <20180823084704.GA28696@ulmo>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:08:02PM +0300, Aapo Vienamo wrote:
> Hi all,
>=20
> This series implements support for faster signaling modes on Tegra
> SDHCI controllers. This series consist of several parts: changes
> requried for 1.8 V signaling and pad control, pad calibration, and
> tuning. Following earlies patch sets have been merged into this
> larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
> 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
> padautocal procedure". Also the patches for enabling SDHCI tuning
> are added.
>=20
> Changelog:
> v2:
> 	- Fix grammar in PMC device tree bindings docs
> 	- Remove a stray line from tegra sdhci bindings
> 	- Cosmetic changes to PMC pinctrl driver
> 	- Fix a typo in "soc/tegra: pmc: Implement
> 	  tegra_io_pad_is_powered()" commit message
> 	- Declare mask and value on the same line in
> 	  tegra_io_pad_is_powered()
> 	- Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
> 	  inside the if condition in tegra_sdhci_reset()
> 	- Use usleep_range() in tegra_sdhci_configure_cal_pad()
> 	- Move sdhci_writel() out of the enable if-else body in
> 	  tegra_sdhci_configure_cal_pad()
> 	- Add a delay before starting polling in
> 	  tegra_sdhci_pad_autocalib()
> 	- Use usleep_range() in tegra_sdhci_set_tap()
> 	- Rename orig_enabled to status in
> 	  tegra_sdhci_configure_card_clk()
> 	- Fix if condition wrapping alignment in tegra_sdhci_set_tap()
>=20
> v1:
> 	- Probe the regulator voltage capabilities to determine whether pinctrl
> 	  is needed in tegra_sdhci_r eset
> 	- Don't remove tegra_sdhci_voltage_switch()
> 	- Use dev_warn() in tegra_sdhci_init_pinctrl_info()
> 	- Don't change start_signal_voltage_switch callback if pinctrl info
> 	  invalid
> 	- Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
> 	- Add nvidia, prefix to pad autocal offset dt props in the example
>=20
> See the original patch sets for earlier changelogs.
>=20
> Aapo Vienamo (40):
>   dt-bindings: Add Tegra PMC pad configuration bindings
>   dt-bindings: mmc: tegra: Add pad voltage control properties
>   dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
>   dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
>   soc/tegra: pmc: Fix pad voltage configuration for Tegra186
>   soc/tegra: pmc: Factor out DPD register bit calculation
>   soc/tegra: pmc: Implement tegra_io_pad_is_powered()
>   soc/tegra: pmc: Use X macro to generate IO pad tables
>   soc/tegra: pmc: Remove public pad voltage APIs
>   soc/tegra: pmc: Implement pad configuration via pinctrl
>   mmc: sdhci: Add a quirk to skip clearing the transfer mode register on
>     tuning
>   mmc: tegra: Reconfigure pad voltages during voltage switching
>   mmc: tegra: Poll for calibration completion
>   mmc: tegra: Set calibration pad voltage reference
>   mmc: tegra: Power on the calibration pad
>   mmc: tegra: Disable card clock during pad calibration
>   mmc: tegra: Program pad autocal offsets from dt
>   mmc: tegra: Perform pad calibration after voltage switch
>   mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
>   mmc: tegra: Add a workaround for tap value change glitch
>   mmc: tegra: Parse default trim and tap from dt
>   mmc: tegra: Configure default tap values
>   mmc: tegra: Configure default trim value on reset
>   mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
>   mmc: sdhci: Add a quirk to disable card clock during tuning
>   mmc: tegra: Enable workaround for tuning transfer mode bug
>   mmc: tegra: Set SDHCI_QUIRK2_TUNE_DIS_CARD_CLK on Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra186
>   arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
>   arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
>   arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
>   arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
>   arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
>   arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
>   arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
>=20
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 ++++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 ++++
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  68 +++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  74 +++
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  55 ++
>  drivers/mmc/host/sdhci-tegra.c                     | 556 +++++++++++++++=
++++--
>  drivers/mmc/host/sdhci.c                           |  21 +
>  drivers/mmc/host/sdhci.h                           |   4 +
>  drivers/soc/tegra/pmc.c                            | 511 ++++++++++++++-=
----
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
>  include/soc/tegra/pmc.h                            |  20 +-
>  13 files changed, 1324 insertions(+), 212 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

Hi Ulf, Adrian,

I've been running some tests on this on various Tegra boards and this
all seems to work fine. I'm also pretty happy with how this turned out,
so the whole series is:

Acked-by: Thierry Reding <treding@nvidia.com>

In order to get this merged, I think it'd be best for you guys to pick
up the MMC patches, since they are all independent of the rest. There is
a runtime dependency on the PMC bits for the faster modes, but things
will fallback to the status quo if those bits are not enabled. The only
dependency here is between the PMC and DTS changes, which I usually pick
up into the Tegra tree anyway, so I can sort that out there.

Since I've already gone through the process of splitting up the series,
I can offer to rebase the MMC patches on top of v4.19-rc1 when it's out
and send a pull request for the MMC patches. Alternatively I can further
split that branch up into two parts, one with the two patches that touch
the core and another with the remainder, if that's what you prefer. Or
you can of course feel free to apply all of the MMC patches yourselves
with my above Acked-by if you want to.

Any thought on the above?

Thanks,
Thierry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt+dIYACgkQ3SOs138+
s6HBgQ/+LNk9y6KpgR/vb4jhvXJSFL/o55wBlqhQB9kYXq1+2pRLyzCObtcl8sgX
3Uk8uZfWAEjmlWL4nW4OETcezHvSWNtYG6stIbIy0ZSLrMmvy/yy3BZkzdWbDOj1
xvpias4n/FZLVPyUWjG+JVudZx61EyP5ll0FlYrRLYmDpwrB3JL1K6Bj9TKurdxe
/HJumGE1UX/TQaScoAkU43onDMP8s19T+k/IXH6w/oguch6XN3Znm0e/aBRswKyN
B9q2XKR4+T285qX/ChjY2ezKE7awez9/2+0OHTR+sCq1Zjlwp86ToCqExlqyKwqS
It+UPn6c9nJAbw/VfATh6wPvNhrbyBZv5rJNmqVac+FaufuHvak7VaFyQ5YI3+Xt
mlaW6xAcYg+mqVTlFODWpNhDupIPHMzhmOa6HIkFjJvuaEUuVBfH/SHkqmIC74de
VBOpPikF7pCog5ygEYPZie0r6rga4nVJgysauxTRwjn9xkcnl9uH4PdAm3fVFpf7
W9gU+odEEllf8NJapITkAwHzAko0mBdz9o8f5koL9KRPDU9mpgcbupmDNHM2JpJt
yaDSg8+cXQo/aCue/Nt5ocbfzbvvD0CrUq/SsYFnLvLrXXywyyHGfh526Ryor7Li
p+ySNKlGCK2qyFvPCZqJHZpZ9TYtie7RSleYd1NwXjpWI+fMHT4=
=83Da
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
