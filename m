From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 38/46] mmc: block: Fix 4K native sector check
Date: Thu,  9 Jun 2016 14:52:38 +0300
Message-ID: <1465473166-22532-39-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbcFIL7T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:59:19 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

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
index b3daa7ffc7ec..b42318ce0ad7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1985,11 +1985,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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
@@ -2009,8 +2009,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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

