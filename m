From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 0/8] mmc: sdhci-msm: Add additional support to sdhci-msm driver
Date: Wed, 29 Jun 2016 16:50:25 +0530
Message-ID: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi All,

This patch series aims to add additional support to upstream
sdhci-msm driver. It adds regulator DT parsing, pwr_irq support
(Qualcomm specific) & additional changes required to work with
HS200 mode on latest controllers.


Asutosh Das (1):
  mmc: sdhci-msm: Add pwr_irq support to sdhci-msm

Ritesh Harjani (4):
  mmc: sdhci-msm: Fix the regulator binding name
  mmc: sdhci-msm: Add DT parsing for regulator support
  mmc: sdhci-msm: Add regulator DT props to sdhci-msm bindings
  mmc: sdhci-msm: Add check_power_status to sdhci-msm

Sahitya Tummala (1):
  mmc: sdhci: Add check_power_status host operation

Venkat Gopalakrishnan (2):
  mmc: sdhci-msm: Reset vendor specific func register on probe
  mmc: sdhci-msm: Update DLL reset sequence

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  27 +-
 drivers/mmc/host/sdhci-msm.c                       | 726 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                           |  24 +-
 drivers/mmc/host/sdhci.h                           |   5 +
 4 files changed, 762 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
