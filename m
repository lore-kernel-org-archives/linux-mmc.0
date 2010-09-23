From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 1/2] tmio_mmc: handle missing HW interrupts
Date: Thu, 23 Sep 2010 15:33:53 +0200
Message-ID: <1285248834-4434-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <spyro@f2s.com>, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

When doing excessive hotplug, e.g., repeated insert/eject operations,
the hardware may get confused to a point where no CMDTIMEOUT/CMDRESPEND
interrupts are generated any more.
As a result requests get stuck, e.g.:

[  360.351562] INFO: task kworker/u:0:5 blocked for more than 120 seconds.
[  360.351562] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  360.359375] kworker/u:0   D c020c2b4     0     5      2 0x00000000
[  360.367187] Backtrace:
[  360.367187] [<c020bfb0>] (schedule+0x0/0x340) from [<c020c480>] (schedule_timeout+0x20/0x190)
[  360.375000]  r8:c702fd70 r7:00000002 r6:c702e000 r5:c702fdc4 r4:7fffffff
[  360.375000] r3:c701e040
[  360.382812] [<c020c460>] (schedule_timeout+0x0/0x190) from [<c020be78>] (wait_for_common+0xc4/0x150)
[  360.390625]  r6:c702e000 r5:c702fdc4 r4:7fffffff
[  360.390625] [<c020bdb4>] (wait_for_common+0x0/0x150) from [<c020bfac>] (wait_for_completion+0x18/0x1c)
[  360.398437] [<c020bf94>] (wait_for_completion+0x0/0x1c) from [<c0185590>] (mmc_wait_for_req+0x214/0x234)
[  360.406250] [<c018537c>] (mmc_wait_for_req+0x0/0x234) from [<c01889d0>] (mmc_sd_switch+0xfc/0x114)
[  360.414062]  r7:c702fe4c r6:c702fe20 r5:c7179800 r4:00fffff0
[  360.421875] [<c01888d4>] (mmc_sd_switch+0x0/0x114) from [<c0187f70>] (mmc_sd_setup_card+0x260/0x384)
[  360.429687] [<c0187d10>] (mmc_sd_setup_card+0x0/0x384) from [<c01885e0>] (mmc_sd_init_card+0x13c/0x1e0)
[  360.437500] [<c01884a4>] (mmc_sd_init_card+0x0/0x1e0) from [<c01887a8>] (mmc_attach_sd+0x124/0x1a8)
[  360.445312]  r8:c02db404 r7:ffffff92 r6:c702ff34 r5:c6007da8 r4:c6007c00
[  360.453125] [<c0188684>] (mmc_attach_sd+0x0/0x1a8) from [<c0185140>] (mmc_rescan+0x248/0x2f0)
[  360.460937]  r5:c6007da8 r4:c6007c00
[  360.468750] [<c0184ef8>] (mmc_rescan+0x0/0x2f0) from [<c00467f0>] (process_one_work+0x1ec/0x318)
[  360.476562]  r7:c6007da8 r6:00000000 r5:c710ec00 r4:c701bde0
[  360.484375] [<c0046604>] (process_one_work+0x0/0x318) from [<c0047fb0>] (worker_thread+0x1b0/0x2cc)
[  360.492187] [<c0047e00>] (worker_thread+0x0/0x2cc) from [<c004b338>] (kthread+0x8c/0x94)
[  360.500000] [<c004b2ac>] (kthread+0x0/0x94) from [<c0037fc4>] (do_exit+0x0/0x590)
[  360.507812]  r7:00000013 r6:c0037fc4 r5:c004b2ac r4:c7021f00

This patch addresses this problem by introducing timeouts for outstanding
interrupts. If a hardware interrupt is missing, a soft reset will be performed
to bring the hardware back to a working state.
Tested with the SDHI hardware block in sh7372.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |   81 ++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/tmio_mmc.h |    7 ++++
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e7765a8..9a55afd 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -82,15 +82,60 @@ static void reset(struct tmio_mmc_host *host)
 	msleep(10);
 }
 
