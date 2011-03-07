From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] mmc: tmio: use PIO for short transfers
Date: Mon, 7 Mar 2011 14:30:35 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071429420.29543@axis700.grange>
References: <Pine.LNX.4.64.1103071417340.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61226 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab1CGNaj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 08:30:39 -0500
In-Reply-To: <Pine.LNX.4.64.1103071417340.29543@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

This patch allows transferring of some requests in PIO and some in DMA
mode and defaults to using DMA only for transfers longer than 8 bytes.
This is especially useful with SDIO, which can have lots of 2- and 4-byte
transfers, creating unnecessary high overhead, when executed in DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index aa384ba..f5ec5e6 100644
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
@@ -384,6 +387,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	host->cmd = NULL;
 	host->data = NULL;
 	host->mrq = NULL;
+	host->force_pio = false;
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -403,6 +407,7 @@ tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
+	host->force_pio = false;
 
 	cancel_delayed_work(&host->delayed_reset_work);
 
@@ -484,7 +489,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	unsigned int count;
 	unsigned long flags;
 
-	if (host->chan_tx || host->chan_rx) {
+	if ((host->chan_tx || host->chan_rx) && !host->force_pio) {
 		pr_err("PIO IRQ in DMA mode!\n");
 		return;
 	} else if (!data) {
@@ -550,15 +555,11 @@ static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
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
@@ -582,7 +583,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	if (!data)
 		goto out;
 
-	if (host->chan_tx && (data->flags & MMC_DATA_WRITE)) {
+	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
 		/*
 		 * Has all data been written out yet? Testing on SuperH showed,
 		 * that in most cases the first interrupt comes already with the
@@ -595,11 +596,12 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
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
@@ -648,12 +650,12 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
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
@@ -811,6 +813,11 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	if (sg->length < TMIO_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
 	disable_mmc_irqs(host, TMIO_STAT_RXRDY);
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
@@ -886,6 +893,11 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	if (sg->length < TMIO_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
 	disable_mmc_irqs(host, TMIO_STAT_TXRQ);
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
@@ -1132,6 +1144,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 fail:
 	host->mrq = NULL;
+	host->force_pio = false;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
 }
-- 
1.7.2.3

