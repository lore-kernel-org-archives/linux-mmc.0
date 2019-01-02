From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V7 0/2] HW Command Queue support for Tegra SDMMC
Date: Wed, 2 Jan 2019 11:36:46 -0800
Message-ID: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[2] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[1] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[2] uses address range of sdmmc controllers to identify command
queue supported controllers

Note: PATCH V7 has seperate DMA Type defined as per SD Host V4.20 spec.
Updated commit message to be more clear.

Sowjanya Komatineni (2):
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |   6 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |   4 +-
 drivers/mmc/host/Kconfig                 |   1 +
 drivers/mmc/host/sdhci-tegra.c           | 107 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |  16 +++--
 drivers/mmc/host/sdhci.h                 |   1 +
 6 files changed, 125 insertions(+), 10 deletions(-)

-- 
2.7.4
