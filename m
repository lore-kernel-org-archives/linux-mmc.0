From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6 v3] mmc: block: Anonymize the drv op data pointer
Date: Thu,  8 Jun 2017 10:53:58 +0200
Message-ID: <20170608085403.11795-2-linus.walleij@linaro.org>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35274 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdFHIyQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:16 -0400
Received: by mail-lf0-f48.google.com with SMTP id p189so15242591lfe.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:15 -0700 (PDT)
In-Reply-To: <20170608085403.11795-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

We have a data pointer for the ioctl() data, but we need to
pass other data along with the DRV_OP:s, so make this a
void * so it can be reused.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes just resending
---
 drivers/mmc/core/block.c | 8 +++++---
 drivers/mmc/core/queue.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 64f9fda92229..7a365d7641b5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -598,7 +598,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		__GFP_RECLAIM);
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
-	req_to_mmc_queue_req(req)->idata = idatas;
+	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
@@ -674,7 +674,7 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
-	req_to_mmc_queue_req(req)->idata = idata;
+	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
@@ -1175,6 +1175,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_blk_ioc_data **idata;
 	int ret;
 	int i;
 
@@ -1182,8 +1183,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 
 	switch (mq_rq->drv_op) {
 	case MMC_DRV_OP_IOCTL:
+		idata = mq_rq->drv_op_data;
 		for (i = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
 			if (ret)
 				break;
 		}
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 361b46408e0f..cf26a15a64bf 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -51,7 +51,7 @@ struct mmc_queue_req {
 	struct mmc_async_req	areq;
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
-	struct mmc_blk_ioc_data	**idata;
+	void			*drv_op_data;
 	unsigned int		ioc_count;
 };
 
-- 
2.9.4

