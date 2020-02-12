Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E6BC2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5D220842
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPnJFLYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgBLEOH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:14:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEOH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 23:14:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so510511pgk.2;
        Tue, 11 Feb 2020 20:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZxJCMYU77AAWIHEwAR4S3xMFnqF4iHEBRZ/uhlSn0JY=;
        b=ZPnJFLYUP1xeYi8krhe/DtcAKH9WbqjDqSLXBKbn9pgRM+s70XxHEqG9OAxlrDcTOH
         E3Ozx80YmXTTBDboKNCrLikLSvvKXrljQuPH2CGarj5rvQ1nFf4iMhfuZH5VB1ULMh65
         Q6NFOhk2rW06nOk+ebt1RGJmTTseFxmqc5PAmeYCfNWMU2QYrs/qsPOVDczLoHbBsztB
         bjb7/Wp6gEoeWssMInPYYVQ7TAHq9X4SC7ZNTxqj/6W7zO04QQbBI3t4ZVlVWoQpmZtZ
         xE0s4E5Dgv+ikbg96AkjutjspLY0a1qJrD0nbi7cTvK4IgmIq7ViriN+ldhElk5KsmqO
         vaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZxJCMYU77AAWIHEwAR4S3xMFnqF4iHEBRZ/uhlSn0JY=;
        b=qb79j8juLKvNIc3BtiThE4IGJl/EHWo3hXSdoChNNuCd85Aza3GRjgCqTUnMYhVjk9
         7i67xm4iY8C9eINsKY1ZeH4ESMAZKtXkuq+j8I/JZk3joB0mv0GR8FboYMXcsyHT3dTh
         6SnW/P8jSFBMAzVxXTlQXzd5p6QzNq2lC0x1mXzFIXA5+kBCB7d7vgmSgPee0sq/adem
         o/WaZs54WwoTnSu1PkmZEJYinDUg8Z80w3d4xIyMg02QYgdLB83LMZ3kiQd1MFNizdnu
         Gg8M/70FCw4qjlYHGeU4BfsMHgchhvIF0MshcM8ZXGiXGXw/UsLIYtETLfPR3aSsJ4bw
         teIA==
X-Gm-Message-State: APjAAAVCtgcwdxZ+ojuwafI+wdezgv1jQw9a9ylJFXcD5Ijj9PCoTgpt
        oQJkPWmlBlRjW1Biy95ZZmA=
X-Google-Smtp-Source: APXvYqyLGyJqgSes8gy8M5I/IPyc2GjsQABSai8QW8+M2atdesy7eMkvQD+j8HugrRkHlolGFaLrtQ==
X-Received: by 2002:a63:b257:: with SMTP id t23mr6339320pgo.17.1581480846451;
        Tue, 11 Feb 2020 20:14:06 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm6424762pfq.27.2020.02.11.20.14.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 20:14:05 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/5] mmc: Add MMC host software queue support
Date:   Wed, 12 Feb 2020 12:12:56 +0800
Message-Id: <4409c1586a9b3ed20d57ad2faf6c262fc3ccb6e2.1581478568.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead and spend some extra time to poll the card for busy completion
for I/O writes via sending CMD13, especially for high I/O per second
rates, to affect the IO performance.

Thus this patch introduces MMC software queue interface based on the
hardware command queue engine's interfaces, which is similar with the
hardware command queue engine's idea, that can remove the context
switching. Moreover we set the default queue depth as 64 for software
queue, which allows more requests to be prepared, merged and inserted
into IO scheduler to improve performance, but we only allow 2 requests
in flight, that is enough to let the irq handler always trigger the
next request without a context switch, as well as avoiding a long latency.

Moreover the host controller should support HW busy detection for I/O
operations when enabling the host software queue. That means, the host
controller must not complete a data transfer request, until after the
card stops signals busy.

From the fio testing data in cover letter, we can see the software
queue can improve some performance with 4K block size, increasing
about 16% for random read, increasing about 90% for random write,
though no obvious improvement for sequential read and write.

