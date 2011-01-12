From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mxcmmc: use dmaengine API
Date: Wed, 12 Jan 2011 11:09:56 +0100
Message-ID: <1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab1ALKKF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 05:10:05 -0500
In-Reply-To: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>

This switches the mxcmmc driver to use the dmaengine API. Unlike
the old one this one is always present in the tree, even if no DMA
is implement, hence we can remove all the #ifdefs in from the driver.
The driver automatically switches to PIO mode if no DMA support or no
suitable channel is available.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c |  172 +++++++++++++++++++++++++--------------------
 1 files changed, 97 insertions(+), 75 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index bdd2cbb..5de4bf8 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -31,16 +31,14 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/dmaengine.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/sizes.h>
 #include <mach/mmc.h>
 
-#ifdef CONFIG_ARCH_MX2
-#include <mach/dma-mx1-mx2.h>
-#define HAS_DMA
-#endif
+#include <mach/dma.h>
 
 #define DRIVER_NAME "mxc-mmc"
 
@@ -117,7 +115,8 @@ struct mxcmci_host {
 	void __iomem		*base;
 	int			irq;
 	int			detect_irq;
-	int			dma;
+	struct dma_chan		*dma;
+	struct dma_async_tx_descriptor *desc;
 	int			do_dma;
 	int			default_irq_mask;
 	int			use_sdio;
@@ -141,6 +140,11 @@ struct mxcmci_host {
 
 	struct work_struct	datawork;
 	spinlock_t		lock;
+
+	int			burstlen;
+	int			dmareq;
+	struct dma_slave_config dma_slave_config;
+	struct imx_dma_data	dma_data;
 };
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
@@ -166,17 +170,16 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 
 	writew(0xff, host->base + MMC_REG_RES_TO);
 }
+static int mxcmci_setup_dma(struct mmc_host *mmc);
 
 static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 {
 	unsigned int nob = data->blocks;
 	unsigned int blksz = data->blksz;
 	unsigned int datasize = nob * blksz;
-#ifdef HAS_DMA
 	struct scatterlist *sg;
 	int i;
-	int ret;
-#endif
+
 	if (data->flags & MMC_DATA_STREAM)
 		nob = 0xffff;
 
@@ -187,7 +190,9 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	writew(blksz, host->base + MMC_REG_BLK_LEN);
 	host->datasize = datasize;
 
-#ifdef HAS_DMA
+	if (!mxcmci_use_dma(host))
+		return 0;
+
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		if (sg->offset & 3 || sg->length & 3) {
 			host->do_dma = 0;
@@ -195,34 +200,25 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		}
 	}
 
-	if (data->flags & MMC_DATA_READ) {
+	if (data->flags & MMC_DATA_READ)
 		host->dma_dir = DMA_FROM_DEVICE;
-		host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,  host->dma_dir);
-
-		ret = imx_dma_setup_sg(host->dma, data->sg, host->dma_nents,
-				datasize,
-				host->res->start + MMC_REG_BUFFER_ACCESS,
-				DMA_MODE_READ);
-	} else {
+	else
 		host->dma_dir = DMA_TO_DEVICE;
-		host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,  host->dma_dir);
 
-		ret = imx_dma_setup_sg(host->dma, data->sg, host->dma_nents,
-				datasize,
-				host->res->start + MMC_REG_BUFFER_ACCESS,
-				DMA_MODE_WRITE);
-	}
+	host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,  host->dma_dir);
+	host->desc = host->dma->device->device_prep_slave_sg(host->dma,
+		data->sg, data->sg_len, host->dma_dir,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
-	if (ret) {
-		dev_err(mmc_dev(host->mmc), "failed to setup DMA : %d\n", ret);
-		return ret;
+	if (!host->desc) {
+		dev_err(mmc_dev(host->mmc), "failed to setup DMA\n");
+		return -EINVAL;
 	}
 	wmb();
 
-	imx_dma_enable(host->dma);
-#endif /* HAS_DMA */
+	dmaengine_submit(host->desc);
+
 	return 0;
 }
 
@@ -297,13 +293,11 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	int data_error;
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host)) {
-		imx_dma_disable(host->dma);
+		dmaengine_terminate_all(host->dma);
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_nents,
 				host->dma_dir);
 	}
-#endif
 
 	if (stat & STATUS_ERR_MASK) {
 		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
@@ -505,7 +499,6 @@ static void mxcmci_datawork(struct work_struct *work)
 	}
 }
 
-#ifdef HAS_DMA
 static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 {
 	struct mmc_data *data = host->data;
@@ -528,7 +521,6 @@ static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 		mxcmci_finish_request(host, host->req);
 	}
 }
-#endif /* HAS_DMA */
 
 static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
 {
@@ -566,12 +558,10 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 	sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 	    (stat & (STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE)))
 		writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
 			host->base + MMC_REG_STATUS);
