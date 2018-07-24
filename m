From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 00/10] Update the pad autocal procedure
Date: Tue, 24 Jul 2018 17:29:41 +0300
Message-ID: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
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

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  32 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  20 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  12 +
 drivers/mmc/host/sdhci-tegra.c                     | 242 ++++++++++++++++++++-
 4 files changed, 297 insertions(+), 9 deletions(-)

-- 
2.7.4
