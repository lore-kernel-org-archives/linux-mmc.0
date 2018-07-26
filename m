From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 00/10] Tegra SDHCI enable 1.8 V signaling on Tegar210 and Tegra186
Date: Thu, 26 Jul 2018 15:19:10 +0300
Message-ID: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,

Reconfigure pad voltages as part of mmc voltage switching on
controllers with adjustable voltages. Allow for reconfiguration of the
signaling voltage of SDMMC1 on Tegra210 P2597 and fix SDMMC4 signaling
voltage regulator configuration on Tegra210 P2180.

This series depends on the "Tegra PMC pinctrl pad configuration" series posted
earlier.

Changelog:
v2:
	- Change the pinctrl bindings commit title
	- Use IS_ERR in tegra_sdhci_init_pinctrl_info()
	- Add nvidia,only-1-8-v property
	- Disable UHS modes in case the pad and regulator configuration
	  is invalid

Aapo Vienamo (10):
  dt-bindings: mmc: tegra: Add pad voltage control properties
  dt-bindings: mmc: tegra: Add nvidia,only-1-8-v property
  mmc: tegra: Reconfigure pad voltages during voltage switching
  arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
  arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
  arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
  arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
  arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
  arm64: dts: tegra210: Add nvidia,only-1-8-v to sdmmc4
  arm64: dts: tegra186: Add nvidia,only-1-8-v to sdmmc4

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  24 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  41 ++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  28 +++++
 drivers/mmc/host/sdhci-tegra.c                     | 140 +++++++++++++++++++--
 6 files changed, 222 insertions(+), 24 deletions(-)

-- 
2.7.4
