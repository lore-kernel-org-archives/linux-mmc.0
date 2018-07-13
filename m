From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 0/7] Add devfreq based clock scaling support for mmc
Date: Fri, 13 Jul 2018 15:22:56 +0530
Message-ID: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

This change adds the use of devfreq based clock scaling to MMC.
Both eMMC and SD card can use it.
For some workloads, such as video playback, it isn't necessary
for these cards to run at high speed. Running at lower frequency,
in such cases can still meet the deadlines for data transfers.
Scaling down the clock frequency dynamically has power savings
not only because the bus is running at lower frequency but also
has an advantage of scaling down the system core voltage, if supported.
Provide an ondemand clock scaling support similar to the cpufreq
ondemand governor having two thresholds, up_threshold and
down_threshold to decide whether to increase the frequency or
scale it down respectively as per load.

Sahitya Tummala (1):
  devfreq: Add new flag to do simple clock scaling

Sayali Lokhande (6):
  mmc: core: devfreq: Add devfreq based clock scaling support
  mmc: core: Add sysfs entries for dynamic control of clock scaling
  mmc: core: add support for devfreq suspend/resume
  mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
  mmc: sdhci-msm: Enable clock scaling property
  mmc: core: Add a debugfs entry to set max clock rate

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
 Documentation/mmc/mmc-dev-attrs.txt                |  38 ++
 drivers/devfreq/governor_simpleondemand.c          |  25 +-
 drivers/mmc/core/core.c                            | 672 +++++++++++++++++++++
 drivers/mmc/core/core.h                            |   9 +
 drivers/mmc/core/debugfs.c                         |  90 +++
 drivers/mmc/core/host.c                            | 163 ++++-
 drivers/mmc/core/mmc.c                             | 227 ++++++-
 drivers/mmc/core/sd.c                              |  85 ++-
 drivers/mmc/host/Kconfig                           |   2 +
 drivers/mmc/host/sdhci-msm.c                       |  38 ++
 drivers/mmc/host/sdhci-pltfm.c                     |  11 +
 drivers/mmc/host/sdhci.c                           |  27 +
 drivers/mmc/host/sdhci.h                           |   8 +
 include/linux/devfreq.h                            |   4 +
 include/linux/mmc/card.h                           |   5 +
 include/linux/mmc/host.h                           |  70 +++
 17 files changed, 1475 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
