From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 0/4] HW Command Queue support for Tegra SDMMC
Date: Wed, 19 Dec 2018 15:42:14 -0800
Message-ID: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[4] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[3] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[4] uses address range of sdmmc controllers to identify command
queue supported controllers

Patch[2] DMA Configuration prior to CQE:
As per eMMC5.1 Spec Section 6.6.39.1, Block size should be set to 512 B
before enabling command queue.
Tegra SDHCI Host design strictly follows this and prevents write access
to SDHCI_BLOCK_SIZE when CQE is set in CQHCI_CFG and results in access
failure and crashes for any write access to SDHCI_BLOCK_SIZE while CQE
is set.

Patch[1] Fix V4 Mode enable:
V4 Mode need to be enabled to select Host Version 4.0 mode for HW Command
queue support with Tegra SDHCI.

Sowjanya Komatineni (4):
  mmc: sdhci: Fix sdhci_do_enable_v4_mode
  mmc: cqhci: DMA Configuration prior to CQE
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  6 +--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  4 +-
 drivers/mmc/host/Kconfig                 |  1 +
 drivers/mmc/host/cqhci.c                 | 18 +++++--
 drivers/mmc/host/sdhci-tegra.c           | 89 +++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |  7 +--
 6 files changed, 113 insertions(+), 12 deletions(-)

-- 
2.7.4
