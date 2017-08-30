From: Ritesh Harjani <rharjani@qti.qualcomm.com>
Subject: [RFC 0/4] mmc: sdhci-msm: Add CQE support for sdhci-msm
Date: Wed, 30 Aug 2017 18:29:55 +0530
Message-ID: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

Hi All,

This is RFC patch series based on top of ulfh_mmc/cmdq branch
which is based upon Adrian's CMDQ patch series.

Below patch series enables CQE for sdhci-msm platform.
This has been tested on internal 8996 MTP which has CMDQ support.

Fixes w.r.t. CMDQ:-
There are some patches identified which were required atleast on
MSM platform. I am not sure if these are required for any other
CQE platform or not. Patchset 1, 3 & 4 commit text describes
the problems.

Performance related:- 
I gave one small shot for performance and the numbers were not looking good.
So, unless I have tested for performance completely, I should not discuss 
on performance numbers as of now with this patchset. 
I can try doing some more performance testing and post the results -
though this may take some while.

I used below test script for random read/write test.

*randwrite-test-script*
[global]
bs=32k
size=1g
rw=randwrite
direct=1
directory=/data/fiotest

[file1]
filename=singlefile1

*randread-test-script*
[global]
bs=32k
size=1g
rw=randread
directory=/data/fiotest

[file1]
filename=singlefile1

@Adrian,
Thanks a lot for pursuing and bringing CMDQ patch series to it's final stages :)


Ritesh Harjani (4):
  mmc: cqhci: Move CQHCI_ENABLE before setting TDLBA/TDLBAU
  mmc: sdhci-msm: Add CQHCI support for sdhci-msm
  mmc: sdhci-msm: Change the desc_sz on cqe_enable/disable.
  mmc: sdhci-msm: Handle unexpected interrupt case on enabling legacy
    IRQs on CQE halt

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/cqhci.c                           |   7 +-
 drivers/mmc/host/sdhci-msm.c                       | 121 ++++++++++++++++++++-
 4 files changed, 125 insertions(+), 5 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
