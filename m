From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4 v2] mmc: debugfs: Move card status retrieveal into the block layer
Date: Mon,  5 Jun 2017 14:15:21 +0200
Message-ID: <20170605121522.27678-4-linus.walleij@linaro.org>
References: <20170605121522.27678-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34296 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdFEMPl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 08:15:41 -0400
Received: by mail-lf0-f43.google.com with SMTP id v20so37884533lfa.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jun 2017 05:15:40 -0700 (PDT)
In-Reply-To: <20170605121522.27678-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

This debugfs entry suffers from all the same starvation
issues as the other userspace things, under e.g. a heavy
dd operation.

It is therefore logical to move this over to the block layer
when it is enabled, using the new custom requests and issue
it using the block request queue.

This makes this debugfs card access land under the request
queue host lock instead of orthogonally taking the lock.

Tested during heavy dd load by cat:in the status file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on the new series, add no stubs.
---
 drivers/mmc/core/block.c   | 28 ++++++++++++++++++++++++++++
 drivers/mmc/core/block.h   |  1 +
 drivers/mmc/core/debugfs.c | 15 ++-------------
 drivers/mmc/core/queue.h   |  2 ++
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7a365d7641b5..96fe0640c480 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1176,6 +1176,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_blk_ioc_data **idata;
+	u32 status;
 	int ret;
 	int i;
 
@@ -1205,6 +1206,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 			card->ext_csd.boot_ro_lock |=
 				EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 		break;
+	case MMC_DRV_OP_GET_CARD_STATUS:
+		ret = mmc_send_status(card, &status);
+		if (!ret)
+			ret = status;
+		break;
 	default:
 		pr_err("%s: unknown driver specific operation\n",
 		       md->disk->disk_name);
@@ -1954,6 +1960,28 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		mmc_put_card(card);
 }
 
+/* Called from debugfs for MMC/SD cards */
+int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
+{
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_queue *mq = &md->queue;
+	struct request *req;
+	int ret;
+
+	/* Ask the block layer about the card status */
+	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	ret = req_to_mmc_queue_req(req)->drv_op_result;
+	if (ret >= 0) {
+		*val = ret;
+		ret = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mmc_blk_card_status_get);
+
 static inline int mmc_blk_readonly(struct mmc_card *card)
 {
 	return mmc_card_readonly(card) ||
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..70861f3a059a 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -5,5 +5,6 @@ struct mmc_queue;
 struct request;
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
+int mmc_blk_card_status_get(struct mmc_card *card, u64 *val);
 
 #endif
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index b176932b8092..dca5717c437b 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -22,6 +22,7 @@
 #include "core.h"
 #include "card.h"
 #include "host.h"
+#include "block.h"
 #include "mmc_ops.h"
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
@@ -285,19 +286,7 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
 
 static int mmc_dbg_card_status_get(void *data, u64 *val)
 {
-	struct mmc_card	*card = data;
-	u32		status;
-	int		ret;
-
-	mmc_get_card(card);
-
-	ret = mmc_send_status(data, &status);
-	if (!ret)
-		*val = status;
-
-	mmc_put_card(card);
-
-	return ret;
+	return mmc_blk_card_status_get(data, val);
 }
 DEFINE_SIMPLE_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
 		NULL, "%08llx\n");
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index cf26a15a64bf..c2325c6659f5 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -36,10 +36,12 @@ struct mmc_blk_request {
  * enum mmc_drv_op - enumerates the operations in the mmc_queue_req
  * @MMC_DRV_OP_IOCTL: ioctl operation
  * @MMC_DRV_OP_BOOT_WP: write protect boot partitions
+ * @MMC_DRV_OP_GET_CARD_STATUS: get card status
  */
 enum mmc_drv_op {
 	MMC_DRV_OP_IOCTL,
 	MMC_DRV_OP_BOOT_WP,
+	MMC_DRV_OP_GET_CARD_STATUS,
 };
 
 struct mmc_queue_req {
-- 
2.9.4

