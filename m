From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
Date: Thu, 26 Jul 2018 15:26:46 +0300
Message-ID: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,

Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
procedure to match the ones specified in the TRMs of the more recent
SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
should not break things older generations either.

This series depends on the "Tegra SDHCI enable 1.8 V signaling on
Tegar210 and Tegra186" series posted earlier.

Changelog:
v2:
	- Rename the series
	- Align the register macros
	- Use readl_poll_timeout() in tegra_sdhci_pad_autocalib()
	- Move SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD define to correc patch
	- Use !!(reg & SDHCI_CLOCK_CARD_EN) in
	  tegra_sdhci_configure_card_clk()
	- Add "nvidia," prefix to pad drive strength offset dt props
	- Read the drive strength properties as u32 instead of u8
	- Disable autocalibration if it times out

Aapo Vienamo (10):
  mmc: tegra: Poll for calibration completion
  mmc: tegra: Set calibration pad voltage reference
  mmc: tegra: Power on the calibration pad
  mmc: tegra: Disable card clock during pad calibration
  dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
  mmc: tegra: Program pad autocal offsets from dt
  arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
  arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
  mmc: tegra: Perform pad calibration after voltage switch
  mmc: tegra: Enable pad calibration on Tegra210 and Tegra186

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  34 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  20 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  12 +
 drivers/mmc/host/sdhci-tegra.c                     | 280 +++++++++++++++++++--
 4 files changed, 319 insertions(+), 27 deletions(-)

-- 
2.7.4
