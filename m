From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 23/30] mmc: block: Pass mqrq to mmc_blk_prep_packed_list()
Date: Tue, 16 Aug 2016 13:44:33 +0300
Message-ID: <1471344280-16663-24-git-send-email-adrian.hunter@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44366 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbcHPKun (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:50:43 -0400
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
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
index b8060c5effa2..ac606bea36a1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1696,13 +1696,14 @@ static inline u8 mmc_calc_packed_hdr_segs(struct request_queue *q,
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
@@ -2001,8 +2002,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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

