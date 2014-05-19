From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Mon, 19 May 2014 20:18:58 +0200
Message-ID: <7633675.1cAc12AFAY@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaESST3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 May 2014 14:19:29 -0400
In-Reply-To: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 19 May 2014 21:03:13 Vasily Khoruzhick wrote:
> Utilise new s3c24xx-dma dmaengine driver for DMA ops.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Very nice!

I had done a similar conversion earlier but not tested and only
posted in a reply to another thread. I'd assume that your
version is better and that you have actually tested it, but just
for reference, here is what I had. Maybe it helps you to take
a look at my version to see if there is something you missed.

Here are the differences I found:

- I don't save the 'desc' pointer as you do, but I don't see it used
  anywhere.
- I did not remove MMC_S3C_PIODMA, but I don't see anything wrong
  with yours there
- the slave config setup is slightly different
- I hardcode the DMA request number, while you pass it as a resource.
  Actually both are wrong I guess, it should be platform data instead.
 
	Arnd

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f237826..02847d3 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
@@ -28,6 +29,7 @@
 #include <mach/gpio-samsung.h>
 
 #include <linux/platform_data/mmc-s3cmci.h>
+#include <linux/platform_data/dma-s3c24xx.h>
 
 #include "s3cmci.h"
 
@@ -140,10 +142,6 @@ static const int dbgmap_debug = dbg_err | dbg_debug;
 		dev_dbg(&host->pdev->dev, args);  \
 	} while (0)
 
-static struct s3c2410_dma_client s3cmci_dma_client = {
-	.name		= "s3c-mci",
-};
-
 static void finalize_request(struct s3cmci_host *host);
 static void s3cmci_send_request(struct mmc_host *mmc);
 static void s3cmci_reset(struct s3cmci_host *host);
