From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v4 0/2] Add support for periodic BKOPS
Date: Mon, 24 Dec 2012 15:51:06 +0200
Message-ID: <1356357068-31807-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198]:5016 "EHLO
	lx-merez.qi.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752552Ab2LXNvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Dec 2012 08:51:18 -0500
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>

This patch is based on the periodic BKOPS implementation in version 8 of "support BKOPS feature for eMMC" patch.
The patch was modified to answer the following issues:
- Since mmc_start_bkops is called from two contexts now, mmc_claim_host was moved to the beginning of the function
- Also, the check of doing_bkops should be protected when determing if an HPI is needed due to the same reason.

Changes in v4:
    - Separate the polling for BKOPS completion to a different patch
    - add a flag to indicate if polling for card completion is required

Changes in v3:
    - Move the call to stop_bkops to block.c. 
      This allows us to remove the mmc_claim_host from inside the function and doesn't cause additional degradation 
      due to un-neccessary calim host operation

Changes in v2:
    - Check the number of written / discarded sectors as the trigger for checking the BKOPS need.
    - Code review fixes

Maya Erez (2):
  mmc: core: Add support for idle time BKOPS
  mmc: allow the host controller to poll for BKOPS completion

 drivers/mmc/card/block.c |    8 ++-
 drivers/mmc/card/queue.c |    2 +
 drivers/mmc/core/core.c  |  189 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/mmc.c   |   22 ++++++
 include/linux/mmc/card.h |   31 ++++++++
 include/linux/mmc/core.h |    3 +
 include/linux/mmc/host.h |    1 +
 7 files changed, 245 insertions(+), 11 deletions(-)

-- 
1.7.3.3
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

