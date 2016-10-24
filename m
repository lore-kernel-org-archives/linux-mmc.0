From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 16/25] mmc: block: Fix 4K native sector check
Date: Mon, 24 Oct 2016 11:37:31 +0300
Message-ID: <1477298260-5064-17-git-send-email-adrian.hunter@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936515AbcJXInj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 04:43:39 -0400
In-Reply-To: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

The 4K native sector check does not allow for the 'do' loop nor the
variables used after the 'cmd_abort' label.

'brq' and 'req' get reassigned in the 'do' loop, so the check must not
assume what their values are. After the 'cmd_abort' label, 'mq_rq' and
'req' are used, but 'rqc' must be NULL otherwise it can be started again.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2523407a8096..715767672aaf 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1989,11 +1989,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
-	struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
+	struct mmc_blk_request *brq;
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
-	struct request *req = rqc;
+	struct request *req;
 	struct mmc_async_req *areq;
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
@@ -2013,8 +2013,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			if (mmc_large_sector(card) &&
 				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-					req->rq_disk->disk_name);
+					rqc->rq_disk->disk_name);
 				mq_rq = mq->mqrq_cur;
+				req = rqc;
+				rqc = NULL;
 				goto cmd_abort;
 			}
 
-- 
1.9.1

