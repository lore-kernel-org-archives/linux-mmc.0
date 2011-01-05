From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3 v3] mmc: tmio: implement a bounce buffer for unaligned
 DMA
Date: Wed, 5 Jan 2011 21:56:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101052152180.5375@axis700.grange>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
 <Pine.LNX.4.64.1011231723090.25676@axis700.grange> <20110105195655.GD9198@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57220 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1AEU4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 15:56:06 -0500
In-Reply-To: <20110105195655.GD9198@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

For example, with SDIO WLAN cards, some transfers happen with buffers at
odd addresses, whereas the SH-Mobile DMA engine requires even addresses
for SDHI. This patch extends the tmio driver with a bounce buffer, that
is used for single entry scatter-gather lists both for sending and
receiving. If we ever encounter unaligned transfers with multi-element
sg lists, this patch will have to be extended. For now it just falls
back to PIO in this and other unsupported cases.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, thanks for your comments, but you picked up a wrong version of this 
patch. Please, use links from my "outstanding patches" email.

v3:

1. wrapped patch description at 72 chars instead of 80
2. removed two redundant comment lines

v2:

1. fixed compilation without DMA support. Thanks to Magnus Damm 
<damm@opensource.se> for reporting

 drivers/mmc/host/tmio_mmc.c |   89 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 118ad86..d8163c1 100644
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
 
@@ -139,9 +142,13 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_issue;
 #ifdef CONFIG_TMIO_MMC_DMA
 	unsigned int            dma_sglen;
+	u8			bounce_buf[PAGE_CACHE_SIZE] __attribute__((aligned(MAX_ALIGN)));
+	struct scatterlist	bounce_sg;
 #endif
 };
 
+static void tmio_check_bounce_buffer(struct tmio_mmc_host *host);
+
 static u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
 	return readw(host->ctl + (addr << host->bus_shift));
@@ -180,6 +187,7 @@ static void tmio_mmc_init_sg(struct tmio_mmc_host *host, struct mmc_data *data)
 {
 	host->sg_len = data->sg_len;
 	host->sg_ptr = data->sg;
+	host->sg_orig = data->sg;
 	host->sg_off = 0;
 }
 
@@ -438,6 +446,8 @@ static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	if (data->flags & MMC_DATA_READ) {
 		if (!host->chan_rx)
 			disable_mmc_irqs(host, TMIO_MASK_READOP);
+		else
+			tmio_check_bounce_buffer(host);
 		dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
 			host->mrq);
 	} else {
@@ -529,8 +539,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 			if (!host->chan_rx)
 				enable_mmc_irqs(host, TMIO_MASK_READOP);
 		} else {
-			struct dma_chan *chan = host->chan_tx;
-			if (!chan)
+			if (!host->chan_tx)
 				enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 			else
 				tasklet_schedule(&host->dma_issue);
@@ -612,6 +621,16 @@ out:
 }
 
 #ifdef CONFIG_TMIO_MMC_DMA
+static void tmio_check_bounce_buffer(struct tmio_mmc_host *host)
+{
+	if (host->sg_ptr == &host->bounce_sg) {
+		unsigned long flags;
+		void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig, &flags);
+		memcpy(sg_vaddr, host->bounce_buf, host->bounce_sg.length);
+		tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+	}
+}
+
 static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
@@ -634,11 +653,35 @@ static void tmio_dma_complete(void *arg)
 
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
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0) {
@@ -661,6 +704,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
+pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
@@ -684,11 +728,39 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 
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
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
+		tmio_mmc_kunmap_atomic(sg_vaddr, &flags);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0) {
@@ -709,6 +781,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
 
+pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
 		if (ret >= 0)
@@ -822,6 +895,10 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 	}
 }
 #else
+static void tmio_check_bounce_buffer(struct tmio_mmc_host *host)
+{
+}
+
 static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
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

