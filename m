From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] mmc: Add virtual command queue support
Date: Fri,  6 Sep 2019 11:52:00 +0800
Message-ID: <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead, especially for high I/O per second rates, to affect the IO
performance.

Thus this patch introduces virtual command queue interface, which is
similar with the hardware command queue engine's idea, that can remove
the context switching. Moreover we set the queue depth as 2 for virtual
command queue, that is enough to let the irq handler always trigger
the next request without a context switch and then ask the blk_mq
layer for the next one to get queued, as well as avoiding a long
latency.

>From the fio testing data in cover letter, we can see the virtual
command queue can improve performance obviously with 4K block size,
increasing about 52% for sequential read, increasing about 114% for
random read, increasing about 81% for sequential write, and increasing
about 127% for random write.

Moreover we can expand the virtual command queue interface to
support MMC packed request or packed command in future.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/block.c      |   62 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    8 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci-virt.c |  346 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h      |   34 ++++
 include/linux/mmc/host.h      |    1 +
 8 files changed, 480 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci-virt.c

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a43..63d487f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -168,6 +168,11 @@ struct mmc_rpmb_data {
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      unsigned int part_type);
+static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
+			       struct mmc_card *card,
+			       int disable_multi,
+			       struct mmc_queue *mq);
+static void mmc_blk_virt_cqe_req_done(struct mmc_request *mrq);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -1569,9 +1574,31 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 	return mmc_blk_cqe_start_req(mq->card->host, mrq);
 }
 
+static int mmc_blk_virt_cqe_issue_rw_rq(struct mmc_queue *mq,
+					struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+	int err;
+
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mqrq->brq.mrq.done = mmc_blk_virt_cqe_req_done;
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
+	if (host->virt_cqe)
+		return mmc_blk_virt_cqe_issue_rw_rq(mq, req);
 
 	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
 
@@ -1957,6 +1984,41 @@ static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
 		mmc_run_bkops(mq->card);
 }
 
+static void mmc_blk_virt_cqe_req_done(struct mmc_request *mrq)
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
index c880489..316b0a6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1852,15 +1852,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	card->reenable_cmdq = card->ext_csd.cmdq_en;
 
-	if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
+	if (host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (err) {
 			pr_err("%s: Failed to enable CQE, error %d\n",
 				mmc_hostname(host), err);
 		} else {
 			host->cqe_enabled = true;
-			pr_info("%s: Command Queue Engine enabled\n",
-				mmc_hostname(host));
+
+			if (card->ext_csd.cmdq_en) {
+				pr_info("%s: Command Queue Engine enabled\n",
+					mmc_hostname(host));
+			} else {
+				host->virt_cqe = true;
+				pr_info("%s: Virtual Command Queue Engine enabled\n",
+					mmc_hostname(host));
+			}
 		}
 	}
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index e327f80..50d7fad 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -59,7 +59,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_host *host = mq->card->host;
 
-	if (mq->use_cqe)
+	if (mq->use_cqe && !host->virt_cqe)
 		return mmc_cqe_issue_type(host, req);
 
 	if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
