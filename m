From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] mmc: block: move packed command struct init
Date: Fri, 18 Nov 2016 13:36:16 +0100
Message-ID: <1479472576-2687-4-git-send-email-linus.walleij@linaro.org>
References: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36603 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKRMgc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 07:36:32 -0500
Received: by mail-wm0-f50.google.com with SMTP id g23so35518962wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 04:36:31 -0800 (PST)
In-Reply-To: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

By moving the mmc_packed_init() and mmc_packed_clean() into the
only file in the kernel where they are used, we save two exported
functions and can staticize those to the block.c file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.c | 43 -------------------------------------------
 drivers/mmc/card/queue.h |  3 ---
 3 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index eec4986a0175..ea9de876a846 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1432,6 +1432,49 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	return MMC_BLK_SUCCESS;
 }
 
+static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
+{
+	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
+	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
+	int ret = 0;
+
+
+	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
+	if (!mqrq_cur->packed) {
+		pr_warn("%s: unable to allocate packed cmd for mqrq_cur\n",
+			mmc_card_name(card));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
+	if (!mqrq_prev->packed) {
+		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
+			mmc_card_name(card));
+		kfree(mqrq_cur->packed);
+		mqrq_cur->packed = NULL;
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&mqrq_cur->packed->list);
+	INIT_LIST_HEAD(&mqrq_prev->packed->list);
+
+out:
+	return ret;
+}
+
+static void mmc_packed_clean(struct mmc_queue *mq)
+{
+	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
+	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
+
+	kfree(mqrq_cur->packed);
+	mqrq_cur->packed = NULL;
+	kfree(mqrq_prev->packed);
+	mqrq_prev->packed = NULL;
+}
+
 static enum mmc_blk_status mmc_blk_packed_err_check(struct mmc_card *card,
 						    struct mmc_async_req *areq)
 {
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8037f73a109a..3f6a2463ab30 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -362,49 +362,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
 
-int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
-{
-	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
-	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
-	int ret = 0;
-
-
-	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
-	if (!mqrq_cur->packed) {
-		pr_warn("%s: unable to allocate packed cmd for mqrq_cur\n",
-			mmc_card_name(card));
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	mqrq_prev->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
-	if (!mqrq_prev->packed) {
-		pr_warn("%s: unable to allocate packed cmd for mqrq_prev\n",
-			mmc_card_name(card));
-		kfree(mqrq_cur->packed);
-		mqrq_cur->packed = NULL;
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	INIT_LIST_HEAD(&mqrq_cur->packed->list);
-	INIT_LIST_HEAD(&mqrq_prev->packed->list);
-
-out:
-	return ret;
-}
-
-void mmc_packed_clean(struct mmc_queue *mq)
-{
-	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
-	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
-
-	kfree(mqrq_cur->packed);
-	mqrq_cur->packed = NULL;
-	kfree(mqrq_prev->packed);
-	mqrq_prev->packed = NULL;
-}
-
 /**
  * mmc_queue_suspend - suspend a MMC request queue
  * @mq: MMC queue to suspend
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 6ccadf88ef27..ae96eb223990 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -76,9 +76,6 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
 extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 
-extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
-extern void mmc_packed_clean(struct mmc_queue *);
-
 extern int mmc_access_rpmb(struct mmc_queue *);
 
 #endif
-- 
2.7.4

