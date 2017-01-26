From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 09/13] mmc: bcm2835: switch locking to mutex
Date: Fri, 27 Jan 2017 00:37:22 +0100
Message-ID: <1485473846-24537-10-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

so we can sleep now in most bcm2835 code.
especially bcm2835_finish_command can always sleep.

FIXME: timeout timer seems to run in irq context.
FIXME: tasklet seems to run in irq context too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 74 +++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 2bea4e0..5c588d9 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -136,6 +136,7 @@
 
 struct bcm2835_host {
 	spinlock_t		lock;
+	struct mutex            mutex;
 
 	void __iomem		*ioaddr;
 	u32			phys_addr;
@@ -278,8 +279,7 @@ static void bcm2835_reset(struct mmc_host *mmc)
 	bcm2835_reset_internal(host);
 }
 
-static void bcm2835_finish_command(struct bcm2835_host *host,
-				   unsigned long *irq_flags);
+static void bcm2835_finish_command(struct bcm2835_host *host);
 
 static void bcm2835_wait_transfer_complete(struct bcm2835_host *host)
 {
@@ -325,9 +325,8 @@ static void bcm2835_dma_complete(void *param)
 {
 	struct bcm2835_host *host = param;
 	struct mmc_data *data = host->data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	if (host->dma_chan) {
 		dma_unmap_sg(host->dma_chan->device->dev,
@@ -357,7 +356,7 @@ static void bcm2835_dma_complete(void *param)
 
 	bcm2835_finish_data(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 }
 
 static void bcm2835_transfer_block_pio(struct bcm2835_host *host,
@@ -744,7 +743,7 @@ static void bcm2835_transfer_complete(struct bcm2835_host *host)
 		if (bcm2835_send_command(host, host->mrq->stop)) {
 			/* No busy, so poll for completion */
 			if (!host->use_busy)
-				bcm2835_finish_command(host, NULL);
+				bcm2835_finish_command(host);
 		}
 	} else {
 		bcm2835_wait_transfer_complete(host);
@@ -782,11 +781,7 @@ static void bcm2835_finish_data(struct bcm2835_host *host)
 	}
 }
 
-/* If irq_flags is valid, the caller is in a thread context and is
- * allowed to sleep
- */
-static void bcm2835_finish_command(struct bcm2835_host *host,
-				   unsigned long *irq_flags)
+static void bcm2835_finish_command(struct bcm2835_host *host)
 {
 	struct device *dev = &host->pdev->dev;
 	struct mmc_command *cmd = host->cmd;
@@ -837,18 +832,10 @@ static void bcm2835_finish_command(struct bcm2835_host *host,
 	if (!retries) {
 		unsigned long wait_max;
 
-		if (!irq_flags) {
-			/* Schedule the work */
-			schedule_work(&host->cmd_wait_wq);
-			return;
-		}
-
 		/* Wait max 100 ms */
 		wait_max = jiffies + msecs_to_jiffies(100);
 		while (time_before(jiffies, wait_max)) {
-			spin_unlock_irqrestore(&host->lock, *irq_flags);
 			usleep_range(1, 10);
-			spin_lock_irqsave(&host->lock, *irq_flags);
 			sdcmd = readl(host->ioaddr + SDCMD);
 			if (!(sdcmd & SDCMD_NEW_FLAG) ||
 			    (sdcmd & SDCMD_FAIL_FLAG))
@@ -913,7 +900,7 @@ static void bcm2835_finish_command(struct bcm2835_host *host,
 				bcm2835_start_dma(host);
 
 			if (!host->use_busy)
-				bcm2835_finish_command(host, NULL);
+				bcm2835_finish_command(host);
 		}
 	} else if (cmd == host->mrq->stop) {
 		/* Finished CMD12 */
@@ -932,9 +919,8 @@ static void bcm2835_timeout(unsigned long data)
 {
 	struct bcm2835_host *host = (struct bcm2835_host *)data;
 	struct device *dev = &host->pdev->dev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	if (host->mrq) {
 		dev_err(dev, "timeout waiting for hardware interrupt.\n");
@@ -953,7 +939,8 @@ static void bcm2835_timeout(unsigned long data)
 			tasklet_schedule(&host->finish_tasklet);
 		}
 	}
-	spin_unlock_irqrestore(&host->lock, flags);
+
+	mutex_unlock(&host->mutex);
 }
 
 static bool bcm2835_check_cmd_error(struct bcm2835_host *host, u32 intmask)
@@ -1011,7 +998,7 @@ static void bcm2835_busy_irq(struct bcm2835_host *host)
 	}
 	host->use_busy = false;
 
-	bcm2835_finish_command(host, NULL);
+	bcm2835_finish_command(host);
 }
 
 static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
@@ -1137,6 +1124,10 @@ static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
 	host->irq_busy  = false;
 	host->irq_data  = false;
 
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mutex_lock(&host->mutex);
+
 	if (block)
 		bcm2835_block_irq(host);
 	if (busy)
@@ -1144,7 +1135,7 @@ static irqreturn_t bcm2835_threaded_irq(int irq, void *dev_id)
 	if (data)
 		bcm2835_data_threaded_irq(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 
 	return IRQ_HANDLED;
 }
@@ -1215,7 +1206,6 @@ static void bcm2835_request(struct mmc_host *mmc,
 {
 	struct bcm2835_host *host = mmc_priv(mmc);
 	struct device *dev = &host->pdev->dev;
-	unsigned long flags;
 	u32 edm, fsm;
 
 	/* Reset the error statuses in case this is a retry */
@@ -1240,7 +1230,7 @@ static void bcm2835_request(struct mmc_host *mmc,
 	    (mrq->data->blocks > host->pio_limit))
 		bcm2835_prepare_dma(host, mrq->data);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	WARN_ON(host->mrq);
 	host->mrq = mrq;
@@ -1256,7 +1246,7 @@ static void bcm2835_request(struct mmc_host *mmc,
 		bcm2835_dumpregs(host);
 		mrq->cmd->error = -EILSEQ;
 		tasklet_schedule(&host->finish_tasklet);
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->mutex);
 		return;
 	}
 
@@ -1264,7 +1254,7 @@ static void bcm2835_request(struct mmc_host *mmc,
 	if (host->use_sbc) {
 		if (bcm2835_send_command(host, mrq->sbc)) {
 			if (!host->use_busy)
-				bcm2835_finish_command(host, &flags);
+				bcm2835_finish_command(host);
 		}
 	} else if (bcm2835_send_command(host, mrq->cmd)) {
 		if (host->data && host->dma_desc) {
@@ -1273,18 +1263,17 @@ static void bcm2835_request(struct mmc_host *mmc,
 		}
 
 		if (!host->use_busy)
-			bcm2835_finish_command(host, &flags);
+			bcm2835_finish_command(host);
 	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 }
 
 static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct bcm2835_host *host = mmc_priv(mmc);
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	if (!ios->clock || ios->clock != host->clock) {
 		bcm2835_set_clock(host, ios->clock);
@@ -1303,7 +1292,7 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	writel(host->hcfg, host->ioaddr + SDHCFG);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 }
 
 static struct mmc_host_ops bcm2835_ops = {
@@ -1315,39 +1304,37 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static void bcm2835_cmd_wait_work(struct work_struct *work)
 {
 	struct bcm2835_host *host;
-	unsigned long flags;
 
 	host = container_of(work, struct bcm2835_host, cmd_wait_wq);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	/* If this tasklet gets rescheduled while running, it will
 	 * be run again afterwards but without any active request.
 	 */
 	if (!host->mrq) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->mutex);
 		return;
 	}
 
-	bcm2835_finish_command(host, &flags);
+	bcm2835_finish_command(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 }
 
 static void bcm2835_tasklet_finish(unsigned long param)
 {
 	struct bcm2835_host *host = (struct bcm2835_host *)param;
-	unsigned long flags;
 	struct mmc_request *mrq;
 	struct dma_chan *terminate_chan = NULL;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->mutex);
 
 	/* If this tasklet gets rescheduled while running, it will
 	 * be run again afterwards but without any active request.
 	 */
 	if (!host->mrq) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->mutex);
 		return;
 	}
 
@@ -1363,7 +1350,7 @@ static void bcm2835_tasklet_finish(unsigned long param)
 	terminate_chan = host->dma_chan;
 	host->dma_chan = NULL;
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->mutex);
 
 	if (terminate_chan) {
 		int err = dmaengine_terminate_all(terminate_chan);
@@ -1400,6 +1387,7 @@ int bcm2835_add_host(struct bcm2835_host *host)
 		     MMC_CAP_CMD23;
 
 	spin_lock_init(&host->lock);
+	mutex_init(&host->mutex);
 
 	if (IS_ERR_OR_NULL(host->dma_chan_tx) ||
 	    IS_ERR_OR_NULL(host->dma_chan_rx)) {
-- 
1.8.3.1
