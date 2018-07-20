From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 0/7] Tegra SDHCI enable 1.8 V signaling on Tegar210 and Tegra186
Date: Fri, 20 Jul 2018 15:45:39 +0300
Message-ID: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Reconfigure pad voltages as part of mmc voltage switching on
controllers with adjustable voltages. Allow for reconfiguration of the
signaling voltage of SDMMC1 on Tegra210 P2597 and fix SDMMC4 signaling
voltage regulator configuration on Tegra210 P2180.

This series depends on the "Tegra PMC pinctrl pad configuration" series posted
earlier.

Aapo Vienamo (7):
  dt-bindings: Document Tegra SDHCI pinctrl bindings
  mmc: tegra: Reconfigure pad voltages during voltage switching
  arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
  arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
  arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
  arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
  arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 40 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 12 +--
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 27 +++++++
 drivers/mmc/host/sdhci-tegra.c                     | 91 ++++++++++++++++++++--
 6 files changed, 176 insertions(+), 17 deletions(-)

-- 
2.7.4
