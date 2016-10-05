From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 00/12] mmc: sdhci-msm: Add clk-rates, DDR, HS400 support
Date: Wed,  5 Oct 2016 20:10:28 +0530
Message-ID: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbcJEOlJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2016 10:41:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

Hi, 

This is v5 version of the patch series with addition of HS400 patches in this.
These are tested on internal msm8996 & db410c HW.

Though there is a discussion going on w.r.t. clk-rates DT entry[6]
but I would like to get below patches reviewed, since these
patches should not be functionally impacted.

Changes from v4 -> v5 :-
1. Added HS400 sdhci-msm controller specific changes:- (Patch 10, 11, 12)
2. Addressed comment from Adrian on Patch 07 @[3].
3. Addressed comment from Arnd on Patch 03, to directly add
   clk_table into sdhci_msm_host. [4]
4. Addressed comment from Bjorn to not enforce having clk-rates property
   in DT for older targets based on discussion at [5]
5. Retained Acks from Adrian on patches (01 & 02 & 06) where there were no
   changes made while addressing above comments.


Older history:- 
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
[3]:- https://patchwork.kernel.org/patch/9289345/
[4]:- https://www.spinics.net/lists/linux-mmc/msg39107.html
[5]:- http://www.spinics.net/lists/linux-mmc/msg38749.html
[6]:- https://patchwork.kernel.org/patch/9297381/

Ritesh Harjani (9):
  mmc: sdhci-msm: Change poor style writel/readl of registers
  mmc: sdhci-msm: add pltfm_data support to get clk-rates from DT
  ARM: dts: qcom: Add clk-rates to sdhc1 & sdhc2
  mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
  mmc: sdhci-msm: Enable few quirks
  mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
  mmc: sdhci-msm: Add clock changes for DDR mode.
  arm64: dts: qcom: msm8916: Add ddr support to sdhc1
  sdhci: sdhci-msm: update dll configuration

Venkat Gopalakrishnan (3):
  mmc: sdhci-msm: Update DLL reset sequence
  mmc: sdhci-msm: Add HS400 platform support
  mmc: sdhci-msm: Add calibration tuning for CDCLP533 circuit

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   4 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +
 drivers/mmc/host/sdhci-msm.c                       | 721 ++++++++++++++++++++-
 6 files changed, 703 insertions(+), 34 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

