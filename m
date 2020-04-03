Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD11C43331
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A2620787
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MufWgAWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbgDCHFq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:05:46 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36280 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbgDCHFq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 03:05:46 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so2564110pjb.1;
        Fri, 03 Apr 2020 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CrZe3I4PBsnuaIeN4buPPytwyP1ByhSDiM4SeWiS8VM=;
        b=MufWgAWfvPyyz50E4MGAbCI4cA4XL24r3qP/DblFxOdU59p/85Lge88T3t66lyfi+F
         7R5fKLXAZAGk4aFAUGhBn7tDLKpYGaxtUrw0I2Qe5SZLaK/jmRVGnwEvYdiie0fWppQR
         wd+k/eGSaD/pk638UPDO32UPEFfrilGKJsWDiBCN4R5PXPehOGuDnsaH9BO4wAKrflc+
         pPixaPXAtJD+3FYFLnGpdw6PaheBWbzIzNDd+9/SjGUOALyu8jo7ra/rFdNG9LdlkE6y
         bXn+4aGMxa425vrfnvkTn6cSMJUOr7Zl6WCzjWphryJhCz5d9OvWyp9Nv5Oq6IVEC4sy
         8bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CrZe3I4PBsnuaIeN4buPPytwyP1ByhSDiM4SeWiS8VM=;
        b=eTk/bvtwWrg2La6SNd2uKJcXx4g8nq6lIH4HHIrvrka636NPYnG3DrMRbjQn5vrO89
         g//tEnbi+doV2TzBQkZ2vLElfMRPLSizD0pkzVAvXUNcaB5IMh11PZsNZEJ7cmw1VP1W
         9gHCGT4r39Zj49CLnp+YSIMD1dLI07JV+UFgSt0Dfky+WKpPflt9lfiFS+IlCE63CT5C
         FPgOW0GGV7yN8h3D8gitXVl8wEwuC1nbDEUKzQ5FZWmpOH8twToyDKFTfVSNssn89z1k
         jxWnUX09y6vFeqaPbCKbPFNWAkDjCmYg+Qq5xuyg/kHGff/5KA9UmRzUmKSaXzw+dWGO
         XwWQ==
X-Gm-Message-State: AGi0PuYyP4xz36Jn0/HGP9WqkKefDowZaFkwYZO/8sjVRvEONf8P325h
        CkjHZJW3VImQ0KNCBMSDnlk=
X-Google-Smtp-Source: APiQypJvf9N/GAQ/pZeL8u+QLoEXYsFUpcobXFllMB4c0bcfvpd7djx+HyVORGQY98kg28CSl8uQSw==
X-Received: by 2002:a17:90a:9f09:: with SMTP id n9mr7921682pjp.157.1585897544918;
        Fri, 03 Apr 2020 00:05:44 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u18sm5138701pfl.40.2020.04.03.00.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:05:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] mmc: host: Introduce the request_atomic() for the host
Date:   Fri,  3 Apr 2020 15:05:26 +0800
Message-Id: <04c25ff9f9b17d41d734c498e4be61dee745bb30.1585896945.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
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
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c | 29 ++++++++++++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h |  1 +
 include/linux/mmc/host.h   |  3 +++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index b90b2c9..a57f802 100644
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
+		WARN_ON_ONCE(ret && ret != -EBUSY);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
@@ -325,6 +351,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
+	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
 
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index 18b9cf5..ffdd9cd 100644
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
index c318fb5..d4a50e5d 100644
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
1.9.1

