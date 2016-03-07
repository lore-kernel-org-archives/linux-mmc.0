From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 0/4] Add phy support for arasan,sdhci-5.1
Date: Mon,  7 Mar 2016 23:38:19 +0800
Message-ID: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


Phy is mandatory requirement for arasan,sdhci-5.1, so we introduce
generic phy support for sdhci-of-arasan.
This version is rebased on Ulf's next to make it applied cleanly.
Also, we fix some preexisting problems of err handling suggested by Adrian.


Changes in v7:
- split two changes into seperate patches

Changes in v6:
- rebase on Ulf's next
- fix some preexisting problems of err handling suggested
      by Adrian
- add Rob's Acked-by tag

Changes in v5:
- remove rpm support from this serise
- fix some err case for handling phy

Changes in v4:
- remove suspend/resume_phy
- add err handle label for system PM callback
- fix comments of struct sdhci_arasan_data and system PM
  callback suggested by Michal

Changes in v3:
- remove phy_init/exit for suspend/resume
- adjust phy_int/power_on seq to make code more reasonable
  simplify suspend/resume_phy

Changes in v2:
- Keep phy as a mandatory requirement for arasan,sdhci-5.1

Shawn Lin (4):
  Documentation: bindings: add description of phy for sdhci-of-arasan
  mmc: sdhci-of-arasan: remove disable clk_ahb from sdhci_arasan_resume
  mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free for err handling
  mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 +++++-
 drivers/mmc/host/sdhci-of-arasan.c                 | 71 +++++++++++++++++++---
 2 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.3.7
