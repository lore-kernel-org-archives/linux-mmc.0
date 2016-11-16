From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v8 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400 support
Date: Wed, 16 Nov 2016 21:30:36 +0530
Message-ID: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

This is v8 version of the patch series which adds support for MSM8996.
Adds HS400 driver support as well.
These are tested on internal msm8996 & db410c HW.

Changes from v7 -> v8 :-
1. Added patch 005 to add dt bindings for xo_clock.
2. Added patch 009 to factor out sdhci_enable_clock as discussed on v7 series.
2.a. Modified patch 010 by making use of sdhci_enable_clock.
2.b. Addressed Stephen's comment on patch 010 to call clk_set_rate unconditionally.
3. Addressed Stephen comments to remove unncessary one line comments, braces and other
minor comments.
4. Added changes from Jeremy in patch 002 for gcc-msm8994 as well for sdcc clk_rcg2_floor_ops.
minor comments.

v7 series was verified on msm8994 target by Jeremy McNicoll.

Older history :-
Below are the changes in v7.

Changes from v6 -> v7 :-
1. Removed patch "clk: Add clk_hw_get_clk() helper API to be used by clk providers"
in v7 as it was not required.
2. Addressed Stephen review comments on -
"clk: qcom: Add rcg ops to return floor value closest to the requested rate"
3. Addressed comments from Stephen to add xo_clock entry in the sdhc clock node.
Using the same xo_clock entry from DT to get the clk_rate of xo_clock used in
sdhci-msm driver. Patch 04 adds this entry into DT.
Patch 05 adds the driver support for xo_clock mentioned above.
Hence there is a minor change in Patch05, which can be reviewed and taken
into the tree.

IMHO, almost all patches are almost done and are ready to be accepted.
Will below process work out? 
Patches 001 & 002 :- (clock changes) - Can go via Stephen's Boyd Tree.
Patches 004 & 010 :- (DTS changes) - Can go via Andy Gross. 
Patches 003, 005-009 & 011-014 :- (sdhci-msm changes) - Adrian's tree.

Please let me know in case if anything else is required on above.


Changes from v5 -> v6 :-
1. Earlier in v5 series DT node was added to get the clk-rates table
needed for sdhci-msm driver. But this is removed in this(v6) patch series
and instead the clk changes are done in the clk driver as per Rob H comment.

2. Added clk driver changes(patch 1-3) to provide floor rate values of requested
clock for sdhc client.
For following boards- apq8084, msm8996, msm8916, msm8974.

3. Other minor patch comments were addressed.

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

Patch 0001-0003- Adds support in qcom clk driver to return
floor value of requested clock rate instead of ceil rate
for sdhc clients.

Patch 0004- Adds updated dll sequence for newer controllers
which has minor_version >= 0x42. This is required for msm8996.

MSM controller HW recommendation is to use the base MCI clock
and directly control this MCI clock at GCC in order to
change the clk-rate.
Patches 06-08 bring in required change for this to
sdhci-msm.

MSM controller would require 2x clock rate from source
for DDR bus speed modes. Patch 09 adds this support.

Patch 0010- adds DDR support in DT for sdhc1 of msm8916.

Patches 0011-0014- Adds HS400 support to sdhci-msm.


[1]:- http://www.spinics.net/lists/linux-mmc/msg38467.html
[2]:- http://www.spinics.net/lists/linux-mmc/msg38578.html
[3]:- https://patchwork.kernel.org/patch/9289345/
[4]:- https://www.spinics.net/lists/linux-mmc/msg39107.html
[5]:- http://www.spinics.net/lists/linux-mmc/msg38749.html
[6]:- https://patchwork.kernel.org/patch/9297381/


Rajendra Nayak (2):
  clk: qcom: Add rcg ops to return floor value closest to the requested
    rate
  clk: qcom: Move all sdcc rcgs to use clk_rcg2_floor_ops

Ritesh Harjani (12):
  mmc: sdhci-msm: Change poor style writel/readl of registers
  ARM: dts: Add xo_clock to sdhc nodes on qcom platforms
  dt-bindings: sdhci-msm: Add xo_clock property
  mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
  mmc: sdhci-msm: Enable few quirks
  mmc: sdhci: Factor out sdhci_enable_clock
  mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
  mmc: sdhci-msm: Add clock changes for DDR mode.
  arm64: dts: qcom: msm8916: Add ddr support to sdhc1
  mmc: sdhci-msm: Save the calculated tuning phase
  mmc: sdhci-msm: Add calibration tuning for CDCLP533 circuit
  sdhci: sdhci-msm: update dll configuration

Venkat Gopalakrishnan (2):
  mmc: sdhci-msm: Update DLL reset sequence
  mmc: sdhci-msm: Add HS400 platform support

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  16 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  16 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  11 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   9 +-
 drivers/clk/qcom/clk-rcg.h                         |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |  76 ++-
 drivers/clk/qcom/common.c                          |  16 +
 drivers/clk/qcom/common.h                          |   2 +
 drivers/clk/qcom/gcc-apq8084.c                     |   8 +-
 drivers/clk/qcom/gcc-msm8916.c                     |   4 +-
 drivers/clk/qcom/gcc-msm8974.c                     |   8 +-
 drivers/clk/qcom/gcc-msm8994.c                     |   8 +-
 drivers/clk/qcom/gcc-msm8996.c                     |   8 +-
 drivers/mmc/host/sdhci-msm.c                       | 626 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  28 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 17 files changed, 739 insertions(+), 100 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
