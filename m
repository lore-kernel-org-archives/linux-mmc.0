From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 23/30] mmc: block: Pass mqrq to mmc_blk_prep_packed_list()
Date: Fri,  8 Jul 2016 13:23:04 +0300
Message-ID: <1467973391-29221-24-git-send-email-adrian.hunter@intel.com>
References: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45373 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbcGHK3A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 06:29:00 -0400
In-Reply-To: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
passing mqrq to mmc_blk_prep_packed_list().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0b02c5d6baf5..b8b1d6b1074c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1693,13 +1693,14 @@ static inline u8 mmc_calc_packed_hdr_segs(struct request_queue *q,
 	return nr_segs;
 }
 
-static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
+static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq,
+				   struct mmc_queue_req *mqrq)
 {
 	struct request_queue *q = mq->queue;
 	struct mmc_card *card = mq->card;
+	struct request *req = mqrq->req;
 	struct request *cur = req, *next = NULL;
 	struct mmc_blk_data *md = mq->data;
-	struct mmc_queue_req *mqrq = mq->mqrq_cur;
 	bool en_rel_wr = card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN;
 	unsigned int req_sectors = 0, phys_segments = 0;
 	unsigned int max_blk_count, max_phys_segs;
@@ -1997,8 +1998,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	if (!rqc && !mq->mqrq_prev->req)
 		return 0;
 
-	if (rqc)
-		reqs = mmc_blk_prep_packed_list(mq, rqc);
+	if (mqrq_cur)
+		reqs = mmc_blk_prep_packed_list(mq, mqrq_cur);
 
 	do {
 		if (rqc) {
-- 
1.9.1

