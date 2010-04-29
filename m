From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor autoloading
	feature
Date: Thu, 29 Apr 2010 23:05:26 +0530
Message-ID: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:51142 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933633Ab0D3RvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 13:51:09 -0400
Received: by iwn12 with SMTP id 12so531689iwn.15
        for <linux-mmc@vger.kernel.org>; Fri, 30 Apr 2010 10:50:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

>From 1c63dd42fc6c563c931168779ce73401332faa52 Mon Sep 17 00:00:00 2001
From: Venkatraman S <svenkatr@ti.com>
Date: Thu, 29 Apr 2010 22:43:31 +0530
Subject: [PATCH 2/2] omap hsmmc: adaptation of sdma descriptor
autoloading feature

Start to use the sDMA descriptor autoloading feature.
For large datablocks, the MMC driver has to repeatedly setup,
program and teardown the dma channel for each element of the
sglist received in omap_hsmmc_request.

By using descriptor autoloading, transfers from / to each element of
the sglist is pre programmed into a linked list. The sDMA driver
completes the entire transaction and provides a single interrupt.

Due to this, number of dma interrupts for a typical 100MB transfer on the MMC is
reduced from 25000 to about 400 (approximate). Transfer speeds are
improved by ~5%.
(Though it varies on the size of read / write & improves on huge transfers)

Descriptor autoloading is available only in 3630 and 4430 (as of now).
Hence normal DMA mode is also retained.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC: Adrian Hunter <adrian.hunter@nokia.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 Changes since previous version
  * Rebased to Adrian Hunter's interrupt syncronisation patch
             https://patchwork.kernel.org/patch/94670/
  * Rename ICR name definition
 drivers/mmc/host/omap_hsmmc.c |  148 ++++++++++++++++++++++++++++++++++------
 1 files changed, 125 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 65093d4..095fd94 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -102,6 +102,8 @@
 #define SRD			(1 << 26)
 #define SOFTRESET		(1 << 1)
 #define RESETDONE		(1 << 0)
+/* End of superblock indicator for sglist transfers */
+#define DMA_ICR_SGLIST_END	0x4D00

 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -118,6 +120,12 @@
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"mmci-omap-hs"

+#define DMA_TYPE_NODMA	0
+#define DMA_TYPE_SDMA	1
+#define DMA_TYPE_SDMA_DLOAD 2
+
+#define DMA_CTRL_BUF_SIZE	(PAGE_SIZE * 3)
+
 /* Timeouts for entering power saving states on inactivity, msec */
 #define OMAP_MMC_DISABLED_TIMEOUT	100
 #define OMAP_MMC_SLEEP_TIMEOUT		1000
