From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RESEND RFC 0/3] mmc: sdhci: sdhci-msm: Add more debug logs
Date: Tue, 10 Jan 2017 12:11:52 +0530
Message-ID: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Resending this small set of patches.

Below is a small set of patches which provide useful info for
debugging issues.

Patch 1 :- This provide callback mechanism for platform drivers
to dump their necessary register info at the time of sdhci_dumpregs.

Patch 2 :- This implements this callback (->platform_dumpregs)
for sdhci-msm.

Patch 3 :- Adds more logs for data errors to aid debugging.

Ritesh Harjani (1):
  mmc: sdhci: Add more debug info in case of data error

Sahitya Tummala (2):
  mmc: sdhci: Add platform_dumpregs callback support to sdhci_ops.
  mmc: sdhci-msm: Implement platform_dumpregs callback in sdhci-msm

 drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     | 24 ++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h     |  1 +
 3 files changed, 57 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