Moreover we can expand the software queue interface to support MMC
packed request or packed command in future.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/core/block.c   |   61 ++++++++
 drivers/mmc/core/mmc.c     |   18 ++-
 drivers/mmc/core/queue.c   |   22 ++-
 drivers/mmc/host/Kconfig   |    7 +
 drivers/mmc/host/Makefile  |    1 +
 drivers/mmc/host/cqhci.c   |    8 +-
 drivers/mmc/host/mmc_hsq.c |  343 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h |   30 ++++
 include/linux/mmc/host.h   |    3 +
 9 files changed, 481 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 663d879..55d52fc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -168,6 +168,11 @@ struct mmc_rpmb_data {
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      unsigned int part_type);
+static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
+			       struct mmc_card *card,
+			       int disable_multi,
+			       struct mmc_queue *mq);
+static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -1532,9 +1537,30 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 	return mmc_blk_cqe_start_req(mq->card->host, mrq);
 }
 
+static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+	int err;
+
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mqrq->brq.mrq.done = mmc_blk_hsq_req_done;
+	mmc_pre_req(host, &mqrq->brq.mrq);
+
+	err = mmc_cqe_start_req(host, &mqrq->brq.mrq);
+	if (err)
+		mmc_post_req(host, &mqrq->brq.mrq, err);
+
+	return err;
+}
+
 static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+
+	if (host->hsq_enabled)
+		return mmc_blk_hsq_issue_rw_rq(mq, req);
 
 	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
 
@@ -1920,6 +1946,41 @@ static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
 		mmc_run_bkops(mq->card);
 }
 
