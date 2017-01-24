From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCHv1 0/2] mmc: sdhci-msm: Addresses minor cleanups
Date: Tue, 24 Jan 2017 14:20:25 +0530
Message-ID: <1485247827-12898-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf/Adrian, 

I see that patch series at [1] was already taken by Ulf in next branch.
So as requested by Ulf, please find the below two patch fixes/cleanup on
top of next branch.

Patch 1:- Addresses comment from Adrian  [2]
Patch 2:- Addresses comment from Stephen [3]


links
[1]:- https://lkml.org/lkml/2017/1/10/70
[2]:- https://lkml.org/lkml/2017/1/19/153
[3]:- https://lkml.org/lkml/2017/1/20/542

Ritesh Harjani (2):
  mmc: sdhci-msm: Remove platform_execute_tuning from sdhci_msm_ops
  mmc: sdhci-msm: Remove unnecessary comments of CDC init sequence

 drivers/mmc/host/sdhci-msm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
