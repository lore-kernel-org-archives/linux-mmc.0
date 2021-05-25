Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E16C2B9F8
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5E36141B
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhEYJhf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhEYJhf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 05:37:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3EEC061574;
        Tue, 25 May 2021 02:36:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so19555259pgi.6;
        Tue, 25 May 2021 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAQ8nIZj/L/k8q7yFsMHi5/JFrCRshtxQkR6rH9Qus8=;
        b=ChqFXRNi+q7D4k8kudtWRdJ3FknWhQXMNd4TSvwFxws1VSzooU1XiFa/JeMpQAAHv1
         a16a+xOGN43+kxFgAgMpd1Vj6/POxnG1x/2yu1mmSdPPx/vhyI1Z3tjiDxdmDgtxGJux
         T2QKUczJJ61N8CDJdKfmIa1gBO1aTcbbLmIHRq7gl2fpQ3cHlaESLRfx5dXkimugZyFf
         4BBCalA6BjJrcThTbY1kCvWQqn00gRW6EoYg1dNhtOGNOcNu0ZAQ2OrCgu9k939g1zeS
         OjcVDYcbJrLus/HWvh+Z7U4IoFyjEbBkCGoXqk0/iuxVNWZh3aSwIpAjTVTZnz9mOkpZ
         C+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAQ8nIZj/L/k8q7yFsMHi5/JFrCRshtxQkR6rH9Qus8=;
        b=RKue2UlOx4DsyrlQQlRyj9JOSRx3IUf5gEMcbA4N4k8lMjEw8va4miPxzIpwxsweYx
         0dCXOeLr/Ui/cTEAzKshHTC6hx6sN/xZG04fZ0KrTBev3Hplifile0vatInz22hduO/s
         uTAB/4rmJ0nS0zWV+/AUPcRTTLwjJMQ/7WIWFhOrkxJbZsvdF9PgXNABWp0A+/wNl131
         Kxw0mXCgJ6XZpAdzm+wP87/HO1lMW94wBhoiFu+yCVwQRGqErU8IqiNBHIjciKTL1QZB
         9EfF1ZWDGWtlG6ZMGXxGmAXBPiACp2WlkrGw6RFg8QbqpBeCmdcN4EhYMZOC8qu2TMaM
         WqeA==
X-Gm-Message-State: AOAM531g3V7RBMCtsYa/0ydEuOZEPjt3PVlsZWnMGehWGxL5M+3azzUP
        miSpeuDc55PQtMGiai5W96s=
X-Google-Smtp-Source: ABdhPJzc8T8OURsXgPzvtj8PWgeGchMRU581KFyuJBGbAVL7JXGSDI/1GyT5R5xItmfZiZw/9Q3lUA==
X-Received: by 2002:a63:5448:: with SMTP id e8mr18113248pgm.170.1621935359828;
        Tue, 25 May 2021 02:35:59 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id y1sm13383189pfn.13.2021.05.25.02.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:35:59 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: Use host instead of mq parameter from mmc_issue_type()
Date:   Tue, 25 May 2021 17:35:10 +0800
Message-Id: <20210525093510.1373-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Note that the role of 'mq' parameter is just to get 'host' in
mmc_issue_type(). And all callers to this API have already 'host'
except mmc_blk_mq_dec_in_flight(). So, let's use existing 'host'
directly to make code simpler. Update related code at the same time.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/block.c | 6 +++---
 drivers/mmc/core/queue.c | 8 +++-----
 drivers/mmc/core/queue.h | 2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9a..4b6d4b0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1382,7 +1382,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct request_queue *q = req->q;
 	struct mmc_host *host = mq->card->host;
-	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
+	enum mmc_issue_type issue_type = mmc_issue_type(host, req);
 	unsigned long flags;
 	bool put_card;
 	int err;
@@ -1977,7 +1977,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[mmc_issue_type(mq->card->host, req)] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -2209,7 +2209,7 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		return MMC_REQ_FAILED_TO_START;
 
-	switch (mmc_issue_type(mq, req)) {
+	switch (mmc_issue_type(host, req)) {
 	case MMC_ISSUE_SYNC:
 		ret = mmc_blk_wait_for_idle(mq, host);
 		if (ret)
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d600e0a..3478f0a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -56,10 +56,8 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
 	}
 }
 
-enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
+enum mmc_issue_type mmc_issue_type(struct mmc_host *host, struct request *req)
 {
-	struct mmc_host *host = mq->card->host;
-
 	if (host->cqe_enabled && !host->hsq_enabled)
 		return mmc_cqe_issue_type(host, req);
 
@@ -97,7 +95,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_queue *mq = req->q->queuedata;
 	struct mmc_host *host = mq->card->host;
-	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
+	enum mmc_issue_type issue_type = mmc_issue_type(host, req);
 	bool recovery_needed = false;
 
 	switch (issue_type) {
@@ -259,7 +257,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_IOERR;
 	}
 
-	issue_type = mmc_issue_type(mq, req);
+	issue_type = mmc_issue_type(host, req);
 
 	spin_lock_irq(&mq->lock);
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 3319d8a..d41bacb 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -104,7 +104,7 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 void mmc_cqe_check_busy(struct mmc_queue *mq);
 void mmc_cqe_recovery_notifier(struct mmc_request *mrq);
 
-enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req);
+enum mmc_issue_type mmc_issue_type(struct mmc_host *host, struct request *req);
 
 static inline int mmc_tot_in_flight(struct mmc_queue *mq)
 {
-- 
1.9.1