+static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq =
+		container_of(mrq, struct mmc_queue_req, brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	unsigned long flags;
+
+	if (mmc_blk_rq_error(&mqrq->brq) ||
+	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
+		spin_lock_irqsave(&mq->lock, flags);
+		mq->recovery_needed = true;
+		mq->recovery_req = req;
+		spin_unlock_irqrestore(&mq->lock, flags);
+
+		host->cqe_ops->cqe_recovery_start(host);
+
+		schedule_work(&mq->recovery_work);
+		return;
+	}
+
+	mmc_blk_rw_reset_success(mq, req);
+
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (mq->in_recovery)
+		mmc_blk_cqe_complete_rq(mq, req);
+	else
+		blk_mq_complete_request(req);
+}
+
 void mmc_blk_mq_complete(struct request *req)
 {
 	struct mmc_queue *mq = req->q->queuedata;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6912de..693921e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1851,15 +1851,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	card->reenable_cmdq = card->ext_csd.cmdq_en;
 
-	if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
+	if (host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
-		if (err) {
-			pr_err("%s: Failed to enable CQE, error %d\n",
-				mmc_hostname(host), err);
-		} else {
+		if (!err) {
 			host->cqe_enabled = true;
-			pr_info("%s: Command Queue Engine enabled\n",
-				mmc_hostname(host));
+
+			if (card->ext_csd.cmdq_en) {
+				pr_info("%s: Command Queue Engine enabled\n",
+					mmc_hostname(host));
+			} else {
+				host->hsq_enabled = true;
+				pr_info("%s: Host Software Queue enabled\n",
+					mmc_hostname(host));
+			}
 		}
 	}
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 9edc086..25bee3d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -62,7 +62,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_host *host = mq->card->host;
 
-	if (mq->use_cqe)
+	if (mq->use_cqe && !host->hsq_enabled)
 		return mmc_cqe_issue_type(host, req);
 
 	if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
@@ -124,12 +124,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 {
 	struct request_queue *q = req->q;
 	struct mmc_queue *mq = q->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	if (mq->recovery_needed || !mq->use_cqe)
+	if (mq->recovery_needed || !mq->use_cqe || host->hsq_enabled)
 		ret = BLK_EH_RESET_TIMER;
 	else
 		ret = mmc_cqe_timed_out(req);
@@ -144,12 +146,13 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	struct mmc_queue *mq = container_of(work, struct mmc_queue,
 					    recovery_work);
 	struct request_queue *q = mq->queue;
+	struct mmc_host *host = mq->card->host;
 
 	mmc_get_card(mq->card, &mq->ctx);
 
 	mq->in_recovery = true;
 
-	if (mq->use_cqe)
+	if (mq->use_cqe && !host->hsq_enabled)
 		mmc_blk_cqe_recovery(mq);
 	else
 		mmc_blk_mq_recovery(mq);
@@ -160,6 +163,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	mq->recovery_needed = false;
 	spin_unlock_irq(&mq->lock);
 
+	if (host->hsq_enabled)
+		host->cqe_ops->cqe_recovery_finish(host);
+
 	mmc_put_card(mq->card, &mq->ctx);
 
 	blk_mq_run_hw_queues(q, true);
@@ -279,6 +285,14 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 		break;
 	case MMC_ISSUE_ASYNC:
+		/*
+		 * For MMC host software queue, we only allow 2 requests in
+		 * flight to avoid a long latency.
+		 */
+		if (host->hsq_enabled && mq->in_flight[issue_type] > 2) {
+			spin_unlock_irq(&mq->lock);
+			return BLK_STS_RESOURCE;
+		}
 		break;
 	default:
 		/*
@@ -430,7 +444,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	 * The queue depth for CQE must match the hardware because the request
 	 * tag is used to index the hardware queue.
 	 */
-	if (mq->use_cqe)
+	if (mq->use_cqe && !host->hsq_enabled)
 		mq->tag_set.queue_depth =
 			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
 	else
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 3a5089f..65d3966 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -949,6 +949,13 @@ config MMC_CQHCI
 
 	  If unsure, say N.
 
+config MMC_HSQ
+	tristate "MMC Host Software Queue support"
+	help
+	  This selects the Software Queue support.
+
+	  If unsure, say N.
+
 config MMC_TOSHIBA_PCI
 	tristate "Toshiba Type A SD/MMC Card Interface Driver"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 21d9089..b929ef9 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
+obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 5047f73..e2ea2c4 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -321,14 +321,20 @@ static int cqhci_enable(struct mmc_host *mmc, struct mmc_card *card)
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	int err;
 
+	if (!card->ext_csd.cmdq_en)
+		return -EINVAL;
+
 	if (cq_host->enabled)
 		return 0;
 
 	cq_host->rca = card->rca;
 
 	err = cqhci_host_alloc_tdl(cq_host);
-	if (err)
+	if (err) {
+		pr_err("%s: Failed to enable CQE, error %d\n",
+		       mmc_hostname(mmc), err);
 		return err;
+	}
 
 	__cqhci_enable(cq_host);
 
diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
new file mode 100644
index 0000000..2011988
--- /dev/null
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MMC software queue support based on command queue interfaces
+ *
+ * Copyright (C) 2019 Linaro, Inc.
+ * Author: Baolin Wang <baolin.wang@linaro.org>
+ */
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include "mmc_hsq.h"
+
+#define HSQ_NUM_SLOTS	64
+#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
+
+static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
+{
+	struct mmc_host *mmc = hsq->mmc;
+	struct hsq_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	/* Make sure we are not already running a request now */
+	if (hsq->mrq) {
+		spin_unlock_irqrestore(&hsq->lock, flags);
+		return;
+	}
+
+	/* Make sure there are remain requests need to pump */
+	if (!hsq->qcnt || !hsq->enabled) {
+		spin_unlock_irqrestore(&hsq->lock, flags);
+		return;
+	}
+
+	slot = &hsq->slot[hsq->next_tag];
+	hsq->mrq = slot->mrq;
+	hsq->qcnt--;
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	mmc->ops->request(mmc, hsq->mrq);
+}
+
+static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
+{
+	struct hsq_slot *slot;
+	int tag;
+
+	/*
+	 * If there are no remain requests in software queue, then set a invalid
+	 * tag.
+	 */
+	if (!remains) {
+		hsq->next_tag = HSQ_INVALID_TAG;
+		return;
+	}
+
+	/*
+	 * Increasing the next tag and check if the corresponding request is
+	 * available, if yes, then we found a candidate request.
+	 */
+	if (++hsq->next_tag != HSQ_INVALID_TAG) {
+		slot = &hsq->slot[hsq->next_tag];
+		if (slot->mrq)
+			return;
+	}
+
+	/* Othersie we should iterate all slots to find a available tag. */
+	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
+		slot = &hsq->slot[tag];
+		if (slot->mrq)
+			break;
+	}
+
+	if (tag == HSQ_NUM_SLOTS)
+		tag = HSQ_INVALID_TAG;
+
+	hsq->next_tag = tag;
+}
+
+static void mmc_hsq_post_request(struct mmc_hsq *hsq)
+{
+	unsigned long flags;
+	int remains;
+
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	remains = hsq->qcnt;
+	hsq->mrq = NULL;
+
+	/* Update the next available tag to be queued. */
+	mmc_hsq_update_next_tag(hsq, remains);
+
+	if (hsq->waiting_for_idle && !remains) {
+		hsq->waiting_for_idle = false;
+		wake_up(&hsq->wait_queue);
+	}
+
+	/* Do not pump new request in recovery mode. */
+	if (hsq->recovery_halt) {
+		spin_unlock_irqrestore(&hsq->lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	 /*
+	  * Try to pump new request to host controller as fast as possible,
+	  * after completing previous request.
+	  */
+	if (remains > 0)
+		mmc_hsq_pump_requests(hsq);
+}
+
+/**
+ * mmc_hsq_finalize_request - finalize one request if the request is done
+ * @mmc: the host controller
+ * @mrq: the request need to be finalized
+ *
+ * Return true if we finalized the corresponding request in software queue,
+ * otherwise return false.
+ */
+bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	if (!hsq->enabled || !hsq->mrq || hsq->mrq != mrq) {
+		spin_unlock_irqrestore(&hsq->lock, flags);
+		return false;
+	}
+
+	/*
+	 * Clear current completed slot request to make a room for new request.
+	 */
+	hsq->slot[hsq->next_tag].mrq = NULL;
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	mmc_cqe_request_done(mmc, hsq->mrq);
+
+	mmc_hsq_post_request(hsq);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_finalize_request);
+
+static void mmc_hsq_recovery_start(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	hsq->recovery_halt = true;
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+}
+
+static void mmc_hsq_recovery_finish(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	int remains;
+
+	spin_lock_irq(&hsq->lock);
+
+	hsq->recovery_halt = false;
+	remains = hsq->qcnt;
+
+	spin_unlock_irq(&hsq->lock);
+
+	/*
+	 * Try to pump new request if there are request pending in software
+	 * queue after finishing recovery.
+	 */
+	if (remains > 0)
+		mmc_hsq_pump_requests(hsq);
+}
+
+static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	int tag = mrq->tag;
+
+	spin_lock_irq(&hsq->lock);
+
+	if (!hsq->enabled) {
+		spin_unlock_irq(&hsq->lock);
+		return -ESHUTDOWN;
+	}
+
+	/* Do not queue any new requests in recovery mode. */
+	if (hsq->recovery_halt) {
+		spin_unlock_irq(&hsq->lock);
+		return -EBUSY;
+	}
+
+	hsq->slot[tag].mrq = mrq;
+
+	/*
+	 * Set the next tag as current request tag if no available
+	 * next tag.
+	 */
+	if (hsq->next_tag == HSQ_INVALID_TAG)
+		hsq->next_tag = tag;
+
+	hsq->qcnt++;
+
+	spin_unlock_irq(&hsq->lock);
+
+	mmc_hsq_pump_requests(hsq);
+
+	return 0;
+}
+
+static void mmc_hsq_post_req(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	if (mmc->ops->post_req)
+		mmc->ops->post_req(mmc, mrq, 0);
+}
+
+static bool mmc_hsq_queue_is_idle(struct mmc_hsq *hsq, int *ret)
+{
+	bool is_idle;
+
+	spin_lock_irq(&hsq->lock);
+
+	is_idle = (!hsq->mrq && !hsq->qcnt) ||
+		hsq->recovery_halt;
+
+	*ret = hsq->recovery_halt ? -EBUSY : 0;
+	hsq->waiting_for_idle = !is_idle;
+
+	spin_unlock_irq(&hsq->lock);
+
+	return is_idle;
+}
+
+static int mmc_hsq_wait_for_idle(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	int ret;
+
+	wait_event(hsq->wait_queue,
+		   mmc_hsq_queue_is_idle(hsq, &ret));
+
+	return ret;
+}
+
+static void mmc_hsq_disable(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	u32 timeout = 500;
+	int ret;
+
+	spin_lock_irq(&hsq->lock);
+
+	if (!hsq->enabled) {
+		spin_unlock_irq(&hsq->lock);
+		return;
+	}
+
+	spin_unlock_irq(&hsq->lock);
+
+	ret = wait_event_timeout(hsq->wait_queue,
+				 mmc_hsq_queue_is_idle(hsq, &ret),
+				 msecs_to_jiffies(timeout));
+	if (ret == 0) {
+		pr_warn("could not stop mmc software queue\n");
+		return;
+	}
+
+	spin_lock_irq(&hsq->lock);
+
+	hsq->enabled = false;
+
+	spin_unlock_irq(&hsq->lock);
+}
+
+static int mmc_hsq_enable(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+
+	spin_lock_irq(&hsq->lock);
+
+	if (hsq->enabled) {
+		spin_unlock_irq(&hsq->lock);
+		return -EBUSY;
+	}
+
+	hsq->enabled = true;
+
+	spin_unlock_irq(&hsq->lock);
+
+	return 0;
+}
+
+static const struct mmc_cqe_ops mmc_hsq_ops = {
+	.cqe_enable = mmc_hsq_enable,
+	.cqe_disable = mmc_hsq_disable,
+	.cqe_request = mmc_hsq_request,
+	.cqe_post_req = mmc_hsq_post_req,
+	.cqe_wait_for_idle = mmc_hsq_wait_for_idle,
+	.cqe_recovery_start = mmc_hsq_recovery_start,
+	.cqe_recovery_finish = mmc_hsq_recovery_finish,
+};
+
+int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
+{
+	hsq->num_slots = HSQ_NUM_SLOTS;
+	hsq->next_tag = HSQ_INVALID_TAG;
+
+	hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
+				 sizeof(struct hsq_slot), GFP_KERNEL);
+	if (!hsq->slot)
+		return -ENOMEM;
+
+	hsq->mmc = mmc;
+	hsq->mmc->cqe_private = hsq;
+	mmc->cqe_ops = &mmc_hsq_ops;
+
+	spin_lock_init(&hsq->lock);
+	init_waitqueue_head(&hsq->wait_queue);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_init);
+
+void mmc_hsq_suspend(struct mmc_host *mmc)
+{
+	mmc_hsq_disable(mmc);
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_suspend);
+
+int mmc_hsq_resume(struct mmc_host *mmc)
+{
+	return mmc_hsq_enable(mmc, NULL);
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_resume);
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
new file mode 100644
index 0000000..d51beb7
--- /dev/null
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef LINUX_MMC_HSQ_H
+#define LINUX_MMC_HSQ_H
+
+struct hsq_slot {
+	struct mmc_request *mrq;
+};
+
+struct mmc_hsq {
+	struct mmc_host *mmc;
+	struct mmc_request *mrq;
+	wait_queue_head_t wait_queue;
+	struct hsq_slot *slot;
+	spinlock_t lock;
+
+	int next_tag;
+	int num_slots;
+	int qcnt;
+
+	bool enabled;
+	bool waiting_for_idle;
+	bool recovery_halt;
+};
+
+int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc);
+void mmc_hsq_suspend(struct mmc_host *mmc);
+int mmc_hsq_resume(struct mmc_host *mmc);
+bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq);
+
+#endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba70338..562ed06 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -462,6 +462,9 @@ struct mmc_host {
 	bool			cqe_enabled;
 	bool			cqe_on;
 
+	/* Host Software Queue support */
+	bool			hsq_enabled;
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.7.9.5

