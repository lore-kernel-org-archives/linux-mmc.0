From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v4 0/9] mmc: sdhci-msm: Add clk-rates and DDR support
Date: Wed, 24 Aug 2016 15:33:35 +0530
Message-ID: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This is v4 version of the patch series.
Patches 01, 02, 05 & 06 were Acked-by Adrian.

Changes from v3 -> v4 :-
1. Addressed comments from Adrian on Patch 03, 07, 08.
2. Addressed comments from Bjorn on Patch 03.
3. Added clk-rate support for sdhc DT nodes to all MSM platforms.
   in Pacth 04.
4. Rebased on next branch of Ulf.

Changes from v2 -> v3 :-
1. Addded Patch 01 based on Bjorn comment[2] - 
   This fixes/unrolls the poor coding style of read/writes of
   registers from base sdhci-msm driver.

2. Fixed/unrolled poor style of reads/writes of registers in Patch 02,
   based on Bjorn comment[2]. Also changed name of flag from
   use_updated_dll_reset -> use_14lpp_dll_reset.

Changes from v1->v2 :-
1. Removed patch 06 & 08 from v1 patch series[1]
(which were introducing unnecessary quirks).
   Instead have implemented __sdhci_msm_set_clock version of
   sdhci_set_clock in sdhci_msm driver itself in patch 07 of
   this patch series.
2. Enabled extra quirk (SDHCI_QUIRK2_PRESET_VALUE_BROKEN) in
   patch 05 of this patch series. 

Description of patches :-
This patchset adds clk-rates & other required changes to
upstream sdhci-msm driver from codeaurora tree.
It has been tested on a db410c Dragonboard and msm8996 based
platform.

Patch 0002 - Adds updated dll sequence for newer controllers
which has minor_version >= 0x42. This is required for msm8996.

MSM controller HW recommendation is to use the base MCI clock
and directly control this MCI clock at GCC in order to
change the clk-rate. 
Patches 03-07 bring in required change for this to
sdhci-msm and DT.

MSM controller would require 2x clock rate from source
for DDR bus speed modes. Patch 08 adds this support.

Patch 09 - adds DDR support in DT for sdhc1 of msm8916.

[1]:- http://www.spinics.net/lists/linux-mmc/msg38467.html
[2]:- http://www.spinics.net/lists/linux-mmc/msg38578.html 


Ritesh Harjani (8):
  mmc: sdhci-msm: Change poor style writel/readl of registers
  mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
  ARM: dts: qcom: Add clk-rates to sdhc1 & sdhc2
  mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
  mmc: sdhci-msm: Enable few quirks
  mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
  mmc: sdhci-msm: Add clock changes for DDR mode.
  arm64: dts: qcom: msm8916: Add ddr support to sdhc1

Venkat Gopalakrishnan (1):
  mmc: sdhci-msm: Update DLL reset sequence

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   4 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +
 drivers/mmc/host/sdhci-msm.c                       | 308 +++++++++++++++++++--
 6 files changed, 300 insertions(+), 24 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
