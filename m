From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 22/39] mmc: block: Prepare CQE data
Date: Fri, 10 Feb 2017 14:55:35 +0200
Message-ID: <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbdBJNMD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:12:03 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Enhance mmc_blk_data_prep() to support CQE requests.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0c7d41967281..8119c5533a91 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -36,6 +36,7 @@
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
+#include <linux/ioprio.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -1440,25 +1441,27 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 }
 
 static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
-			      int disable_multi, bool *do_rel_wr,
-			      bool *do_data_tag)
+			      int disable_multi, bool *do_rel_wr_p,
+			      bool *do_data_tag_p)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mqrq->req;
+	bool do_rel_wr, do_data_tag;
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
 	 * are supported only on MMCs.
 	 */
-	*do_rel_wr = (req->cmd_flags & REQ_FUA) &&
-		     rq_data_dir(req) == WRITE &&
-		     (md->flags & MMC_BLK_REL_WR);
+	do_rel_wr = (req->cmd_flags & REQ_FUA) &&
+		    rq_data_dir(req) == WRITE &&
+		    (md->flags & MMC_BLK_REL_WR);
 
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
 	brq->mrq.data = &brq->data;
+	brq->mrq.tag = req->tag;
 
 	brq->stop.opcode = MMC_STOP_TRANSMISSION;
 	brq->stop.arg = 0;
@@ -1473,6 +1476,10 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 
 	brq->data.blksz = 512;
 	brq->data.blocks = blk_rq_sectors(req);
+	brq->data.blk_addr = blk_rq_pos(req);
+
+	if (IOPRIO_PRIO_CLASS(req_get_ioprio(req)) == IOPRIO_CLASS_RT)
+		brq->data.flags |= MMC_DATA_PRIO;
 
 	/*
 	 * The block layer doesn't support all sector count
@@ -1502,18 +1509,23 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 						brq->data.blocks);
 	}
 
-	if (*do_rel_wr)
+	if (do_rel_wr) {
 		mmc_apply_rel_rw(brq, card, req);
+		brq->data.flags |= MMC_DATA_REL_WR;
+	}
 
 	/*
 	 * Data tag is used only during writing meta data to speed
 	 * up write and any subsequent read of this meta data
 	 */
-	*do_data_tag = card->ext_csd.data_tag_unit_size &&
-		       (req->cmd_flags & REQ_META) &&
-		       (rq_data_dir(req) == WRITE) &&
-		       ((brq->data.blocks * brq->data.blksz) >=
-			card->ext_csd.data_tag_unit_size);
+	do_data_tag = card->ext_csd.data_tag_unit_size &&
+		      (req->cmd_flags & REQ_META) &&
+		      (rq_data_dir(req) == WRITE) &&
+		      ((brq->data.blocks * brq->data.blksz) >=
+		       card->ext_csd.data_tag_unit_size);
+
+	if (do_data_tag)
+		brq->data.flags |= MMC_DATA_DAT_TAG;
 
 	mmc_set_data_timeout(&brq->data, card);
 
@@ -1542,6 +1554,12 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	mqrq->areq.mrq = &brq->mrq;
 
 	mmc_queue_bounce_pre(mqrq);
+
+	if (do_rel_wr_p)
+		*do_rel_wr_p = do_rel_wr;
+
+	if (do_data_tag_p)
+		*do_data_tag_p = do_data_tag;
 }
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
-- 
1.9.1

