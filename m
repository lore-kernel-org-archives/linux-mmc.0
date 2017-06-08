From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6 v3] mmc: debugfs: Move EXT CSD debugfs access to block layer
Date: Thu,  8 Jun 2017 10:54:02 +0200
Message-ID: <20170608085403.11795-6-linus.walleij@linaro.org>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33223 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdFHIy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:27 -0400
Received: by mail-lf0-f46.google.com with SMTP id a136so15259914lfa.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:27 -0700 (PDT)
In-Reply-To: <20170608085403.11795-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Just like the previous commit moving status retriveal for
MMC and SD cards into the block layer (when active), this
moves the retrieveal of the EXT CSD from the card from
the special ext_csd file into the block stack as well.

It has been tested with and without the block layer and
during heavy load from dd.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes just resending
---
 drivers/mmc/core/block.c   | 21 +++++++++++++++++++++
 drivers/mmc/core/block.h   |  1 +
 drivers/mmc/core/debugfs.c |  4 +---
 drivers/mmc/core/queue.h   |  2 ++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 96fe0640c480..4708f95ebdd0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1176,6 +1176,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_blk_ioc_data **idata;
+	u8 **ext_csd;
 	u32 status;
 	int ret;
 	int i;
@@ -1211,6 +1212,10 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		if (!ret)
 			ret = status;
 		break;
+	case MMC_DRV_OP_GET_EXT_CSD:
+		ext_csd = mq_rq->drv_op_data;
+		ret = mmc_get_ext_csd(card, ext_csd);
+		break;
 	default:
 		pr_err("%s: unknown driver specific operation\n",
 		       md->disk->disk_name);
@@ -1982,6 +1987,22 @@ int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
 }
 EXPORT_SYMBOL(mmc_blk_card_status_get);
 
+/* Called from debugfs for MMC cards */
+int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd)
+{
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_queue *mq = &md->queue;
+	struct request *req;
+
+	/* Ask the block layer about the EXT CSD */
+	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_data = ext_csd;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	return req_to_mmc_queue_req(req)->drv_op_result;
+}
+EXPORT_SYMBOL(mmc_blk_get_ext_csd);
+
 static inline int mmc_blk_readonly(struct mmc_card *card)
 {
 	return mmc_card_readonly(card) ||
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 70861f3a059a..377ebbf6a978 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -6,5 +6,6 @@ struct request;
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 int mmc_blk_card_status_get(struct mmc_card *card, u64 *val);
+int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd);
 
 #endif
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index dca5717c437b..cc1f7085111c 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -305,9 +305,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	if (!buf)
 		return -ENOMEM;
 
-	mmc_get_card(card);
-	err = mmc_get_ext_csd(card, &ext_csd);
-	mmc_put_card(card);
+	err = mmc_blk_get_ext_csd(card, &ext_csd);
 	if (err)
 		goto out_free;
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index c2325c6659f5..04fc89360a7a 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -37,11 +37,13 @@ struct mmc_blk_request {
  * @MMC_DRV_OP_IOCTL: ioctl operation
  * @MMC_DRV_OP_BOOT_WP: write protect boot partitions
  * @MMC_DRV_OP_GET_CARD_STATUS: get card status
+ * @MMC_DRV_OP_GET_EXT_CSD: get the EXT CSD from an eMMC card
  */
 enum mmc_drv_op {
 	MMC_DRV_OP_IOCTL,
 	MMC_DRV_OP_BOOT_WP,
 	MMC_DRV_OP_GET_CARD_STATUS,
+	MMC_DRV_OP_GET_EXT_CSD,
 };
 
 struct mmc_queue_req {
-- 
2.9.4

