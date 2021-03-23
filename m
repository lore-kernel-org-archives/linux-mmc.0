Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9BC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 19:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FFB619C0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 19:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhCWTMI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:12:08 -0400
Received: from verein.lst.de ([213.95.11.211]:33853 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhCWTLy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Mar 2021 15:11:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61CEB68B02; Tue, 23 Mar 2021 20:11:45 +0100 (CET)
Date:   Tue, 23 Mar 2021 20:11:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     xiang fei <liuxiang1999@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        sagi@grimberg.me
Subject: Re: [PATCH] mmc: block: use REQ_HIPRI flag to complete request
 directly in own complete workqueue
Message-ID: <20210323191145.GA17657@lst.de>
References: <CAPPcxxS+L7HDUUrfnEWYHAZWWCZ4S7GA0MSQioFbZZ4xEOyGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPPcxxS+L7HDUUrfnEWYHAZWWCZ4S7GA0MSQioFbZZ4xEOyGcQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 23, 2021 at 11:40:47PM +0800, xiang fei wrote:
> Before the commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", block I/O request
> is completed in mmc_blk_mq_complete_work() and there is no problem.
> But after the commit, block I/O request is completed in softirq and it
> may cause the preemptoff
> problem as above.

I see how they are executed in softirq context, but I don't see how the
above commit could have introduce that.  It literally just refactored the
existing checks.

> The use of REQ_HIPRI flag is intended to execute rq->q->mq_ops->complete() in
> mmc_blk_mq_complete_work(), not in softirq.
> I just think it can avoid the preemptoff problem and not change too much.
> Maybe there is  a better way to solve the problem.

Well, there isn't really much of a point in bouncing to a softirq
context.  The patch below cleans the mmc completion code up to
avoid that internally, but for that it uses an API that right now
isn't intended for that kind of use.  I'm not sure yet it it just
needs updated documentation or maybe a different API.  Jens, any
comments?  Sagi, this might also make sense for nvme-tcp, doesn't it?

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d666e24fbe0e0a..7ad7a4efd10481 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1364,17 +1364,28 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 
 #define MMC_CQE_RETRIES 2
 
-static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_cqe_complete_rq(struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
 	struct mmc_host *host = mq->card->host;
 	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	unsigned long flags;
 	bool put_card;
 	int err;
 
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (!mq->in_recovery) {
+		if (unlikely(blk_should_fake_timeout(req->q)))
+			return;
+		blk_mq_set_request_complete(req);
+	}
+
 	mmc_cqe_post_req(host, mrq);
 
 	if (mrq->cmd && mrq->cmd->error)
@@ -1437,17 +1448,8 @@ static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
 	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
 						  brq.mrq);
 	struct request *req = mmc_queue_req_to_req(mqrq);
-	struct request_queue *q = req->q;
-	struct mmc_queue *mq = q->queuedata;
 
-	/*
-	 * Block layer timeouts race with completions which means the normal
-	 * completion path cannot be used during recovery.
-	 */
-	if (mq->in_recovery)
-		mmc_blk_cqe_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
+	mmc_blk_cqe_complete_rq(req);
 }
 
 static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
@@ -1864,6 +1866,16 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	unsigned int nr_bytes = mqrq->brq.data.bytes_xfered;
 
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (!mq->in_recovery) {
+		if (unlikely(blk_should_fake_timeout(req->q)))
+			return;
+		blk_mq_set_request_complete(req);
+	}
+
 	if (nr_bytes) {
 		if (blk_update_request(req, BLK_STS_OK, nr_bytes))
 			blk_mq_requeue_request(req, true);
@@ -1920,24 +1932,7 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 
 	mmc_blk_rw_reset_success(mq, req);
 
-	/*
-	 * Block layer timeouts race with completions which means the normal
-	 * completion path cannot be used during recovery.
-	 */
-	if (mq->in_recovery)
-		mmc_blk_cqe_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
-}
-
-void mmc_blk_mq_complete(struct request *req)
-{
-	struct mmc_queue *mq = req->q->queuedata;
-
-	if (mq->use_cqe)
-		mmc_blk_cqe_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		mmc_blk_mq_complete_rq(mq, req);
+	mmc_blk_cqe_complete_rq(req);
 }
 
 static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
@@ -1981,16 +1976,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	struct mmc_host *host = mq->card->host;
 
 	mmc_post_req(host, mrq, 0);
-
-	/*
-	 * Block layer timeouts race with completions which means the normal
-	 * completion path cannot be used during recovery.
-	 */
-	if (mq->in_recovery)
-		mmc_blk_mq_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
-
+	mmc_blk_mq_complete_rq(mq, req);
 	mmc_blk_mq_dec_in_flight(mq, req);
 }
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f4129..f15ab390f4f5b9 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -10,7 +10,6 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq);
 enum mmc_issued;
 
 enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
-void mmc_blk_mq_complete(struct request *req);
 void mmc_blk_mq_recovery(struct mmc_queue *mq);
 
 struct work_struct;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b899089..dbf4262d470fcf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -491,11 +491,7 @@ static inline int blk_mq_request_completed(struct request *rq)
 }
 
 /*
- * 
- * Set the state to complete when completing a request from inside ->queue_rq.
- * This is used by drivers that want to ensure special complete actions that
- * need access to the request are called on failure, e.g. by nvme for
- * multipathing.
+ * XXX: needs better documentation
  */
 static inline void blk_mq_set_request_complete(struct request *rq)
 {
