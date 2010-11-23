From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
Date: Tue, 23 Nov 2010 17:24:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:60083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753630Ab0KWQYJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 11:24:09 -0500
In-Reply-To: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

For example, with SDIO WLAN cards, some transfers happen with buffers at odd
addresses, whereas the SH-Mobile DMA engine requires even addresses for SDHI.
This patch extends the tmio driver with a bounce buffer, that is used for
single entry scatter-gather lists both for sending and receiving. If we ever
encounter unaligned transfers with multi-element sg lists, this patch will have
to be extended. For now it just falls back to PIO in this and other unsupported
cases.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |   81 +++++++++++++++++++++++++++++++++++++++----
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 118ad86..57ece9d 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -111,6 +111,8 @@
 		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
 	} while (0)
 
+/* This is arbitrary, just noone needed any higher alignment yet */
+#define MAX_ALIGN 4
 
 struct tmio_mmc_host {
 	void __iomem *ctl;
@@ -127,6 +129,7 @@ struct tmio_mmc_host {
 
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
+	struct scatterlist      *sg_orig;
 	unsigned int            sg_len;
 	unsigned int            sg_off;
 
@@ -139,6 +142,8 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_issue;
 #ifdef CONFIG_TMIO_MMC_DMA
 	unsigned int            dma_sglen;
+	u8			bounce_buf[PAGE_CACHE_SIZE] __attribute__((aligned(MAX_ALIGN)));
+	struct scatterlist	bounce_sg;
 #endif
 };
 
@@ -180,6 +185,7 @@ static void tmio_mmc_init_sg(struct tmio_mmc_host *host, struct mmc_data *data)
 {
 	host->sg_len = data->sg_len;
 	host->sg_ptr = data->sg;
+	host->sg_orig = data->sg;
 	host->sg_off = 0;
 }
 
@@ -436,8 +442,14 @@ static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	 */
 
 	if (data->flags & MMC_DATA_READ) {
-		if (!host->chan_rx)
+		if (!host->chan_rx) {
 			disable_mmc_irqs(host, TMIO_MASK_READOP);
+		} else if (host->sg_ptr == &host->bounce_sg) {
+			unsigned long flags;
+			void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig, &flags);
+			memcpy(sg_vaddr, host->bounce_buf, host->bounce_sg.length);
+			tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+		}
 		dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
 			host->mrq);
 	} else {
@@ -529,8 +541,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 			if (!host->chan_rx)
 				enable_mmc_irqs(host, TMIO_MASK_READOP);
 		} else {
-			struct dma_chan *chan = host->chan_tx;
-			if (!chan)
+			if (!host->chan_tx)
 				enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 			else
 				tasklet_schedule(&host->dma_issue);
@@ -634,11 +645,36 @@ static void tmio_dma_complete(void *arg)
 
 static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 {
-	struct scatterlist *sg = host->sg_ptr;
+	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_rx;
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
 	dma_cookie_t cookie;
-	int ret;
+	int ret, i;
+	bool aligned = true, multiple = true;
+	unsigned int align = (1 << pdata->dma->alignment_shift) - 1;
+
+	for_each_sg(sg, sg_tmp, host->sg_len, i) {
+		if (sg_tmp->offset & align)
+			aligned = false;
+		if (sg_tmp->length & align) {
+			multiple = false;
+			break;
+		}
+	}
+
+	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
+			  align >= MAX_ALIGN)) || !multiple)
+		goto pio;
+
+	/* The only sg element can be unaligned, use our bounce buffer then */
+	if (!aligned) {
+		/* The first sg element unaligned, use our bounce-buffer */
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0) {
@@ -661,6 +697,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
+pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
@@ -684,11 +721,40 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 
 static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 {
-	struct scatterlist *sg = host->sg_ptr;
+	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_tx;
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
 	dma_cookie_t cookie;
-	int ret;
+	int ret, i;
+	bool aligned = true, multiple = true;
+	unsigned int align = (1 << pdata->dma->alignment_shift) - 1;
+
+	for_each_sg(sg, sg_tmp, host->sg_len, i) {
+		if (sg_tmp->offset & align)
+			aligned = false;
+		if (sg_tmp->length & align) {
+			multiple = false;
+			break;
+		}
+	}
+
+	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
+			  align >= MAX_ALIGN)) || !multiple)
+		goto pio;
+
+	/* The only sg element can be unaligned, use our bounce buffer then */
+	if (!aligned) {
+		unsigned long flags;
+		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
+		/* The first sg element unaligned, use our bounce-buffer */
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
+		tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0) {
@@ -709,6 +775,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
+pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 085f041..dbfc053 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -66,6 +66,7 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
 struct tmio_mmc_dma {
 	void *chan_priv_tx;
 	void *chan_priv_rx;
+	int alignment_shift;
 };
 
 /*
-- 
1.7.2.3

