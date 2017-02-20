From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 0/4] mmc: core: Provide CMD5 awake and partial_init support
Date: Mon, 20 Feb 2017 13:33:08 +0530
Message-ID: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

As per JEDEC spec - CMD5 can be used to awake from sleep mode for emmc.
This patch series provide CMD5(awake) + mmc_partial_init support to resume
mmc card device. This is mainly to reduce the resume time.

This was tested on db410c (emmc with HS200 mode) and MS8996 (emmc with HS400ES)
based internal board. This patch reduced the resume time by ~50% on msm8996
and ~11% on db410c.

As of now this patch series provides a caps (MMC_CAP2_SLEEP_AWAKE) to enable this feature.
Since there is no dependency on host platform for this, we can enable this feature by
default as well. Thoughts?


Ritesh Harjani (4):
  Documentation: mmc: add mmc-sleep-awake
  mmc: core: add mmc-sleep-awake caps
  mmc: mmc: add support for CMD5 awake
  mmc: core: Implement mmc_partial_init during resume

 Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
 drivers/mmc/core/core.c                       |  13 +++
 drivers/mmc/core/core.h                       |   1 +
 drivers/mmc/core/host.c                       |   2 +
 drivers/mmc/core/mmc.c                        | 160 ++++++++++++++++++++++++--
 include/linux/mmc/card.h                      |   3 +
 include/linux/mmc/host.h                      |   2 +
 7 files changed, 176 insertions(+), 7 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