@@ -841,9 +839,7 @@ static irqreturn_t s3cmci_irq_cd(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void s3cmci_dma_done_callback(struct s3c2410_dma_chan *dma_ch,
-				     void *buf_id, int size,
-				     enum s3c2410_dma_buffresult result)
+static void s3cmci_dma_done_callback(void *buf_id)
 {
 	struct s3cmci_host *host = buf_id;
 	unsigned long iflags;
@@ -856,45 +852,18 @@ static void s3cmci_dma_done_callback(struct s3c2410_dma_chan *dma_ch,
 
 	BUG_ON(!host->mrq);
 	BUG_ON(!host->mrq->data);
-	BUG_ON(!host->dmatogo);
 
 	spin_lock_irqsave(&host->complete_lock, iflags);
 
-	if (result != S3C2410_RES_OK) {
-		dbg(host, dbg_fail, "DMA FAILED: csta=0x%08x dsta=0x%08x "
-			"fsta=0x%08x dcnt:0x%08x result:0x%08x toGo:%u\n",
-			mci_csta, mci_dsta, mci_fsta,
-			mci_dcnt, result, host->dmatogo);
-
-		goto fail_request;
-	}
-
-	host->dmatogo--;
-	if (host->dmatogo) {
-		dbg(host, dbg_dma, "DMA DONE  Size:%i DSTA:[%08x] "
-			"DCNT:[%08x] toGo:%u\n",
-			size, mci_dsta, mci_dcnt, host->dmatogo);
-
-		goto out;
-	}
-
-	dbg(host, dbg_dma, "DMA FINISHED Size:%i DSTA:%08x DCNT:%08x\n",
-		size, mci_dsta, mci_dcnt);
+	dbg(host, dbg_dma, "DMA FINISHED DSTA:%08x DCNT:%08x\n",
+		mci_dsta, mci_dcnt);
 
 	host->dma_complete = 1;
 	host->complete_what = COMPLETION_FINALIZE;
 
-out:
 	tasklet_schedule(&host->pio_tasklet);
 	spin_unlock_irqrestore(&host->complete_lock, iflags);
 	return;
-
-fail_request:
-	host->mrq->data->error = -EINVAL;
-	host->complete_what = COMPLETION_FINALIZE;
-	clear_imask(host);
-
-	goto out;
 }
 
 static void finalize_request(struct s3cmci_host *host)
@@ -966,7 +935,7 @@ static void finalize_request(struct s3cmci_host *host)
 	 * DMA channel and the fifo to clear out any garbage. */
 	if (mrq->data->error != 0) {
 		if (s3cmci_host_usedma(host))
-			s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
+			dmaengine_terminate_all(host->dma);
 
 		if (host->is2440) {
 			/* Clear failure register and reset fifo. */
@@ -993,26 +962,27 @@ request_done:
 }
 
 static void s3cmci_dma_setup(struct s3cmci_host *host,
-			     enum dma_data_direction source)
+			     enum dma_transfer_direction source)
 {
-	static enum dma_data_direction last_source = -1;
-	static int setup_ok;
+	static enum dma_transfer_direction last_source = -1;
+	struct dma_slave_config slave_config;
 
 	if (last_source == source)
 		return;
 
-	last_source = source;
-
-	s3c2410_dma_devconfig(host->dma, source,
-			      host->mem->start + host->sdidata);
-
-	if (!setup_ok) {
-		s3c2410_dma_config(host->dma, 4);
-		s3c2410_dma_set_buffdone_fn(host->dma,
-					    s3cmci_dma_done_callback);
-		s3c2410_dma_setflags(host->dma, S3C2410_DMAF_AUTOSTART);
-		setup_ok = 1;
+	memset(&slave_config, 0, sizeof(struct dma_slave_config));
+	slave_config.direction = source;
+	if (source == DMA_DEV_TO_MEM) {
+		slave_config.src_addr = host->mem->start + host->sdidata;
+		slave_config.src_addr_width = 4;
+		slave_config.src_maxburst = 1;
+	} else {
+		slave_config.dst_addr = host->mem->start + host->sdidata;
+		slave_config.dst_addr_width = 4;
+		slave_config.dst_maxburst = 1;
 	}
+	last_source = source;
+	dmaengine_slave_config(host->dma, &slave_config);
 }
 
 static void s3cmci_send_command(struct s3cmci_host *host,
@@ -1162,41 +1132,33 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
 static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 {
-	int dma_len, i;
-	int rw = data->flags & MMC_DATA_WRITE;
+	int dma_len;
+	int dir = data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	struct dma_async_tx_descriptor *desc;
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	s3cmci_dma_setup(host, rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
-
-	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	s3cmci_dma_setup(host, dir);
 
+	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len, dir);
 	if (dma_len == 0)
 		return -ENOMEM;
 
-	host->dma_complete = 0;
-	host->dmatogo = dma_len;
-
-	for (i = 0; i < dma_len; i++) {
-		int res;
+	desc = dmaengine_prep_slave_sg(host->dma, data->sg, dma_len,
+				       dir, DMA_CTRL_ACK);
 
-		dbg(host, dbg_dma, "enqueue %i: %08x@%u\n", i,
-		    sg_dma_address(&data->sg[i]),
-		    sg_dma_len(&data->sg[i]));
+	if (!desc) {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, dma_len, dir);
+		return -EIO;
+	}
 
-		res = s3c2410_dma_enqueue(host->dma, host,
-					  sg_dma_address(&data->sg[i]),
-					  sg_dma_len(&data->sg[i]));
+	host->dma_complete = 0;
 
-		if (res) {
-			s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
-			return -EBUSY;
-		}
-	}
+	desc->callback = s3cmci_dma_done_callback;
+	desc->callback_param = host;
 
-	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_START);
+	dmaengine_submit(desc);
+	dma_async_issue_pending(host->dma);
 
 	return 0;
 }
@@ -1765,9 +1727,14 @@ static int s3cmci_probe(struct platform_device *pdev)
 	/* depending on the dma state, get a dma channel to use. */
 
 	if (s3cmci_host_usedma(host)) {
-		host->dma = s3c2410_dma_request(DMACH_SDI, &s3cmci_dma_client,
-						host);
-		if (host->dma < 0) {
+		dma_cap_mask_t mask;
+        
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		host->dma = dma_request_channel(mask, s3c24xx_dma_filter, (void *)DMACH_SDI);
+
+		if (!host->dma) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
 			if (!s3cmci_host_canpio()) {
 				ret = -EBUSY;
@@ -1816,9 +1783,9 @@ static int s3cmci_probe(struct platform_device *pdev)
 	mmc->max_segs		= 128;
 
 	dbg(host, dbg_debug,
-	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%u.\n",
+	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u.\n",
 	    (host->is2440?"2440":""),
-	    host->base, host->irq, host->irq_cd, host->dma);
+	    host->base, host->irq, host->irq_cd);
 
 	ret = s3cmci_cpufreq_register(host);
 	if (ret) {
@@ -1852,7 +1819,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 
  probe_free_dma:
 	if (s3cmci_host_usedma(host))
-		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
+		dma_release_channel(host->dma);
 
  probe_free_gpio_wp:
 	if (!host->pdata->no_wprotect)
@@ -1914,7 +1881,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 	tasklet_disable(&host->pio_tasklet);
 
 	if (s3cmci_host_usedma(host))
-		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
+		dma_release_channel(host->dma);
 
 	free_irq(host->irq, host);
 
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index c76b53d..514a887 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -26,7 +26,7 @@ struct s3cmci_host {
 	void __iomem		*base;
 	int			irq;
 	int			irq_cd;
-	int			dma;
+	struct dma_chan		*dma;
 
 	unsigned long		clk_rate;
 	unsigned long		clk_div;