@@ -170,7 +178,11 @@ struct omap_hsmmc_host {
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
-	int			use_dma, dma_ch;
+	int			dma_caps;
+	int			dma_in_use;
+	int			dma_ch;
+	void			*dma_ctrl_buf;
+	dma_addr_t		dma_ctrl_buf_phy;
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
 	int			got_dbclk;
@@ -527,7 +539,7 @@ static void omap_hsmmc_enable_irq(struct
omap_hsmmc_host *host)
 {
 	unsigned int irq_mask;

-	if (host->use_dma)
+	if (host->dma_in_use)
 		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
 	else
 		irq_mask = INT_EN_MASK;
@@ -813,7 +825,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
*host, struct mmc_command *cmd,
 			cmdreg &= ~(DDIR);
 	}

-	if (host->use_dma)
+	if (host->dma_in_use)
 		cmdreg |= DMA_EN;

 	host->req_in_progress = 1;
@@ -842,7 +854,7 @@ static void omap_hsmmc_request_done(struct
omap_hsmmc_host *host, struct mmc_req

 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && dma_ch != -1)
+	if (mrq->data && host->dma_in_use && dma_ch != -1)
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -920,7 +932,7 @@ static void omap_hsmmc_dma_cleanup(struct
omap_hsmmc_host *host, int errno)
 	host->dma_ch = -1;
 	spin_unlock(&host->irq_lock);

-	if (host->use_dma && dma_ch != -1) {
+	if (host->dma_in_use && dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
 			omap_hsmmc_get_dma_dir(host, host->data));
 		omap_free_dma(dma_ch);
@@ -1266,7 +1278,6 @@ static void omap_hsmmc_config_dma_params(struct
omap_hsmmc_host *host,
 			omap_hsmmc_get_dma_sync_dev(host, data),
 			!(data->flags & MMC_DATA_WRITE));

-	omap_start_dma(dma_ch);
 }

 /*
@@ -1279,21 +1290,23 @@ static void omap_hsmmc_dma_cb(int lch, u16
ch_status, void *cb_data)
 	int dma_ch, req_in_progress;

 	if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
-		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");
+		dev_dbg(mmc_dev(host->mmc), "Misaligned address error\n");

 	spin_lock(&host->irq_lock);
 	if (host->dma_ch < 0) {
 		spin_unlock(&host->irq_lock);
 		return;
 	}
-
-	host->dma_sg_idx++;
-	if (host->dma_sg_idx < host->dma_len) {
-		/* Fire up the next transfer. */
-		omap_hsmmc_config_dma_params(host, data,
+	if (host->dma_in_use == DMA_TYPE_SDMA) {
+		host->dma_sg_idx++;
+		if (host->dma_sg_idx < host->dma_len) {
+			/* Fire up the next transfer. */
+			omap_hsmmc_config_dma_params(host, data,
 					   data->sg + host->dma_sg_idx);
-		spin_unlock(&host->irq_lock);
-		return;
+			omap_start_dma(host->dma_ch);
+			spin_unlock(&host->irq_lock);
+			return;
+		}
 	}

 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
@@ -1315,10 +1328,19 @@ static void omap_hsmmc_dma_cb(int lch, u16
ch_status, void *cb_data)
 	}
 }

+static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
+{
+	if (host->dma_in_use == DMA_TYPE_SDMA)
+		omap_start_dma(host->dma_ch);
+	else if (host->dma_in_use == DMA_TYPE_SDMA_DLOAD)
+		return omap_start_dma_sglist_transfers(host->dma_ch, -1);
+
+	return 0;
+}
 /*
- * Routine to configure and start DMA for the MMC card
+ * Routine to configure DMA for the MMC card
  */
-static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
+static int omap_hsmmc_configure_sdma(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
 	int dma_ch = 0, ret = 0, i;
@@ -1359,6 +1381,56 @@ static int omap_hsmmc_start_dma_transfer(struct
omap_hsmmc_host *host,
 	return 0;
 }

+static int omap_hsmmc_configure_sdma_sglist(struct omap_hsmmc_host *host,
+		struct mmc_request *req)
+{
+	int i;
+	struct omap_dma_sglist_node *sglist, *snode;
+	struct mmc_data *data = req->data;
+	int blksz;
+	int dmadir = omap_hsmmc_get_dma_dir(host, data);
+	struct omap_dma_sglist_type2a_params *t2p;
+
+	sglist = (struct omap_dma_sglist_node *) host->dma_ctrl_buf;
+	snode = sglist;
+	blksz = host->data->blksz;
+
+	if ((host->dma_len * sizeof(*snode)) > DMA_CTRL_BUF_SIZE) {
+		dev_err(mmc_dev(host->mmc), "not enough sglist memory %d\n",
+			host->dma_len);
+		return -ENOMEM;
+	}
+	for (i = 0; i < host->dma_len; snode++, i++) {
+		snode->desc_type = OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a;
+		snode->num_of_elem = blksz / 4;
+		t2p = &snode->sg_node.t2a;
+
+		if (dmadir == DMA_FROM_DEVICE) {
+			t2p->src_addr = host->mapbase + OMAP_HSMMC_DATA;
+			t2p->dst_addr = sg_dma_address(data->sg + i);
+		} else {
+			t2p->dst_addr = host->mapbase + OMAP_HSMMC_DATA;
+			t2p->src_addr = sg_dma_address(data->sg + i);
+		}
+		snode->flags =
+			OMAP_DMA_LIST_DST_VALID | OMAP_DMA_LIST_SRC_VALID;
+
+		t2p->cfn_fn = sg_dma_len(data->sg + i) / host->data->blksz;
+		t2p->cicr = DMA_ICR_SGLIST_END;
+
+		t2p->dst_frame_idx_or_pkt_size = 0;
+		t2p->src_frame_idx_or_pkt_size = 0;
+		t2p->dst_elem_idx = 0;
+		t2p->src_elem_idx = 0;
+	}
+	dev_dbg(mmc_dev(host->mmc), "new sglist %x len =%d\n",
+			host->dma_ctrl_buf_phy, i);
+	omap_set_dma_sglist_mode(host->dma_ch, sglist,
+			host->dma_ctrl_buf_phy, i, NULL);
+	omap_dma_set_sglist_fastmode(host->dma_ch, 1);
+	return 0;
+}
+
 static void set_data_timeout(struct omap_hsmmc_host *host,
 			     unsigned int timeout_ns,
 			     unsigned int timeout_clks)
@@ -1420,14 +1492,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
*host, struct mmc_request *req)
 					| (req->data->blocks << 16));
 	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);

