Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C389C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8BA64DC4
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBOAdD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhBOAdC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2021 19:33:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AEC061756
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:32:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i20so4409865edv.2
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WgX9WWXAvotA5m/WT9R5T5lsWkQfEmiglyMRZjJBnkQ=;
        b=Ky7/cij5+zIC84ogBm8BADAIcrgkQilNLkmivvr+6QBCV0sRhq8vDfczYopzUbIrUI
         jFqditCF8E50GLoC/U59WyKGP+IDgdVnKapBlHPxRJromZZqfZluwKNyd+weyBxLrRLd
         2rn7HPk/aWZLfAzp09BQp+12D2gvce+cXV44iXNdTxYPfV7FtEmeuQUgvWCKswJYywgp
         uKEUpRrX+V/mTbbDjGtc7Mphl/YViy8MK3AxzNK+d8UAYx0tVC8yOpQNc9BLAxPOQCuc
         6n56LCzeFgiaC88EZVSTVoT/LXVBskmlFCkXfmf+1+ADl3r1v+jjhavTTkjTWcxPbacq
         Dyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WgX9WWXAvotA5m/WT9R5T5lsWkQfEmiglyMRZjJBnkQ=;
        b=jc2V+eWCuJroB9cwvCGPz1dnntN2/OWpsKqHyCzjS/ykCH8lIT/iqOOFcrf13hrgOQ
         GCpPvJWH2FSOFEyWwB6KVY8rYTCJ2mMCYunCxqYJ7F/bupD6gyE8gYoetHRv7b6UT9MQ
         jcDo9Ao2NWL19i1CBBn8IYOOPtYC5n5Iq7WMao/Mmw0o2j8E1iBhhrkkxcQS0OfTomft
         BciepxunRE5gfJB1cB4QlYCRFy8Swu9uTKvSBvvD5ppr3gd3y/+aB1Xzj453rkE1H/q/
         QmNQEEWSDKr2AWd9Q7Rcg++lvbFOYhNoKPS+pGpeaKDSBrdFdgGrhjp7q5Q5A3xxTSlX
         cLoA==
X-Gm-Message-State: AOAM532xzHPNQCogF4UkIUjXe51kkz17m7D8jlOaaT7vELHp7tZJwXu9
        qcDVaTnXrR2oVFcx+w9C2nWBq/8ncNw=
X-Google-Smtp-Source: ABdhPJyVZLz/0wGF6BlyiTzdAIGEUDwGBJ4njKvIiA+hI40qhOdu8mX0z4rRi0gNeZJER/8qOm20Xw==
X-Received: by 2002:a05:6402:b0f:: with SMTP id bm15mr13197418edb.133.1613349140562;
        Sun, 14 Feb 2021 16:32:20 -0800 (PST)
Received: from lupo-laptop (host-79-32-153-26.retail.telecomitalia.it. [79.32.153.26])
        by smtp.gmail.com with ESMTPSA id k2sm2729718ejv.99.2021.02.14.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:32:20 -0800 (PST)
From:   Luca Porzio <porzio@gmail.com>
X-Google-Original-From: Luca Porzio <lporzio@micron.com>
Date:   Mon, 15 Feb 2021 01:32:18 +0100
To:     linux-mmc@vger.kernel.org
Cc:     Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Subject: [RFC PATCH 1/2] remove field use_cqe in mmc_queue
Message-ID: <20210215003217.GA12240@lupo-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove usage of use_cqe parameter in mmc_queue
and use more appropriate mmc_host->cqe_enabled

Signed-off-by: Luca Porzio <lporzio@micron.com>
Signed-off-by: Zhan Liu <zliua@micron.com>
---
 drivers/mmc/core/block.c |  7 ++++---
 drivers/mmc/core/queue.c | 11 +++++------
 drivers/mmc/core/queue.h |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b877f62df366..08b3c4c4b9f6 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1933,8 +1933,9 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 void mmc_blk_mq_complete(struct request *req)
 {
 	struct mmc_queue *mq = req->q->queuedata;
+	struct mmc_host *host = mq->card->host;
 
-	if (mq->use_cqe)
+	if (host->cqe_enabled)
 		mmc_blk_cqe_complete_rq(mq, req);
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		mmc_blk_mq_complete_rq(mq, req);
@@ -2179,7 +2180,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
 
 static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 {
-	if (mq->use_cqe)
+	if (host->cqe_enabled)
 		return host->cqe_ops->cqe_wait_for_idle(host);
 
 	return mmc_blk_rw_wait(mq, NULL);
@@ -2228,7 +2229,7 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 			break;
 		case REQ_OP_READ:
 		case REQ_OP_WRITE:
-			if (mq->use_cqe)
+			if (host->cqe_enabled)
 				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
 			else
 				ret = mmc_blk_mq_issue_rw_rq(mq, req);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 27d2b8ed9484..d600e0a4a460 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -60,7 +60,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_host *host = mq->card->host;
 
-	if (mq->use_cqe && !host->hsq_enabled)
+	if (host->cqe_enabled && !host->hsq_enabled)
 		return mmc_cqe_issue_type(host, req);
 
 	if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
@@ -127,7 +127,7 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 	bool ignore_tout;
 
 	spin_lock_irqsave(&mq->lock, flags);
-	ignore_tout = mq->recovery_needed || !mq->use_cqe || host->hsq_enabled;
+	ignore_tout = mq->recovery_needed || !host->cqe_enabled || host->hsq_enabled;
 	spin_unlock_irqrestore(&mq->lock, flags);
 
 	return ignore_tout ? BLK_EH_RESET_TIMER : mmc_cqe_timed_out(req);
@@ -144,7 +144,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 
 	mq->in_recovery = true;
 
-	if (mq->use_cqe && !host->hsq_enabled)
+	if (host->cqe_enabled && !host->hsq_enabled)
 		mmc_blk_cqe_recovery(mq);
 	else
 		mmc_blk_mq_recovery(mq);
@@ -315,7 +315,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (get_card)
 		mmc_get_card(card, &mq->ctx);
 
-	if (mq->use_cqe) {
+	if (host->cqe_enabled) {
 		host->retune_now = host->need_retune && cqe_retune_ok &&
 				   !host->hold_retune;
 	}
@@ -430,7 +430,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	int ret;
 
 	mq->card = card;
-	mq->use_cqe = host->cqe_enabled;
 	
 	spin_lock_init(&mq->lock);
 
@@ -440,7 +439,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	 * The queue depth for CQE must match the hardware because the request
 	 * tag is used to index the hardware queue.
 	 */
-	if (mq->use_cqe && !host->hsq_enabled)
+	if (host->cqe_enabled && !host->hsq_enabled)
 		mq->tag_set.queue_depth =
 			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
 	else
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 57c59b6cb1b9..3319d8ab57d0 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -82,7 +82,6 @@ struct mmc_queue {
 	unsigned int		cqe_busy;
 #define MMC_CQE_DCMD_BUSY	BIT(0)
 	bool			busy;
-	bool			use_cqe;
 	bool			recovery_needed;
 	bool			in_recovery;
 	bool			rw_wait;
-- 
2.17.1

