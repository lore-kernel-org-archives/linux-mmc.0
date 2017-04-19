From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/5] mmc: sdio: Add API to manage SDIO IRQs from a workqueue
Date: Wed, 19 Apr 2017 23:17:08 +0200
Message-ID: <1492636631-28254-3-git-send-email-ulf.hansson@linaro.org>
References: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37069 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967325AbdDSVRX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 17:17:23 -0400
Received: by mail-wm0-f51.google.com with SMTP id m123so22019208wma.0
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 14:17:22 -0700 (PDT)
In-Reply-To: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

For hosts not supporting MMC_CAP2_SDIO_IRQ_NOTHREAD but MMC_CAP_SDIO_IRQ,
the SDIO IRQs are processed from a dedicated kernel thread. For these
cases, the host calls mmc_signal_sdio_irq() from its ISR to signal a new
SDIO IRQ.

Signaling an SDIO IRQ makes the host's ->enable_sdio_irq() callback to be
invoked to temporary disable the IRQs, before the kernel thread is woken up
to process it. When processing of the IRQs are completed, they are
re-enabled by the kernel thread, again via invoking the host's
->enable_sdio_irq().

The observation from this, is that the execution path is being unnecessary
complex, as the host driver already knows that it needs to temporary
disable the IRQs before signaling a new one. Moreover, replacing the kernel
thread with a work/workqueue would greatly simplify the code.

To address the above problems, let's continue to build upon the support for
MMC_CAP2_SDIO_IRQ_NOTHREAD, as it already implements SDIO IRQs to be
processed without using the clumsy kernel thread, but it also avoids the
ping-ponging calls of the host's ->enable_sdio_irq() callback for each
processed IRQ.

Therefore, let's add new API sdio_signal_irq(), which enables hosts to
signal/process SDIO IRQs by using a work/workqueue, rather than using the
kernel thread.

Add also a new host callback ->ack_sdio_irq(), which the work invokes when
the SDIO IRQs are processed. This informs the host about when it can
re-enable the SDIO IRQs. Potentially, we could re-use the existing
->enable_sdio_irq() callback for this matter, however it has turned out
that it's more convenient for hosts to get this information via a separate
callback.

Hosts needs to enable MMC_CAP2_SDIO_IRQ_NOTHREAD to use the work/workqueue
to process SDIO IRQs, however implementing the ->ack_sdio_irq() is optional.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c     |  2 ++
 drivers/mmc/core/sdio_irq.c | 21 +++++++++++++++++++++
 drivers/mmc/core/sdio_ops.h |  2 ++
 include/linux/mmc/host.h    |  3 +++
 4 files changed, 28 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3f8c85d..77058cb 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -30,6 +30,7 @@
 #include "host.h"
 #include "slot-gpio.h"
 #include "pwrseq.h"
+#include "sdio_ops.h"
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
@@ -379,6 +380,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
+	INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
 	setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
 
 	/*
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 44d9c86..8e28759 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -98,11 +98,32 @@ void sdio_run_irqs(struct mmc_host *host)
 	if (host->sdio_irqs) {
 		host->sdio_irq_pending = true;
 		process_sdio_pending_irqs(host);
+		if (host->ops->ack_sdio_irq)
+			host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
 EXPORT_SYMBOL_GPL(sdio_run_irqs);
 
+void sdio_irq_work(struct work_struct *work)
+{
+	struct mmc_host *host =
+		container_of(work, struct mmc_host, sdio_irq_work);
+
+	sdio_run_irqs(host);
+}
+
+void sdio_signal_irq(struct mmc_host *host)
+{
+	/*
+	 * The system_freezable_wq helps us to avoid processing IRQs while being
+	 * system PM suspended. Instead these IRQs becomes deferred and managed
+	 * when userspace is unfrozen.
+	 */
+	queue_work(system_freezable_wq, &host->sdio_irq_work);
+}
+EXPORT_SYMBOL_GPL(sdio_signal_irq);
+
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index bed8a83..836e405 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -17,6 +17,7 @@
 
 struct mmc_host;
 struct mmc_card;
+struct work_struct;
 
 int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
@@ -25,6 +26,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
 int sdio_reset(struct mmc_host *host);
 unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz);
+void sdio_irq_work(struct work_struct *work);
 
 static inline bool mmc_is_io_op(u32 opcode)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 21385ac..f03df539 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -130,6 +130,7 @@ struct mmc_host_ops {
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+	void	(*ack_sdio_irq)(struct mmc_host *host);
 
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
@@ -358,6 +359,7 @@ struct mmc_host {
 
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
+	struct work_struct	sdio_irq_work;
 	bool			sdio_irq_pending;
 	atomic_t		sdio_irq_thread_abort;
 
@@ -428,6 +430,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 }
 
 void sdio_run_irqs(struct mmc_host *host);
+void sdio_signal_irq(struct mmc_host *host);
 
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_get_ocrmask(struct regulator *supply);
-- 
2.7.4

