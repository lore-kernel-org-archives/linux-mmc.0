Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C5C4332E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E912078B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWRptmxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSKzX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:55:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36861 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgCSKzX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 06:55:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so857249pjb.1;
        Thu, 19 Mar 2020 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2B71Ilx38FSmc8wtIe4i237uiN3P11n9fl8wswTG+HE=;
        b=uWRptmxyg3U3LYbhlzQ1GX5LHM29toqGAeh/iTGNMSJMaU6hU4GxvfC2mGdIKL5XOR
         8Ylc9TXDmov3+Eq2Z+zoh575WObZ6/cQ00Dh6MC6JwRRHUast/13omM0fYuSCvjQd4En
         vsg2mEIGf67A5JUZ1b3exnvLUIIQuJGI68cBW4gMmKGnhV7j07KX0EYKVDfJdIP/Es7T
         PlKra7VCaT+kpKUIO/PHVlaky0CQ5MBaOgoNeuTdcGLCn+Esnx11Jc0Ia+eYEHxcTDBh
         uIbPn2U8KEXVDMac/y2jJxF+TB5qOv9s3pLR9ruGqONw4QoclslkNZruKEwujOUHQOp9
         F7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2B71Ilx38FSmc8wtIe4i237uiN3P11n9fl8wswTG+HE=;
        b=t3NptdDftdjBIYlLdS7gny0GV5FF/g94+CwmMxYm/jFETa4pZ+GZnySEXZ0uox1La6
         wjwbLQTc2hYVrAARL/ap2Ye6+cIFnWp3MqXq9CM4j86kynjxpnsXSA6stHJxKn4WMv5C
         O6UkpiUfLxVZPucrGha67P2OQcD7Pt1kBCzV3OfGf7TyU66yhDCfR900ciM7V5I8y6rw
         e+kkJQu+tt4Mihnkk1nckMZZ+zKy0a+t1uUTlwJVmaEVsJL823ZQSTBvDa6yaTSmOS9d
         InoWIVhqHiRUpArt5kfRmueg1HJdhONUvG5U4Ou/dhxWt0aOxoyVIWEtcjK3CrlcNZea
         oxmw==
X-Gm-Message-State: ANhLgQ2zYW0Czv3w8GKMx1LQp8VaCbs14sJ85Mw48hhPcOnUCUOwGx3/
        VIEBZr3NEHFaHGXuodKdqq0=
X-Google-Smtp-Source: ADFU+vsFEpAuM+5N+ZYE6kuKGwTC3gEdyrqajza+qMi1FhU5I3Lk7C/a8gFJz6dQsVjg5slK2UalPw==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr3233621pjs.50.1584615321880;
        Thu, 19 Mar 2020 03:55:21 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f6sm2209949pfk.99.2020.03.19.03.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 03:55:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mmc: host: hsq: Handle an unusual case of returing busy
Date:   Thu, 19 Mar 2020 18:54:21 +0800
Message-Id: <c94b7e9a2fb48ac921fe41dba56df91efcdaa6c4.1584615043.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584615043.git.baolin.wang7@gmail.com>
References: <cover.1584615043.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is an unusual case that the card is busy when trying to send a
command, and we can not polling the card status in interrupt context
by using request_atomic() to dispatch requests.

Thus we should queue a work to try again in the non-atomic context
in case the host releases the busy signal later.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index fdbaa98..3edad11 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -15,11 +15,33 @@
 #define HSQ_NUM_SLOTS	64
 #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
 
+static void mmc_hsq_retry_handler(struct work_struct *work)
+{
+	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
+	struct mmc_host *mmc = hsq->mmc;
+	struct mmc_request *mrq = hsq->mrq;
+	struct mmc_data *data = mrq->data;
+
+	if (mmc->ops->request) {
+		mmc->ops->request(mmc, mrq);
+		return;
+	}
+
+	/*
+	 * If host does not supply the callback in normal context to
+	 * handle request, just finish this request.
+	 */
+	data->error = -EBUSY;
+	data->bytes_xfered = 0;
+	mmc_hsq_finalize_request(mmc, mrq);
+}
+
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
 	struct mmc_host *mmc = hsq->mmc;
 	struct hsq_slot *slot;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&hsq->lock, flags);
 
@@ -42,9 +64,21 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
 	if (mmc->ops->request_atomic)
-		mmc->ops->request_atomic(mmc, hsq->mrq);
+		ret = mmc->ops->request_atomic(mmc, hsq->mrq);
 	else
 		mmc->ops->request(mmc, hsq->mrq);
+
+	/*
+	 * If returning BUSY from request_atomic(), which means the card
+	 * may be busy now, and we should change to non-atomic context to
+	 * try again for this unusual case, to avoid time-consuming operations
+	 * in the atomic context.
+	 *
+	 * Note: we can ignore other error cases, since the host driver
+	 * will handle them.
+	 */
+	if (ret == -EBUSY)
+		schedule_work(&hsq->retry_work);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
@@ -327,6 +361,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
+	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
 
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index d51beb7..81f6c4f 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -12,6 +12,7 @@ struct mmc_hsq {
 	wait_queue_head_t wait_queue;
 	struct hsq_slot *slot;
 	spinlock_t lock;
+	struct work_struct retry_work;
 
 	int next_tag;
 	int num_slots;
-- 
1.9.1

