From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 00/10] Add clk-rates and DDR support to sdhci-msm
Date: Wed, 10 Aug 2016 20:31:49 +0530
Message-ID: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi All, 

This patchset adds clk-rates & other required changes to
upstream sdhci-msm driver from codeaurora tree.
It has been tested on a db410c Dragonboard and msm8996 based
platform.

Patch 0001 - Adds updated dll sequence for newer controllers
which has minor_version >= 0x42. This is required for msm8996.

MSM controller HW recommendation is to use the base MCI clock
and directly control this MCI clock at GCC in order to
change the clk-rate. 
Patches 0002-0008 bring in required change for this to
sdhci-msm and DT of db410c.

MSM controller would require 2x clock rate from source
for DDR bus speed modes. Patch 0009 adds this support.

Patch 0010 - adds DDR support in DT for sdhc1 of msm8916.

Ritesh Harjani (6):
  mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
  arm64: dts: qcom: msm8916: Add clk-rates to sdhc1 & sdhc2
  mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
  mmc: sdhci-msm: Enable SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
  mmc: sdhci-msm: Add clock changes for DDR mode.
  arm64: dts: qcom: msm8916: Add ddr support to sdhc1

Sahitya Tummala (3):
  mmc: sdhci: Add SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK quirk2 support
  mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
  mmc: sdhci-msm: Enable SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK to sdhci-msm

Venkat Gopalakrishnan (1):
  mmc: sdhci-msm: Update DLL reset sequence

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +
 drivers/mmc/host/sdhci-msm.c                       | 209 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                           |   4 +
 drivers/mmc/host/sdhci.h                           |   6 +
 5 files changed, 223 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
