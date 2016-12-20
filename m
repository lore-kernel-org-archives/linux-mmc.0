From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 0/4] mmc: Provide enhanced strobe support for sdhci-msm
Date: Tue, 20 Dec 2016 11:23:15 +0530
Message-ID: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcLTFxf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 00:53:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

Hi, 

Patch series is to enable enhanced strobe feature for sdhci-msm driver.
But there are also some changes done in core layer for this.

This was tested on msm8996 based interal target with emmc-5.1 card.

Ritesh Harjani (4):
  mmc: core: Return from mmc_set_clock if hz is already set to ios.clock
  mmc: mmc: Add change to set controller to HS400 frequency in enhanced
    strobe
  mmc: mmc: enable ios.enhanced_strobe before mmc_set_timing
  mmc: sdhci-msm: provide enhanced_strobe mode feature support

 drivers/mmc/core/core.c      |  3 +++
 drivers/mmc/core/mmc.c       |  9 ++++++++-
 drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