@@ -121,12 +121,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 {
 	struct request_queue *q = req->q;
 	struct mmc_queue *mq = q->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	if (mq->recovery_needed || !mq->use_cqe)
+	if (mq->recovery_needed || !mq->use_cqe || host->virt_cqe)
 		ret = BLK_EH_RESET_TIMER;
 	else
 		ret = mmc_cqe_timed_out(req);
@@ -141,12 +143,13 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	struct mmc_queue *mq = container_of(work, struct mmc_queue,
 					    recovery_work);
 	struct request_queue *q = mq->queue;
+	struct mmc_host *host = mq->card->host;
 
 	mmc_get_card(mq->card, &mq->ctx);
 
 	mq->in_recovery = true;
 
-	if (mq->use_cqe)
+	if (mq->use_cqe && !host->virt_cqe)
 		mmc_blk_cqe_recovery(mq);
 	else
 		mmc_blk_mq_recovery(mq);
@@ -157,6 +160,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 	mq->recovery_needed = false;
 	spin_unlock_irq(&mq->lock);
 
+	if (host->virt_cqe)
+		host->cqe_ops->cqe_recovery_finish(host);
+
 	mmc_put_card(mq->card, &mq->ctx);
 
 	blk_mq_run_hw_queues(q, true);
@@ -406,11 +412,16 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	 * The queue depth for CQE must match the hardware because the request
 	 * tag is used to index the hardware queue.
 	 */
-	if (mq->use_cqe)
-		mq->tag_set.queue_depth =
-			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
-	else
+	if (mq->use_cqe) {
+		if (host->virt_cqe)
+			mq->tag_set.queue_depth = host->cqe_qdepth;
+		else
+			mq->tag_set.queue_depth =
+				min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	} else {
 		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
+	}
+
 	mq->tag_set.numa_node = NUMA_NO_NODE;
 	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 	mq->tag_set.nr_hw_queues = 1;
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a1..e2a12c3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -923,6 +923,14 @@ config MMC_CQHCI
 
 	  If unsure, say N.
 
+config MMC_VIRTUAL_CQHCI
+	bool "Virtual Command Queue Host Controller Interface support"
+	help
+	  This selects the Virtual Command Queue Host Controller Interface (VCQHCI)
+	  support.
+
+	  If unsure, say N.
+
 config MMC_TOSHIBA_PCI
 	tristate "Toshiba Type A SD/MMC Card Interface Driver"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7357871..3611c96 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
+obj-$(CONFIG_MMC_VIRTUAL_CQHCI)		+= cqhci-virt.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/cqhci-virt.c b/drivers/mmc/host/cqhci-virt.c
new file mode 100644
index 0000000..896c969
--- /dev/null
+++ b/drivers/mmc/host/cqhci-virt.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Virtual Command Queue Support
+//
+// Copyright (C) 2019 Linaro, Inc.
+// Author: Baolin Wang <baolin.wang@linaro.org>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+
+#include "cqhci.h"
+
+#define CQHCI_VIRT_NUM_SLOTS	2
+#define CQHCI_VIRT_INVALID_TAG	CQHCI_VIRT_NUM_SLOTS
+
+static void cqhci_virt_pump_requests(struct cqhci_host *cqv_host)
+{
+	struct mmc_host *mmc = cqv_host->mmc;
+	struct cqhci_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cqv_host->lock, flags);
+
+	/* Make sure we are not already running a request now */
+	if (cqv_host->mrq) {
+		spin_unlock_irqrestore(&cqv_host->lock, flags);
+		return;
+	}
+
+	/* Make sure there are remain requests need to pump */
+	if (!cqv_host->qcnt || !cqv_host->enabled) {
+		spin_unlock_irqrestore(&cqv_host->lock, flags);
+		return;
+	}
+
+	slot = &cqv_host->slot[cqv_host->next_tag];
+	cqv_host->mrq = slot->mrq;
+	cqv_host->qcnt--;
+
+	spin_unlock_irqrestore(&cqv_host->lock, flags);
+
+	mmc->ops->request(mmc, cqv_host->mrq);
+}
+
+static void cqhci_virt_update_next_tag(struct cqhci_host *cqv_host, int remains)
+{
+	struct cqhci_slot *slot;
+	int tag;
+
+	/*
+	 * If there are no remain requests in command queue, then set a invalid
+	 * tag.
+	 */
+	if (!remains) {
+		cqv_host->next_tag = CQHCI_VIRT_INVALID_TAG;
+		return;
+	}
+
+	/*
+	 * Increasing the next tag and check if the corresponding request is
+	 * available, if yes, then we found a candidate request.
+	 */
+	if (++cqv_host->next_tag != CQHCI_VIRT_INVALID_TAG) {
+		slot = &cqv_host->slot[cqv_host->next_tag];
+		if (slot->mrq)
+			return;
+	}
+
+	/* Othersie we should iterate all slots to find a available tag. */
+	for (tag = 0; tag < CQHCI_VIRT_NUM_SLOTS; tag++) {
+		slot = &cqv_host->slot[tag];
+		if (slot->mrq)
+			break;
+	}
+
+	if (tag == CQHCI_VIRT_NUM_SLOTS)
+		tag = CQHCI_VIRT_INVALID_TAG;
+
+	cqv_host->next_tag = tag;
+}
+
+static void cqhci_virt_post_request(struct cqhci_host *cqv_host)
+{
+	unsigned long flags;
+	int remains;
+
+	spin_lock_irqsave(&cqv_host->lock, flags);
+
+	remains = cqv_host->qcnt;
+	cqv_host->mrq = NULL;
+
+	/* Update the next available tag to be queued. */
+	cqhci_virt_update_next_tag(cqv_host, remains);
+
+	if (cqv_host->waiting_for_idle && !remains) {
+		cqv_host->waiting_for_idle = false;
+		wake_up(&cqv_host->wait_queue);
+	}
+
+	/* Do not pump new request in recovery mode. */
+	if (cqv_host->recovery_halt) {
+		spin_unlock_irqrestore(&cqv_host->lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&cqv_host->lock, flags);
+
+	 /*
+	  * Try to pump new request to host controller as fast as possible,
+	  * after completing previous request.
+	  */
+	if (remains > 0)
+		cqhci_virt_pump_requests(cqv_host);
+}
+
+/**
+ * cqhci_virt_finalize_request - finalize one request if the request is done
+ * @mmc: the host controller
+ * @mrq: the request need to be finalized
+ *
+ * Return true if we finalized the corresponding request in command queue,
+ * otherwise return false.
+ */
+bool cqhci_virt_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cqv_host->lock, flags);
+
+	if (!cqv_host->enabled || !cqv_host->mrq || cqv_host->mrq != mrq) {
+		spin_unlock_irqrestore(&cqv_host->lock, flags);
+		return false;
+	}
+
+	/*
+	 * Clear current completed slot request to make a room for new request.
+	 */
+	cqv_host->slot[cqv_host->next_tag].mrq = NULL;
+
+	spin_unlock_irqrestore(&cqv_host->lock, flags);
+
+	mmc_cqe_request_done(mmc, cqv_host->mrq);
+
+	cqhci_virt_post_request(cqv_host);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(cqhci_virt_finalize_request);
+
+static void cqhci_virt_recovery_start(struct mmc_host *mmc)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cqv_host->lock, flags);
+
+	cqv_host->recovery_halt = true;
+
+	spin_unlock_irqrestore(&cqv_host->lock, flags);
+}
+
+static void cqhci_virt_recovery_finish(struct mmc_host *mmc)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	int remains;
+
+	spin_lock_irq(&cqv_host->lock);
+
+	cqv_host->recovery_halt = false;
+	remains = cqv_host->qcnt;
+
+	spin_unlock_irq(&cqv_host->lock);
+
+	/*
+	 * Try to pump new request if there are request pending in command queue
+	 * after finishing recovery.
+	 */
+	if (remains > 0)
+		cqhci_virt_pump_requests(cqv_host);
+}
+
+static int cqhci_virt_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	int tag = mrq->tag;
+
+	spin_lock_irq(&cqv_host->lock);
+
+	if (!cqv_host->enabled) {
+		spin_unlock_irq(&cqv_host->lock);
+		return -ESHUTDOWN;
+	}
+
+	/* Do not queue any new requests in recovery mode. */
+	if (cqv_host->recovery_halt) {
+		spin_unlock_irq(&cqv_host->lock);
+		return -EBUSY;
+	}
+
+	cqv_host->slot[tag].mrq = mrq;
+
+	/*
+	 * Set the next tag as current request tag if no available
+	 * next tag.
+	 */
+	if (cqv_host->next_tag == CQHCI_VIRT_INVALID_TAG)
+		cqv_host->next_tag = tag;
+
+	cqv_host->qcnt++;
+
+	spin_unlock_irq(&cqv_host->lock);
+
+	cqhci_virt_pump_requests(cqv_host);
+
+	return 0;
+}
+
+static void cqhci_virt_post_req(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	if (mmc->ops->post_req)
+		mmc->ops->post_req(mmc, mrq, 0);
+}
+
+static bool cqhci_virt_queue_is_idle(struct cqhci_host *cqv_host, int *ret)
+{
+	bool is_idle;
+
+	spin_lock_irq(&cqv_host->lock);
+
+	is_idle = (!cqv_host->mrq && !cqv_host->qcnt) ||
+		cqv_host->recovery_halt;
+
+	*ret = cqv_host->recovery_halt ? -EBUSY : 0;
+	cqv_host->waiting_for_idle = !is_idle;
+
+	spin_unlock_irq(&cqv_host->lock);
+
+	return is_idle;
+}
+
+static int cqhci_virt_wait_for_idle(struct mmc_host *mmc)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	int ret;
+
+	wait_event(cqv_host->wait_queue,
+		   cqhci_virt_queue_is_idle(cqv_host, &ret));
+
+	return ret;
+}
+
+static void cqhci_virt_disable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+	u32 timeout = 500;
+	int ret;
+
+	spin_lock_irq(&cqv_host->lock);
+
+	if (!cqv_host->enabled) {
+		spin_unlock_irq(&cqv_host->lock);
+		return;
+	}
+
+	spin_unlock_irq(&cqv_host->lock);
+
+	ret = wait_event_timeout(cqv_host->wait_queue,
+				 cqhci_virt_queue_is_idle(cqv_host, &ret),
+				 msecs_to_jiffies(timeout));
+	if (ret == 0) {
+		pr_warn("could not stop mmc virtual command queue\n");
+		return;
+	}
+
+	spin_lock_irq(&cqv_host->lock);
+
+	cqv_host->enabled = false;
+
+	spin_unlock_irq(&cqv_host->lock);
+}
+
+static int cqhci_virt_enable(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct cqhci_host *cqv_host = mmc->cqe_private;
+
+	spin_lock_irq(&cqv_host->lock);
+
+	if (cqv_host->enabled) {
+		spin_unlock_irq(&cqv_host->lock);
+		return -EBUSY;
+	}
+
+	cqv_host->enabled = true;
+
+	spin_unlock_irq(&cqv_host->lock);
+
+	return 0;
+}
+
+static const struct mmc_cqe_ops cqhci_virt_ops = {
+	.cqe_enable = cqhci_virt_enable,
+	.cqe_disable = cqhci_virt_disable,
+	.cqe_request = cqhci_virt_request,
+	.cqe_post_req = cqhci_virt_post_req,
+	.cqe_wait_for_idle = cqhci_virt_wait_for_idle,
+	.cqe_recovery_start = cqhci_virt_recovery_start,
+	.cqe_recovery_finish = cqhci_virt_recovery_finish,
+};
+
+int cqhci_virt_init(struct cqhci_host *cqv_host, struct mmc_host *mmc)
+{
+	cqv_host->num_slots = CQHCI_VIRT_NUM_SLOTS;
+	cqv_host->next_tag = CQHCI_VIRT_INVALID_TAG;
+	mmc->cqe_qdepth = CQHCI_VIRT_NUM_SLOTS;
+
+	cqv_host->slot = devm_kcalloc(mmc_dev(mmc), cqv_host->num_slots,
+				      sizeof(struct cqhci_slot), GFP_KERNEL);
+	if (!cqv_host->slot)
+		return -ENOMEM;
+
+	cqv_host->mmc = mmc;
+	cqv_host->mmc->cqe_private = cqv_host;
+	mmc->cqe_ops = &cqhci_virt_ops;
+
+	spin_lock_init(&cqv_host->lock);
+	init_waitqueue_head(&cqv_host->wait_queue);
+
+	pr_info("%s: Enable virtual command queue\n", mmc_hostname(mmc));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cqhci_virt_init);
+
+void cqhci_virt_suspend(struct mmc_host *mmc)
+{
+	cqhci_virt_disable(mmc);
+}
+EXPORT_SYMBOL_GPL(cqhci_virt_suspend);
+
+int cqhci_virt_resume(struct mmc_host *mmc)
+{
+	return cqhci_virt_enable(mmc, NULL);
+}
+EXPORT_SYMBOL_GPL(cqhci_virt_resume);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 7b07bf24f..cd8e1a8 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -205,6 +205,10 @@ struct cqhci_host {
 	struct completion halt_comp;
 	wait_queue_head_t wait_queue;
 	struct cqhci_slot *slot;
+
+	/* virtual command queue support */
+	int next_tag;
+	struct mmc_request *mrq;
 };
 
 struct cqhci_host_ops {
@@ -242,4 +246,34 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 int cqhci_suspend(struct mmc_host *mmc);
 int cqhci_resume(struct mmc_host *mmc);
 
+#ifdef CONFIG_MMC_VIRTUAL_CQHCI
+int cqhci_virt_init(struct cqhci_host *cqv_host, struct mmc_host *mmc);
+void cqhci_virt_suspend(struct mmc_host *mmc);
+int cqhci_virt_resume(struct mmc_host *mmc);
+bool cqhci_virt_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq);
+#else
+static inline int cqhci_virt_init(struct cqhci_host *cqv_host,
+				  struct mmc_host *mmc)
+{
+	return 0;
+}
+
+static inline void cqhci_virt_suspend(struct mmc_host *mmc)
+{
+
+}
+
+static inline int cqhci_virt_resume(struct mmc_host *mmc)
+{
+	return 0;
+}
+
+static inline bool cqhci_virt_finalize_request(struct mmc_host *mmc,
+					       struct mmc_request *mrq)
+{
+	return false;
+}
+
+#endif
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d8115db7..26213fd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -458,6 +458,7 @@ struct mmc_host {
 	int			cqe_qdepth;
 	bool			cqe_enabled;
 	bool			cqe_on;
+	bool			virt_cqe;
 
 	unsigned long		private[0] ____cacheline_aligned;
 };
-- 
1.7.9.5
