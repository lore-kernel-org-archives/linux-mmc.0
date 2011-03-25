From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2 v2] mmc: tmio: use PIO for short transfers
Date: Fri, 25 Mar 2011 14:36:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103251434040.22824@axis700.grange>
References: <Pine.LNX.4.64.1103251430260.22824@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103251430260.22824@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

This patch allows transferring of some requests in PIO and some in DMA
mode and defaults to using DMA only for transfers longer than 8 bytes.
This is especially useful with SDIO, which can have lots of 2- and 4-byte
transfers, creating unnecessary high overhead, when executed in DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: rebased on top of DMA API update patches from Linus Walleij

 drivers/mmc/host/tmio_mmc.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e88627b..32ab145 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -100,6 +100,8 @@
 		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
 #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
 
+#define TMIO_MIN_DMA_LEN 8
+
 #define enable_mmc_irqs(host, i) \
 	do { \
 		u32 mask;\
@@ -147,6 +149,7 @@ struct tmio_mmc_host {
 	struct platform_device *pdev;
 
 	/* DMA support */
+	bool			force_pio;
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
 	struct tasklet_struct	dma_complete;
@@ -385,6 +388,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	host->cmd = NULL;
 	host->data = NULL;
 	host->mrq = NULL;
+	host->force_pio = false;
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -404,6 +408,7 @@ tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
+	host->force_pio = false;
 
 	cancel_delayed_work(&host->delayed_reset_work);
 
@@ -485,7 +490,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	unsigned int count;
 	unsigned long flags;
 
-	if (host->chan_tx || host->chan_rx) {
+	if ((host->chan_tx || host->chan_rx) && !host->force_pio) {
 		pr_err("PIO IRQ in DMA mode!\n");
 		return;
 	} else if (!data) {
@@ -551,15 +556,11 @@ static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	 */
 
 	if (data->flags & MMC_DATA_READ) {
-		if (!host->chan_rx)
-			disable_mmc_irqs(host, TMIO_MASK_READOP);
-		else
+		if (host->chan_rx && !host->force_pio)
 			tmio_check_bounce_buffer(host);
 		dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
 			host->mrq);
 	} else {
-		if (!host->chan_tx)
-			disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 		dev_dbg(&host->pdev->dev, "Complete Tx request %p\n",
 			host->mrq);
 	}
@@ -583,7 +584,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	if (!data)
 		goto out;
 
-	if (host->chan_tx && (data->flags & MMC_DATA_WRITE)) {
+	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
 		/*
 		 * Has all data been written out yet? Testing on SuperH showed,
 		 * that in most cases the first interrupt comes already with the
@@ -596,11 +597,12 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 			disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 			tasklet_schedule(&host->dma_complete);
 		}
-	} else if (host->chan_rx && (data->flags & MMC_DATA_READ)) {
+	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
 		disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 		tasklet_schedule(&host->dma_complete);
 	} else {
 		tmio_mmc_do_data_irq(host);
+		disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
 	}
 out:
 	spin_unlock(&host->lock);
@@ -649,12 +651,12 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	 */
 	if (host->data && !cmd->error) {
 		if (host->data->flags & MMC_DATA_READ) {
-			if (!host->chan_rx)
+			if (host->force_pio || !host->chan_rx)
 				enable_mmc_irqs(host, TMIO_MASK_READOP);
 			else
 				tasklet_schedule(&host->dma_issue);
 		} else {
-			if (!host->chan_tx)
+			if (host->force_pio || !host->chan_tx)
 				enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 			else
 				tasklet_schedule(&host->dma_issue);
@@ -810,6 +812,11 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	if (sg->length < TMIO_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
 	disable_mmc_irqs(host, TMIO_STAT_RXRDY);
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
@@ -878,6 +885,11 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	if (sg->length < TMIO_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
 	disable_mmc_irqs(host, TMIO_STAT_TXRQ);
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
@@ -1119,6 +1131,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 fail:
 	host->mrq = NULL;
+	host->force_pio = false;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
 }
-- 
1.7.2.5

