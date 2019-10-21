From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 0/6] mmc: Add clock scaling support for mmc driver
Date: Mon, 21 Oct 2019 19:59:31 +0530
Message-ID: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This change adds the use of devfreq based clock scaling to MMC.
This applicable for eMMC and SDCard.
For some workloads, such as video playback, it isn't necessary
for these cards to run at high speed. Running at lower
frequency, in such cases can still meet the deadlines for data
transfers.

Scaling down the clock frequency dynamically has power savings
not only because the bus is running at lower frequency but also
has an advantage of scaling down the system core voltage, if
supported. Provide an ondemand clock scaling support similar
to the cpufreq ondemand governor having two thresholds,
up_threshold and down_threshold to decide whether to increase
the frequency or scale it down respectively as per load.


Ram Prakash Gupta (6):
  mmc: core: Parse clk scaling dt entries
  mmc: core: Add core scaling support in driver
  mmc: core: Initialize clk scaling for mmc and SDCard
  mmc: core: Add debugfs entries for scaling support
  mmc: sdhci-msm: Add capability in platfrom host
  dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  19 +
 drivers/mmc/core/block.c                           |  19 +-
 drivers/mmc/core/core.c                            | 777 +++++++++++++++++++++
 drivers/mmc/core/core.h                            |  17 +
 drivers/mmc/core/debugfs.c                         |  90 +++
 drivers/mmc/core/host.c                            | 226 ++++++
 drivers/mmc/core/mmc.c                             | 246 ++++++-
 drivers/mmc/core/queue.c                           |   2 +
 drivers/mmc/core/sd.c                              |  84 ++-
 drivers/mmc/host/sdhci-msm.c                       |   2 +
 include/linux/mmc/card.h                           |   7 +
 include/linux/mmc/host.h                           |  66 ++
 12 files changed, 1550 insertions(+), 5 deletions(-)

-- 
1.9.1
