From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 01/22] mmc: block: Fix is_waiting_last_req set incorrectly
Date: Mon, 13 Mar 2017 14:36:32 +0200
Message-ID: <1489408613-26915-2-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbdCMMmb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:42:31 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Commit 15520111500c ("mmc: core: Further fix thread wake-up") allowed a
queue to release the host with is_waiting_last_req set to true. A queue
waiting to claim the host will not reset it, which can result in the
queue getting stuck in a loop.

Fixes: 15520111500c ("mmc: core: Further fix thread wake-up")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.10+
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1621fa08e206..e59107ca512a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1817,6 +1817,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		mmc_blk_issue_flush(mq, req);
 	} else {
 		mmc_blk_issue_rw_rq(mq, req);
+		card->host->context_info.is_waiting_last_req = false;
 	}
 
 out:
-- 
1.9.1