-#endif
 
 	if (sdio_irq) {
 		writel(STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
@@ -581,14 +571,14 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 	if (stat & STATUS_END_CMD_RESP)
 		mxcmci_cmd_done(host, stat);
 
-#ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
 		mxcmci_data_done(host, stat);
-#endif
+
 	if (host->default_irq_mask &&
 		  (stat & (STATUS_CARD_INSERTION | STATUS_CARD_REMOVAL)))
 		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+
 	return IRQ_HANDLED;
 }
 
@@ -602,9 +592,7 @@ static void mxcmci_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	host->req = req;
 	host->cmdat &= ~CMD_DAT_CONT_INIT;
-#ifdef HAS_DMA
-	host->do_dma = 1;
-#endif
+
 	if (req->data) {
 		error = mxcmci_setup_data(host, req->data);
 		if (error) {
@@ -620,6 +608,7 @@ static void mxcmci_request(struct mmc_host *mmc, struct mmc_request *req)
 	}
 
 	error = mxcmci_start_cmd(host, req->cmd, cmdat);
+
 out:
 	if (error)
 		mxcmci_finish_request(host, req);
@@ -658,22 +647,47 @@ static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios)
 			prescaler, divider, clk_in, clk_ios);
 }
 
+static int mxcmci_setup_dma(struct mmc_host *mmc)
+{
+	struct mxcmci_host *host = mmc_priv(mmc);
+	struct dma_slave_config *config = &host->dma_slave_config;
+
+	config->direction = DMA_FROM_DEVICE;
+	config->dst_addr = host->res->start + MMC_REG_BUFFER_ACCESS;
+	config->src_addr = host->res->start + MMC_REG_BUFFER_ACCESS;
+	config->dst_addr_width = 4;
+	config->src_addr_width = 4;
+	config->dst_maxburst = host->burstlen;
+	config->src_maxburst = host->burstlen;
+
+	return dmaengine_slave_config(host->dma, config);
+}
+
 static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mxcmci_host *host = mmc_priv(mmc);
-#ifdef HAS_DMA
-	unsigned int blen;
+	int burstlen, ret;
+
 	/*
 	 * use burstlen of 64 in 4 bit mode (--> reg value  0)
 	 * use burstlen of 16 in 1 bit mode (--> reg value 16)
 	 */
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		blen = 0;
+		burstlen = 64;
 	else
-		blen = 16;
+		burstlen = 16;
+
+	if (mxcmci_use_dma(host) && burstlen != host->burstlen) {
+		host->burstlen = burstlen;
+		ret = mxcmci_setup_dma(mmc);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to config DMA channel. Falling back to PIO\n");
+			dma_release_channel(host->dma);
+			host->do_dma = 0;
+		}
+	}
 
-	imx_dma_config_burstlen(host->dma, blen);
-#endif
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		host->cmdat |= CMD_DAT_CONT_BUS_WIDTH_4;
 	else
@@ -754,6 +768,20 @@ static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
 		host->caps |= MMC_CAP_4_BIT_DATA;
 }
 
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct mxcmci_host *host = param;
+
+	if (!imx_dma_is_general_purpose(chan)) {
+		printk("no general\n");
+		return false;
+	}
+
+        chan->private = &host->dma_data;
+
+        return true;
+}
+
 static const struct mmc_host_ops mxcmci_ops = {
 	.request		= mxcmci_request,
 	.set_ios		= mxcmci_set_ios,
@@ -768,6 +796,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	struct mxcmci_host *host = NULL;
 	struct resource *iores, *r;
 	int ret = 0, irq;
+	dma_cap_mask_t mask;
 
 	printk(KERN_INFO "i.MX SDHC driver\n");
 
@@ -794,7 +823,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
+	mmc->max_seg_size = 65535;
 
 	host = mmc_priv(mmc);
 	host->base = ioremap(r->start, resource_size(r));
@@ -846,29 +875,22 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
 
-#ifdef HAS_DMA
-	host->dma = imx_dma_request_by_prio(DRIVER_NAME, DMA_PRIO_LOW);
-	if (host->dma < 0) {
-		dev_err(mmc_dev(host->mmc), "imx_dma_request_by_prio failed\n");
-		ret = -EBUSY;
-		goto out_clk_put;
-	}
-
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r) {
-		ret = -EINVAL;
-		goto out_free_dma;
+	if (r) {
+		host->dmareq = r->start;
+		host->dma_data.peripheral_type = IMX_DMATYPE_SDHC;
+		host->dma_data.priority = DMA_PRIO_LOW;
+		host->dma_data.dma_request = host->dmareq;
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		host->dma = dma_request_channel(mask, filter, host);
+		if (host->dma)
+			host->do_dma = 1;
 	}
 
-	ret = imx_dma_config_channel(host->dma,
-				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_FIFO,
-				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
-				     r->start, 0);
-	if (ret) {
-		dev_err(mmc_dev(host->mmc), "failed to config DMA channel\n");
-		goto out_free_dma;
-	}
-#endif
+	if (!host->do_dma)
+		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
+
 	INIT_WORK(&host->datawork, mxcmci_datawork);
 
 	ret = request_irq(host->irq, mxcmci_irq, 0, DRIVER_NAME, host);
@@ -891,9 +913,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 out_free_irq:
 	free_irq(host->irq, host);
 out_free_dma:
-#ifdef HAS_DMA
-	imx_dma_free(host->dma);
-#endif
+	if (host->dma)
+		dma_release_channel(host->dma);
 out_clk_put:
 	clk_disable(host->clk);
 	clk_put(host->clk);
@@ -920,9 +941,10 @@ static int mxcmci_remove(struct platform_device *pdev)
 
 	free_irq(host->irq, host);
 	iounmap(host->base);
-#ifdef HAS_DMA
-	imx_dma_free(host->dma);
-#endif
+
+	if (host->dma)
+		dma_release_channel(host->dma);
+
 	clk_disable(host->clk);
 	clk_put(host->clk);
 
-- 
1.7.2.3

