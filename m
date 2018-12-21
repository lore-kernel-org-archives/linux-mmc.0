From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 0/3] HW Command Queue support for Tegra SDMMC
Date: Thu, 20 Dec 2018 17:25:06 -0800
Message-ID: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[3] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[2] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[3] uses address range of sdmmc controllers to identify command
queue supported controllers

Patch[1] Fix V4 Mode enable:
V4 Mode need to be enabled to select Host Version 4.0 mode for HW Command
queue support with Tegra SDHCI.

Sowjanya Komatineni (3):
  mmc: sdhci: Fix sdhci_do_enable_v4_mode
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |   6 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |   4 +-
 drivers/mmc/host/Kconfig                 |   1 +
 drivers/mmc/host/sdhci-tegra.c           | 138 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |   4 +-
 5 files changed, 145 insertions(+), 8 deletions(-)

-- 
2.7.4
