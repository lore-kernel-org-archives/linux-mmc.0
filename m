Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D94C2BB55
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:27 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751B3206C3
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXHNHbBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751B3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgDMCq0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgDMCqZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 22:46:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEBC0086D3;
        Sun, 12 Apr 2020 19:46:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so3287836pje.5;
        Sun, 12 Apr 2020 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=22ImBzfhRquGecQMtA17MsJ6QqnzRdATqzouc8zKUW4=;
        b=jXHNHbBIKZQyh+pn1gZzQLnsgZPd6mgh17jpUu0Qapwzc6YkgGHOlUB7mkJ7yH3LFu
         zHaTD4+h2eSC4CtU9YY+ADDd6eGl6n9DGDDQ3DymOV0qJ1Il3wYtDvj31OQaB4VPEJ4l
         WYif2QzxCbbafKgVwaGoPV8Dy4BRxcBLQCawOry8NMdZK02xTLIMR9JVCn/S8llXCutK
         j1qMMdQxuqjIohQQczAY9pqW4/I9XQC47IcySa0Z+rW2Sq0ojlNZfYstGPlg1l7Cs9VA
         jFusr6tUxvp2178OPNLxZC07PQnm077K1jFt00MdY5k2YOSMYi2/lOh7wOhiHww9XGq/
         LV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=22ImBzfhRquGecQMtA17MsJ6QqnzRdATqzouc8zKUW4=;
        b=dVDqSUH1udpfwS9VBJ8u7eRVU3QEBa7HaY/6Dvr6FXTE6heyEUcPFCVC/i/6k57t8u
         GktNy1aQkMSkBLJzGilnLerf2du1GUR1E6rhtIzX0RZEjskqrfcE/LrL6I94iT3HMa5Y
         9ykplZIdsC765Asqs26o6zl1vVZjbuS7i6lQ0If6IBjvf0Dc4ppZM5wqMfM7os7LEMjC
         rxX4JP/a9mJr7K7waNeQuv/HTNSkcMnz45InqNAQ7ADm8Al9/j922sH41LjjjLWGu7lM
         sIGh2AHa8rr4dsIwFTK3cwzN6RHazP2eZ5qE6RzbSFsYqxat0swH5+Da6Rx62ssjR4ys
         OMpg==
X-Gm-Message-State: AGi0PuaXx5p4HgCK4ypdmMknxR3sMFz8cVpL2iALGnedYP/0Q17MZx44
        d3tqntpSx7/s2gmhXDCf3R6tFNYhtow=
X-Google-Smtp-Source: APiQypLMblVK7N+LEhbw3OkzGosNBCoLYuJm+bVEn6K/4G2fIB+BLitb7vthcQ6CFyYijvbT6N2Idg==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr2513673pjh.25.1586745985303;
        Sun, 12 Apr 2020 19:46:25 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id i15sm2327882pfe.197.2020.04.12.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 19:46:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] mmc: host: Introduce the request_atomic() for the host
Date:   Mon, 13 Apr 2020 10:46:03 +0800
Message-Id: <a344e27e506cb2329073cbd5cf65e15cc3cbeba9.1586744073.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SD host controller can process one request in the atomic context if
the card is nonremovable, which means we can submit next request in the
irq hard handler when using the MMC host software queue to reduce the
latency. Thus this patch adds a new API request_atomic() for the host
controller, as well as adding support for host software queue to submit
a request by the new request_atomic() API.

Moreover there is an unusual case that the card is busy when trying to
send a command, and we can not polling the card status in interrupt
context by using request_atomic() to dispatch requests. Thus we should
queue a work to try again in the non-atomic context in case the host
releases the busy signal later.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c | 29 ++++++++++++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h |  1 +
 include/linux/mmc/host.h   |  3 +++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index b90b2c97b6cf..a5e05ed0fda3 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -16,11 +16,20 @@
 #define HSQ_NUM_SLOTS	64
 #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
 
+static void mmc_hsq_retry_handler(struct work_struct *work)
+{
+	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
+	struct mmc_host *mmc = hsq->mmc;
+
+	mmc->ops->request(mmc, hsq->mrq);
+}
+
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
 	struct mmc_host *mmc = hsq->mmc;
 	struct hsq_slot *slot;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&hsq->lock, flags);
 
@@ -42,7 +51,24 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	mmc->ops->request(mmc, hsq->mrq);
+	if (mmc->ops->request_atomic)
+		ret = mmc->ops->request_atomic(mmc, hsq->mrq);
+	else
+		mmc->ops->request(mmc, hsq->mrq);
+
+	/*
+	 * If returning BUSY from request_atomic(), which means the card
+	 * may be busy now, and we should change to non-atomic context to
+	 * try again for this unusual case, to avoid time-consuming operations
+	 * in the atomic context.
+	 *
+	 * Note: we just give a warning for other error cases, since the host
+	 * driver will handle them.
+	 */
+	if (ret == -EBUSY)
+		schedule_work(&hsq->retry_work);
+	else
+		WARN_ON_ONCE(ret);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
@@ -325,6 +351,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
+	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
 
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index 18b9cf55925f..ffdd9cd172c3 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -12,6 +12,7 @@ struct mmc_hsq {
 	wait_queue_head_t wait_queue;
 	struct hsq_slot *slot;
 	spinlock_t lock;
+	struct work_struct retry_work;
 
 	int next_tag;
 	int num_slots;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c318fb5b6a94..d4a50e5dc111 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -92,6 +92,9 @@ struct mmc_host_ops {
 			    int err);
 	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
+	/* Submit one request to host in atomic context. */
+	int	(*request_atomic)(struct mmc_host *host,
+				  struct mmc_request *req);
 
 	/*
 	 * Avoid calling the next three functions too often or in a "fast
-- 
2.17.1

