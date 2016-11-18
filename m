From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] mmc: block: rename data to blkdata
Date: Fri, 18 Nov 2016 13:36:15 +0100
Message-ID: <1479472576-2687-3-git-send-email-linus.walleij@linaro.org>
References: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35398 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKRMga (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 07:36:30 -0500
Received: by mail-wm0-f48.google.com with SMTP id a197so35535557wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 04:36:29 -0800 (PST)
In-Reply-To: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The struct mmc_blk_request contains an opaque void *data that
is actually only used to store a pointer to a per-request
struct mmc_blk_data. This is confusing, so rename the member
to blkdata and forward-declare the block.c local struct.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 20 ++++++++++----------
 drivers/mmc/card/queue.h |  3 ++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 56209d32ca5f..eec4986a0175 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1153,7 +1153,7 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 
 int mmc_access_rpmb(struct mmc_queue *mq)
 {
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	/*
 	 * If this is a RPMB partition access, return ture
 	 */
@@ -1165,7 +1165,7 @@ int mmc_access_rpmb(struct mmc_queue *mq)
 
 static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
 	int err = 0, type = MMC_BLK_DISCARD;
@@ -1209,7 +1209,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				       struct request *req)
 {
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
 	int err = 0, type = MMC_BLK_SECDISCARD;
@@ -1275,7 +1275,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 
 static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 {
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	int ret = 0;
 
@@ -1489,7 +1489,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	u32 readcmd, writecmd;
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mqrq->req;
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	bool do_data_tag;
 
 	/*
@@ -1662,7 +1662,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
 	struct request_queue *q = mq->queue;
 	struct mmc_card *card = mq->card;
 	struct request *cur = req, *next = NULL;
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_queue_req *mqrq = mq->mqrq_cur;
 	bool en_rel_wr = card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN;
 	unsigned int req_sectors = 0, phys_segments = 0;
@@ -1783,7 +1783,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mqrq->req;
 	struct request *prq;
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_packed *packed = mqrq->packed;
 	bool do_rel_wr, do_data_tag;
 	u32 *packed_cmd_hdr;
@@ -1954,7 +1954,7 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
 
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
@@ -2147,7 +2147,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	int ret;
-	struct mmc_blk_data *md = mq->data;
+	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_host *host = card->host;
 	unsigned long flags;
@@ -2265,7 +2265,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (ret)
 		goto err_putdisk;
 
-	md->queue.data = md;
+	md->queue.blkdata = md;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->first_minor = devidx * perdev_minors;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 3c15a75bae86..6ccadf88ef27 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -11,6 +11,7 @@ static inline bool mmc_req_is_special(struct request *req)
 
 struct request;
 struct task_struct;
+struct mmc_blk_data;
 
 struct mmc_blk_request {
 	struct mmc_request	mrq;
@@ -57,7 +58,7 @@ struct mmc_queue {
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
-	void			*data;
+	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
 	struct mmc_queue_req	mqrq[2];
 	struct mmc_queue_req	*mqrq_cur;
-- 
2.7.4

