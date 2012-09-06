From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] mmc: mxcmmc: fix bug that may block a data transfer forever.
Date: Thu,  6 Sep 2012 09:40:48 +0200
Message-ID: <1346917248-6685-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42309 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab2IFHlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Sep 2012 03:41:13 -0400
Received: by wibhq12 with SMTP id hq12so5128350wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Sep 2012 00:41:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com, Javier Martin <javier.martin@vista-silicon.com>

The problem can be easily reproduced using a script that loops
copying a file in an SD card to another place in the same SD card
and its related to read transfers. This only happens with DMA enabled.

This is related to the fact that, when reading, an MMC irq signals
the fact that all data from the SD card has been copied to the
internal buffers. However, it doesn't signal whether the DMA transfer
that is in charge of moving data from these internal buffers to RAM
has finished or not. Thus, calling dmaengine_terminate_all() in the
MMC irq routine can cancel an ongoing DMA transfer leaving some data
in the internal buffers that produces an accumulative effect which,
in the end, blocks a read data transfer forever.

The following patch watches DMA and MMC irqs and makes sure both have
arrived before marking any transfer as finished. The 'dangerous' usage
of dmaengine_terminate_all() is removed and a timeout of 2 seconds
is added so that the MMC won't block forever anymore.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/mmc/host/mxcmmc.c |   97 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 28ed52d..4907d40 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -150,6 +150,11 @@ struct mxcmci_host {
 	int			dmareq;
 	struct dma_slave_config dma_slave_config;
 	struct imx_dma_data	dma_data;
+
+	bool			dmairq;
+	bool			mmcirq;
+	struct timer_list	watchdog;
+	spinlock_t		irqlock;
 };
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
@@ -213,6 +218,28 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 	writew(0xff, host->base + MMC_REG_RES_TO);
 }
 static int mxcmci_setup_dma(struct mmc_host *mmc);
+static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat);
+
+static void mxcmci_dma_irq_callback(void *param)
+{
+	struct mxcmci_host *host = param;
+	u32 stat = readl(host->base + MMC_REG_STATUS);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irqlock, flags);
+
+	host->dmairq = true;
+	if (host->mmcirq) {
+		del_timer(&host->watchdog);
+		host->mmcirq = false;
+		host->dmairq = false;
+		mxcmci_data_done(host, stat);
+	}
+
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
+	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
+}
 
 static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 {
@@ -268,9 +295,13 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	}
 	wmb();
 
+	host->desc->callback = mxcmci_dma_irq_callback;
+	host->desc->callback_param = host;
 	dmaengine_submit(host->desc);
 	dma_async_issue_pending(host->dma);
 
+	mod_timer(&host->watchdog, jiffies + msecs_to_jiffies(2000));
+
 	return 0;
 }
 
@@ -345,11 +376,9 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	int data_error;
 
-	if (mxcmci_use_dma(host)) {
-		dmaengine_terminate_all(host->dma);
+	if (mxcmci_use_dma(host))
 		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
 				host->dma_dir);
-	}
 
 	if (stat & STATUS_ERR_MASK) {
 		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
@@ -624,8 +653,18 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 		mxcmci_cmd_done(host, stat);
 
 	if (mxcmci_use_dma(host) &&
-		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
-		mxcmci_data_done(host, stat);
+		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE))) {
+		spin_lock_irqsave(&host->irqlock, flags);
+		host->mmcirq = true;
+		if (host->dmairq) {
+			del_timer(&host->watchdog);
+			host->mmcirq = false;
+			host->dmairq = false;
+			mxcmci_data_done(host, stat);
+		}
+		spin_unlock_irqrestore(&host->irqlock, flags);
+
+	}
 
 	if (host->default_irq_mask &&
 		  (stat & (STATUS_CARD_INSERTION | STATUS_CARD_REMOVAL)))
@@ -844,6 +883,48 @@ static const struct mmc_host_ops mxcmci_ops = {
 	.init_card		= mxcmci_init_card,
 };
 
+static void mxcmci_watchdog(unsigned long data)
+{
+	struct mmc_host *mmc = (struct mmc_host *)data;
+	struct mxcmci_host *host = mmc_priv(mmc);
+	struct mmc_request *req = host->req;
+	unsigned int stat = readl(host->base + MMC_REG_STATUS);
+	unsigned long flags;
+
+	dev_err(mmc_dev(host->mmc), "%s: mmc status = 0x%08x\n", __func__, stat);
+
+	spin_lock_irqsave(&host->irqlock, flags);
+	/* Protect agains spurius triggers */
+	if (host->dmairq && host->mmcirq) {
+		dev_err(mmc_dev(host->mmc), "%s: spurius timeout\n", __func__);
+		host->mmcirq = false;
+		host->dmairq = false;
+		return;
+	}
+
+	if (!host->dmairq) {
+		dev_err(mmc_dev(host->mmc), "%s: irq from DMA didn't arrive\n", __func__);
+		dmaengine_terminate_all(host->dma);
+	}
+	if (!host->mmcirq) {
+		dev_err(mmc_dev(host->mmc), "%s: irq from MMC didn't arrive\n", __func__);
+		mxcmci_softreset(host);
+	}
+
+	host->mmcirq = false;
+	host->dmairq = false;
+	spin_unlock_irqrestore(&host->irqlock, flags);
+
+	/* Mark transfer as erroneus and inform the upper layers */
+	host->data->error = -ETIMEDOUT;
+
+	host->req = NULL;
+	host->cmd = NULL;
+	host->data = NULL;
+
+	mmc_request_done(host->mmc, req);
+}
+
 static int mxcmci_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
@@ -889,6 +970,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->pdata = pdev->dev.platform_data;
 	spin_lock_init(&host->lock);
+	spin_lock_init(&host->irqlock);
 
 	mxcmci_init_ocr(host);
 
@@ -968,6 +1050,11 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	mmc_add_host(mmc);
 
+	/* DMA watchdog */
+	init_timer(&host->watchdog);
+	host->watchdog.function = &mxcmci_watchdog;
+	host->watchdog.data = (unsigned long)mmc;
+
 	return 0;
 
 out_free_irq:
-- 
1.7.9.5