+static void tmio_mmc_reset_work(struct work_struct *work)
+{
+	struct tmio_mmc_host *host = container_of(work, struct tmio_mmc_host,
+						  delayed_reset_work.work);
+	struct mmc_request *mrq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	mrq = host->mrq;
+
+	/* request already finished */
+	if (!mrq
+	    || time_is_after_jiffies(host->last_req_ts +
+		msecs_to_jiffies(2000))) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	dev_warn(&host->pdev->dev,
+		"timeout waiting for hardware interrupt (CMD%u)\n",
+		mrq->cmd->opcode);
+
+	if (host->data)
+		host->data->error = -ETIMEDOUT;
+	else if (host->cmd)
+		host->cmd->error = -ETIMEDOUT;
+	else
+		mrq->cmd->error = -ETIMEDOUT;
+
+	host->cmd = NULL;
+	host->data = NULL;
+	host->mrq = NULL;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	reset(host);
+
+	mmc_request_done(host->mmc, mrq);
+}
+
 static void
 tmio_mmc_finish_request(struct tmio_mmc_host *host)
 {
 	struct mmc_request *mrq = host->mrq;
 
+	if (!mrq)
+		return;
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
 
+	cancel_delayed_work(&host->delayed_reset_work);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -200,6 +245,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	return;
 }
 
+/* needs to be called with host->lock held */
 static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_data *data = host->data;
@@ -254,10 +300,12 @@ static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 {
-	struct mmc_data *data = host->data;
+	struct mmc_data *data;
+	spin_lock(&host->lock);
+	data = host->data;
 
 	if (!data)
-		return;
+		goto out;
 
 	if (host->chan_tx && (data->flags & MMC_DATA_WRITE)) {
 		/*
@@ -278,6 +326,8 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	} else {
 		tmio_mmc_do_data_irq(host);
 	}
+out:
+	spin_unlock(&host->lock);
 }
 
 static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
@@ -286,9 +336,11 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	struct mmc_command *cmd = host->cmd;
 	int i, addr;
 
+	spin_lock(&host->lock);
+
 	if (!host->cmd) {
 		pr_debug("Spurious CMD irq\n");
-		return;
+		goto out;
 	}
 
 	host->cmd = NULL;
@@ -334,6 +386,9 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 		tmio_mmc_finish_request(host);
 	}
 
+out:
+	spin_unlock(&host->lock);
+
 	return;
 }
 
@@ -562,6 +617,12 @@ static void tmio_issue_tasklet_fn(unsigned long priv)
 static void tmio_tasklet_fn(unsigned long arg)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!host->data)
+		goto out;
 
 	if (host->data->flags & MMC_DATA_READ)
 		dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->dma_sglen,
@@ -571,6 +632,8 @@ static void tmio_tasklet_fn(unsigned long arg)
 			     DMA_TO_DEVICE);
 
 	tmio_mmc_do_data_irq(host);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 /* It might be necessary to make filter MFD specific */
@@ -694,6 +757,8 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (host->mrq)
 		pr_debug("request not null\n");
 
+	host->last_req_ts = jiffies;
+	wmb();
 	host->mrq = mrq;
 
 	if (mrq->data) {
@@ -703,10 +767,14 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	ret = tmio_mmc_start_command(host, mrq->cmd);
-	if (!ret)
+	if (!ret) {
+		schedule_delayed_work(&host->delayed_reset_work,
+				      msecs_to_jiffies(2000));
 		return;
+	}
 
 fail:
+	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
 }
@@ -896,6 +963,11 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	if (ret)
 		goto cell_disable;
 
+	spin_lock_init(&host->lock);
+
+	/* Init delayed work for request timeouts */
+	INIT_DELAYED_WORK(&host->delayed_reset_work, tmio_mmc_reset_work);
+
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(host, pdata);
 
@@ -936,6 +1008,7 @@ static int __devexit tmio_mmc_remove(struct platform_device *dev)
 		mmc_remove_host(mmc);
 		tmio_mmc_release_dma(host);
 		free_irq(host->irq, host);
+		cancel_delayed_work_sync(&host->delayed_reset_work);
 		if (cell->disable)
 			cell->disable(dev);
 		iounmap(host->ctl);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0fedc78..a40b477 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -12,6 +12,8 @@
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
 
 #define CTL_SD_CMD 0x00
 #define CTL_ARG_REG 0x04
@@ -116,6 +118,11 @@ struct tmio_mmc_host {
 	unsigned int            dma_sglen;
 	dma_cookie_t		cookie;
 #endif
+
+	/* Track lost interrupts */
+	struct delayed_work	delayed_reset_work;
+	spinlock_t		lock;
+	unsigned long		last_req_ts;
 };
 
 #include <linux/io.h>
-- 
1.7.0.4

