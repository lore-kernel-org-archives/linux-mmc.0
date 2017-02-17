From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] mmc: host: tmio: ensure end of DMA and SD access are in sync
Date: Fri, 17 Feb 2017 19:22:41 +0100
Message-ID: <20170217182241.11489-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42952 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934536AbdBQSWz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Feb 2017 13:22:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

The current code assumes that DMA is finished before SD access end is
flagged. Thus, it schedules the 'dma_complete' tasklet in the SD card
interrupt routine when DATAEND is set. The assumption is not safe,
though. Even by mounting an SD card, it can be seen that sometimes DMA
complete is first, sometimes DATAEND. It seems they are usually close
enough timewise to not cause problems. However, a customer reported that
with CMD53 sometimes things really break apart. As a result, the BSP has
a patch which introduces flags for both events and makes sure both flags
are set before scheduling the tasklet. The customer accepted the patch,
yet it doesn't seem a proper upstream solution to me.

This patch refactors the code to replace the tasklet with already
existing and more lightweight mechanisms. First of all, we set the
callback in a DMA descriptor to automatically get notified when DMA is
done. In the callback, we then use a completion to make sure the SD
access has already ended. Then, we proceed as before.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since V1/RFC:

* removed #ifdef DEBUG
* rebased to latest mmc/next
* did some more performance testing. Couldn't spot any difference

 drivers/mmc/host/tmio_mmc.h     |  2 +-
 drivers/mmc/host/tmio_mmc_dma.c | 58 ++++++++++++++++++++++++-----------------
 drivers/mmc/host/tmio_mmc_pio.c |  4 +--
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 2b349d48fb9a8a..891d400d2a7cf2 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -137,7 +137,7 @@ struct tmio_mmc_host {
 	bool			force_pio;
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
-	struct tasklet_struct	dma_complete;
+	struct completion	dma_dataend;
 	struct tasklet_struct	dma_issue;
 	struct scatterlist	bounce_sg;
 	u8			*bounce_buf;
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index fa8a936a3d9ba1..c7684fa91f1f9c 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -43,6 +43,31 @@ void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 	tmio_mmc_enable_dma(host, true);
 }
 
+static void tmio_mmc_dma_callback(void *arg)
+{
+	struct tmio_mmc_host *host = arg;
+
+	wait_for_completion(&host->dma_dataend);
+
+	spin_lock_irq(&host->lock);
+
+	if (!host->data)
+		goto out;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     host->sg_ptr, host->sg_len,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     host->sg_ptr, host->sg_len,
+			     DMA_TO_DEVICE);
+
+	tmio_mmc_do_data_irq(host);
+out:
+	spin_unlock_irq(&host->lock);
+}
+
 static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
@@ -88,6 +113,10 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 			DMA_DEV_TO_MEM, DMA_CTRL_ACK);
 
 	if (desc) {
+		reinit_completion(&host->dma_dataend);
+		desc->callback = tmio_mmc_dma_callback;
+		desc->callback_param = host;
+
 		cookie = dmaengine_submit(desc);
 		if (cookie < 0) {
 			desc = NULL;
@@ -162,6 +191,10 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
 
 	if (desc) {
+		reinit_completion(&host->dma_dataend);
+		desc->callback = tmio_mmc_dma_callback;
+		desc->callback_param = host;
+
 		cookie = dmaengine_submit(desc);
 		if (cookie < 0) {
 			desc = NULL;
@@ -221,29 +254,6 @@ static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-static void tmio_mmc_tasklet_fn(unsigned long arg)
-{
-	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
-
-	spin_lock_irq(&host->lock);
-
-	if (!host->data)
-		goto out;
-
-	if (host->data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
-			     host->sg_ptr, host->sg_len,
-			     DMA_FROM_DEVICE);
-	else
-		dma_unmap_sg(host->chan_tx->device->dev,
-			     host->sg_ptr, host->sg_len,
-			     DMA_TO_DEVICE);
-
-	tmio_mmc_do_data_irq(host);
-out:
-	spin_unlock_irq(&host->lock);
-}
-
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
@@ -306,7 +316,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->bounce_buf)
 			goto ebouncebuf;
 
-		tasklet_init(&host->dma_complete, tmio_mmc_tasklet_fn, (unsigned long)host);
+		init_completion(&host->dma_dataend);
 		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
 	}
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 6b789a739d4dfe..c41f2252945eb7 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -596,11 +596,11 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 
 		if (done) {
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-			tasklet_schedule(&host->dma_complete);
+			complete(&host->dma_dataend);
 		}
 	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-		tasklet_schedule(&host->dma_complete);
+		complete(&host->dma_dataend);
 	} else {
 		tmio_mmc_do_data_irq(host);
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
-- 
2.11.0

