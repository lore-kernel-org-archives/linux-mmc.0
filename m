From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Date: Fri, 10 Aug 2018 21:13:57 +0300
Message-ID: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,
This series implements support for HS400 signaling on Tegra210 and
Tegra186. This includes programming the DQS trimmer values, implementing
enhanced strobe and HS400 delay line calibration.

This series depends on the "Tegra SDHCI add support for HS200 and UHS
signaling" series.

Changelog:
v2:
	- Document in dt-bindings which controllers support HS400
	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
	  value" commit message
	- Add spaces around << in tegra_sdhci_set_dqs_trim()
	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
	  message more detailed
	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
	- Add blank lines around if-else-block in
	  tegra_sdhci_hs400_enhanced_strobe()
	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
	- Make commit message of "mmc: tegra: Implement HS400 delay line
	  calibration" more detailed

Aapo Vienamo (8):
  dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
  mmc: tegra: Parse and program DQS trim value
  mmc: tegra: Implement HS400 enhanced strobe
  mmc: tegra: Implement HS400 delay line calibration
  arm64: dts: tegra186: Add SDMMC4 DQS trim value
  arm64: dts: tegra210: Add SDMMC4 DQS trim value
  arm64: dts: tegra186: Enable HS400
  arm64: dts: tegra210: Enable HS400

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
 drivers/mmc/host/sdhci-tegra.c                     | 84 +++++++++++++++++++++-
 4 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.7.4
