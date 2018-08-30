From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 00/38] Tegra SDHCI add support for HS200 and UHS signaling
Date: Thu, 30 Aug 2018 18:06:01 +0300
Message-ID: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,

This series implements support for faster signaling modes on Tegra
SDHCI controllers. This series consist of several parts: changes
required for 1.8 V signaling and pad control, pad calibration, and
tuning. Following earlies patch sets have been merged into this
larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
padautocal procedure". Also the patches for enabling SDHCI tuning
are added.

Changelog:
v3:
	- Remove tegra_sdhci_writew() from tegra210_sdhci_ops to prevent
	  incorrect access to SDHCI_TRANSFER_MODE on Tegra210.
	- Drop "mmc: sdhci: Add a quirk to skip clearing the transfer
	  mode register on tuning". This is no longer needed since it
	  was effectively a workaround to the behavior caused by
	  tegra_sdhci_writew() on Tegra210.
	- Implement disabling of the card clock during issuing of the
	  tuning command in tegra210_sdhci_writew().
	- Drop "mmc: sdhci: Add a quirk to disable card clock during
	  tuning". This is now implemented in the sdhci-tegra driver.
	
v2:
	- Fix grammar in PMC device tree bindings docs
	- Remove a stray line from tegra sdhci bindings
	- Cosmetic changes to PMC pinctrl driver
	- Fix a typo in "soc/tegra: pmc: Implement
	  tegra_io_pad_is_powered()" commit message
	- Declare mask and value on the same line in
	  tegra_io_pad_is_powered()
	- Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
	  inside the if condition in tegra_sdhci_reset()
	- Use usleep_range() in tegra_sdhci_configure_cal_pad()
	- Move sdhci_writel() out of the enable if-else body in
	  tegra_sdhci_configure_cal_pad()
	- Add a delay before starting polling in
	  tegra_sdhci_pad_autocalib()
	- Use usleep_range() in tegra_sdhci_set_tap()
	- Rename orig_enabled to status in
	  tegra_sdhci_configure_card_clk()
	- Fix if condition wrapping alignment in tegra_sdhci_set_tap()

v1:
	- Probe the regulator voltage capabilities to determine whether pinctrl
	  is needed in tegra_sdhci_r eset
	- Don't remove tegra_sdhci_voltage_switch()
	- Use dev_warn() in tegra_sdhci_init_pinctrl_info()
	- Don't change start_signal_voltage_switch callback if pinctrl info
	  invalid
	- Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
	- Add nvidia, prefix to pad autocal offset dt props in the example

See the original patch sets for earlier changelogs.


Aapo Vienamo (38):
  dt-bindings: Add Tegra PMC pad configuration bindings
  dt-bindings: mmc: tegra: Add pad voltage control properties
  dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
  dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
  soc/tegra: pmc: Fix pad voltage configuration for Tegra186
  soc/tegra: pmc: Factor out DPD register bit calculation
  soc/tegra: pmc: Implement tegra_io_pad_is_powered()
  soc/tegra: pmc: Use X macro to generate IO pad tables
  soc/tegra: pmc: Remove public pad voltage APIs
  soc/tegra: pmc: Implement pad configuration via pinctrl
  mmc: tegra: Reconfigure pad voltages during voltage switching
  mmc: tegra: Poll for calibration completion
  mmc: tegra: Set calibration pad voltage reference
  mmc: tegra: Power on the calibration pad
  mmc: tegra: Disable card clock during pad calibration
  mmc: tegra: Program pad autocal offsets from dt
  mmc: tegra: Perform pad calibration after voltage switch
  mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
  mmc: tegra: Add a workaround for tap value change glitch
  mmc: tegra: Parse default trim and tap from dt
  mmc: tegra: Configure default tap values
  mmc: tegra: Configure default trim value on reset
  mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
  mmc: tegra: Remove tegra_sdhci_writew() from tegra210_sdhci_ops
  mmc: tegra: Disable card clock during tuning cmd on Tegra210
  mmc: tegra: Enable UHS and HS200 modes for Tegra210
  mmc: tegra: Enable UHS and HS200 modes for Tegra186
  arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
  arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
  arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
  arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
  arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
  arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add SDHCI tap and trim values
  arm64: dts: tegra186: Add SDHCI tap and trim values
  arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
  arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4

 .../arm/tegra/nvidia,tegra186-pmc.txt         |  93 +++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt | 103 ++++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt     |  68 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  74 +++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |  12 +-
 .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |   1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  55 ++
 drivers/mmc/host/sdhci-tegra.c                | 583 ++++++++++++++++--
 drivers/soc/tegra/pmc.c                       | 511 +++++++++++----
 .../pinctrl/pinctrl-tegra-io-pad.h            |  18 +
 include/soc/tegra/pmc.h                       |  20 +-
 11 files changed, 1328 insertions(+), 210 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

-- 
2.18.0
