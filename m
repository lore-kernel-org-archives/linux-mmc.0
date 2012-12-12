From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 10/14] mmc: sh-mmcif: fix a race, causing an Oops on SMP
Date: Wed, 12 Dec 2012 15:38:14 +0100
Message-ID: <1355323098-18061-11-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Oopses have been observed on SMP in the sh-mmcif IRQ thread, when the two
IRQ threads run simultaneously on two CPUs. Also take care to guard the
timeout work and the DMA completion callback from possible NULL-pointer
dereferences and races.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1a7c602..96ab2e1 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -56,6 +56,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -196,6 +197,7 @@ enum mmcif_state {
 	STATE_IDLE,
 	STATE_REQUEST,
 	STATE_IOS,
+	STATE_TIMEOUT,
 };
 
 enum mmcif_wait_for {
@@ -232,6 +234,7 @@ struct sh_mmcif_host {
 	int sg_blkidx;
 	bool power;
 	bool card_present;
+	struct mutex thread_lock;
 
 	/* DMA support */
 	struct dma_chan		*chan_rx;
@@ -255,11 +258,11 @@ static inline void sh_mmcif_bitclr(struct sh_mmcif_host *host,
 static void mmcif_dma_complete(void *arg)
 {
 	struct sh_mmcif_host *host = arg;
-	struct mmc_data *data = host->mrq->data;
+	struct mmc_request *mrq = host->mrq;
 
 	dev_dbg(&host->pd->dev, "Command completed\n");
 
-	if (WARN(!data, "%s: NULL data in DMA completion!\n",
+	if (WARN(!mrq || !mrq->data, "%s: NULL data in DMA completion!\n",
 		 dev_name(&host->pd->dev)))
 		return;
 
@@ -1113,11 +1116,21 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
-	struct mmc_request *mrq = host->mrq;
+	struct mmc_request *mrq;
 	bool wait = false;
 
 	cancel_delayed_work_sync(&host->timeout_work);
 
+	mutex_lock(&host->thread_lock);
+
+	mrq = host->mrq;
+	if (!mrq) {
+		dev_dbg(&host->pd->dev, "IRQ thread state %u, wait %u: NULL mrq!\n",
+			host->state, host->wait_for);
+		mutex_unlock(&host->thread_lock);
+		return IRQ_HANDLED;
+	}
+
 	/*
 	 * All handlers return true, if processing continues, and false, if the
 	 * request has to be completed - successfully or not
@@ -1125,6 +1138,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	switch (host->wait_for) {
 	case MMCIF_WAIT_FOR_REQUEST:
 		/* We're too late, the timeout has already kicked in */
+		mutex_unlock(&host->thread_lock);
 		return IRQ_HANDLED;
 	case MMCIF_WAIT_FOR_CMD:
 		/* Wait for data? */
@@ -1166,6 +1180,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	if (wait) {
 		schedule_delayed_work(&host->timeout_work, host->timeout);
 		/* Wait for more data */
+		mutex_unlock(&host->thread_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -1179,6 +1194,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 			sh_mmcif_stop_cmd(host, mrq);
 			if (!mrq->stop->error) {
 				schedule_delayed_work(&host->timeout_work, host->timeout);
+				mutex_unlock(&host->thread_lock);
 				return IRQ_HANDLED;
 			}
 		}
@@ -1189,6 +1205,8 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
 
+	mutex_unlock(&host->thread_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -1262,11 +1280,24 @@ static void mmcif_timeout_work(struct work_struct *work)
 	struct delayed_work *d = container_of(work, struct delayed_work, work);
 	struct sh_mmcif_host *host = container_of(d, struct sh_mmcif_host, timeout_work);
 	struct mmc_request *mrq = host->mrq;
+	unsigned long flags;
 
 	if (host->dying)
 		/* Don't run after mmc_remove_host() */
 		return;
 
+	dev_dbg(&host->pd->dev, "Timeout waiting for %u, opcode %u\n",
+		host->wait_for, mrq->cmd->opcode);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->state == STATE_IDLE) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	host->state = STATE_TIMEOUT;
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	/*
 	 * Handle races with cancel_delayed_work(), unless
 	 * cancel_delayed_work_sync() is used
@@ -1410,6 +1441,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 			goto erqcd;
 	}
 
+	mutex_init(&host->thread_lock);
+
 	clk_disable(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-- 
1.7.2.5

