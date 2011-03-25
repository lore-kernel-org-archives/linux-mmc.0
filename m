From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2 v2] mmc: tmio-mmc: Improve DMA stability on sh-mobile
Date: Fri, 25 Mar 2011 14:36:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103251432380.22824@axis700.grange>
References: <Pine.LNX.4.64.1103251430260.22824@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55718 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1CYNgT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 09:36:19 -0400
In-Reply-To: <Pine.LNX.4.64.1103251430260.22824@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

On some SDHI tmio implementations the order of DMA and command completion
interrupts swaps, which leads to malfunction. This patch postpones
DMA activation until the MMC command completion IRQ time.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: rebased on top of patches from Linus Walleij

 drivers/mmc/host/tmio_mmc.c |   63 +++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ab1adea..e88627b 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -485,7 +485,10 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	unsigned int count;
 	unsigned long flags;
 
-	if (!data) {
+	if (host->chan_tx || host->chan_rx) {
+		pr_err("PIO IRQ in DMA mode!\n");
+		return;
+	} else if (!data) {
 		pr_debug("Spurious PIO IRQ\n");
 		return;
 	}
@@ -648,6 +651,8 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 		if (host->data->flags & MMC_DATA_READ) {
 			if (!host->chan_rx)
 				enable_mmc_irqs(host, TMIO_MASK_READOP);
+			else
+				tasklet_schedule(&host->dma_issue);
 		} else {
 			if (!host->chan_tx)
 				enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
@@ -779,18 +784,6 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 #endif
 }
 
-static void tmio_dma_complete(void *arg)
-{
-	struct tmio_mmc_host *host = arg;
-
-	dev_dbg(&host->pdev->dev, "Command completed\n");
-
-	if (!host->data)
-		dev_warn(&host->pdev->dev, "NULL data in DMA completion!\n");
-	else
-		enable_mmc_irqs(host, TMIO_STAT_DATAEND);
-}
-
 static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
@@ -817,6 +810,8 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	disable_mmc_irqs(host, TMIO_STAT_RXRDY);
+
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
@@ -827,14 +822,11 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0)
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
-			DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			DMA_FROM_DEVICE, DMA_CTRL_ACK);
 
-	if (desc) {
-		desc->callback = tmio_dma_complete;
-		desc->callback_param = host;
+	if (desc)
 		cookie = dmaengine_submit(desc);
-		dma_async_issue_pending(chan);
-	}
+
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
@@ -886,6 +878,8 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
+	disable_mmc_irqs(host, TMIO_STAT_TXRQ);
+
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
 		unsigned long flags;
@@ -900,13 +894,11 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0)
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
-			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			DMA_TO_DEVICE, DMA_CTRL_ACK);
 
-	if (desc) {
-		desc->callback = tmio_dma_complete;
-		desc->callback_param = host;
+	if (desc)
 		cookie = dmaengine_submit(desc);
-	}
+
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
@@ -947,17 +939,30 @@ static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 static void tmio_issue_tasklet_fn(unsigned long priv)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
-	struct dma_chan *chan = host->chan_tx;
+	struct dma_chan *chan = NULL;
+
+	spin_lock_irq(&host->lock);
+
+	if (host && host->data) {
+		if (host->data->flags & MMC_DATA_READ)
+			chan = host->chan_rx;
+		else
+			chan = host->chan_tx;
+	}
+
+	spin_unlock_irq(&host->lock);
 
-	dma_async_issue_pending(chan);
+	enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+
+	if (chan)
+		dma_async_issue_pending(chan);
 }
 
 static void tmio_tasklet_fn(unsigned long arg)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	spin_lock_irq(&host->lock);
 
 	if (!host->data)
 		goto out;
@@ -973,7 +978,7 @@ static void tmio_tasklet_fn(unsigned long arg)
 
 	tmio_mmc_do_data_irq(host);
 out:
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock_irq(&host->lock);
 }
 
 /* It might be necessary to make filter MFD specific */
-- 
1.7.2.5