-	if (host->use_dma) {
-		ret = omap_hsmmc_start_dma_transfer(host, req);
-		if (ret != 0) {
-			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
+	if (host->dma_caps & DMA_TYPE_SDMA) {
+		ret = omap_hsmmc_configure_sdma(host, req);
+		if (ret)
 			return ret;
-		}
+		host->dma_in_use = DMA_TYPE_SDMA;
 	}
-	return 0;
+	if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
+		host->data->sg_len > 4) {
+		ret = omap_hsmmc_configure_sdma_sglist(host, req);
+		if (ret)
+			return ret;
+		host->dma_in_use = DMA_TYPE_SDMA_DLOAD;
+
+	}
+	ret = omap_hsmmc_start_dma_transfer(host);
+	return ret;
+
 }

 /*
@@ -2007,7 +2088,9 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	host->mmc	= mmc;
 	host->pdata	= pdata;
 	host->dev	= &pdev->dev;
-	host->use_dma	= 1;
+	host->dma_caps	= DMA_TYPE_SDMA;
+	host->dma_in_use	= DMA_TYPE_NODMA;
+	host->dma_ctrl_buf = NULL;
 	host->dev->dma_mask = &pdata->dma_mask;
 	host->dma_ch	= -1;
 	host->irq	= irq;
@@ -2088,6 +2171,15 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 							" clk failed\n");
 	}

+	if (cpu_is_omap44xx() || cpu_is_omap3630()) {
+		host->dma_ctrl_buf = dma_alloc_coherent(NULL,
+					DMA_CTRL_BUF_SIZE,
+					&host->dma_ctrl_buf_phy,
+					0);
+		if (host->dma_ctrl_buf != NULL)
+			host->dma_caps |= DMA_TYPE_SDMA_DLOAD;
+	}
+
 	/* Since we do only SG emulation, we can have as many segs
 	 * as we want. */
 	mmc->max_phys_segs = 1024;
@@ -2213,6 +2305,10 @@ err_reg:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
+	if (host->dma_ctrl_buf)
+		dma_free_coherent(NULL, DMA_CTRL_BUF_SIZE,
+				host->dma_ctrl_buf,
+				host->dma_ctrl_buf_phy);
 	mmc_host_disable(host->mmc);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
@@ -2240,6 +2336,12 @@ static int omap_hsmmc_remove(struct
platform_device *pdev)
 	if (host) {
 		mmc_host_enable(host->mmc);
 		mmc_remove_host(host->mmc);
+
+		if (host->dma_ctrl_buf != NULL) {
+			dma_free_coherent(NULL, DMA_CTRL_BUF_SIZE,
+				host->dma_ctrl_buf,
+				host->dma_ctrl_buf_phy);
+		}
 		if (host->use_reg)
 			omap_hsmmc_reg_put(host);
 		if (host->pdata->cleanup)
-- 
1.6.3.3
