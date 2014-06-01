From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v3] s3cmci: port DMA code to dmaengine API
Date: Sun,  1 Jun 2014 20:22:09 +0300
Message-ID: <1401643329-6460-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:53410 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbaFARYR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Jun 2014 13:24:17 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so4171952wes.28
        for <linux-mmc@vger.kernel.org>; Sun, 01 Jun 2014 10:24:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>

Utilise new s3c24xx-dma dmaengine driver for DMA ops.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: - Don't store async dma descriptor, it's not used
    - Request DMA channel via dma_request_slave_channel_compat() and use
      hardcoded DMA channel.
    - Add dependency on S3C24XX_DMAC (s3cmci uses filter function from it)
v3: - Use 'depends' instead of 'select' in Kconfig
    - Drop useless controller registers reads from dma completion callback

 drivers/mmc/host/Kconfig  |  10 +--
 drivers/mmc/host/s3cmci.c | 180 +++++++++++++---------------------------------
 drivers/mmc/host/s3cmci.h |   4 +-
 3 files changed, 52 insertions(+), 142 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1384f67..0cd10e3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -420,6 +420,7 @@ config MMC_SPI
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
 	depends on ARCH_S3C24XX
+	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
           Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
@@ -457,15 +458,6 @@ config MMC_S3C_DMA
 	  working properly and needs to be debugged before this
 	  option is useful.
 
-config MMC_S3C_PIODMA
-	bool "Support for both PIO and DMA"
-	help
-	  Compile both the PIO and DMA transfer routines into the
-	  driver and let the platform select at run-time which one
-	  is best.
-
-	  See notes for the DMA option.
-
 endchoice
 
 config MMC_SDRICOH_CS
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f237826..0d115a8 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
@@ -27,6 +28,7 @@
 #include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 
+#include <linux/platform_data/dma-s3c24xx.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 
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
@@ -256,25 +254,8 @@ static inline bool s3cmci_host_usedma(struct s3cmci_host *host)
 {
 #ifdef CONFIG_MMC_S3C_PIO
 	return false;
-#elif defined(CONFIG_MMC_S3C_DMA)
+#else /* CONFIG_MMC_S3C_DMA */
 	return true;
-#else
-	return host->dodma;
-#endif
-}
-
-/**
- * s3cmci_host_canpio - return true if host has pio code available
- *
- * Return true if the driver has been compiled with the PIO support code
- * available.
- */
-static inline bool s3cmci_host_canpio(void)
-{
-#ifdef CONFIG_MMC_S3C_PIO
-	return true;
-#else
-	return false;
 #endif
 }
 
@@ -841,60 +822,24 @@ static irqreturn_t s3cmci_irq_cd(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void s3cmci_dma_done_callback(struct s3c2410_dma_chan *dma_ch,
-				     void *buf_id, int size,
-				     enum s3c2410_dma_buffresult result)
+static void s3cmci_dma_done_callback(void *arg)
 {
-	struct s3cmci_host *host = buf_id;
+	struct s3cmci_host *host = arg;
 	unsigned long iflags;
-	u32 mci_csta, mci_dsta, mci_fsta, mci_dcnt;
-
-	mci_csta = readl(host->base + S3C2410_SDICMDSTAT);
-	mci_dsta = readl(host->base + S3C2410_SDIDSTA);
-	mci_fsta = readl(host->base + S3C2410_SDIFSTA);
-	mci_dcnt = readl(host->base + S3C2410_SDIDCNT);
 
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
+	dbg(host, dbg_dma, "DMA FINISHED\n");
 
 	host->dma_complete = 1;
 	host->complete_what = COMPLETION_FINALIZE;
 
-out:
 	tasklet_schedule(&host->pio_tasklet);
 	spin_unlock_irqrestore(&host->complete_lock, iflags);
-	return;
 
-fail_request:
-	host->mrq->data->error = -EINVAL;
-	host->complete_what = COMPLETION_FINALIZE;
-	clear_imask(host);
-
-	goto out;
 }
 
 static void finalize_request(struct s3cmci_host *host)
@@ -966,7 +911,7 @@ static void finalize_request(struct s3cmci_host *host)
 	 * DMA channel and the fifo to clear out any garbage. */
 	if (mrq->data->error != 0) {
 		if (s3cmci_host_usedma(host))
-			s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
+			dmaengine_terminate_all(host->dma);
 
 		if (host->is2440) {
 			/* Clear failure register and reset fifo. */
@@ -992,29 +937,6 @@ request_done:
 	mmc_request_done(host->mmc, mrq);
 }
 
-static void s3cmci_dma_setup(struct s3cmci_host *host,
-			     enum dma_data_direction source)
-{
-	static enum dma_data_direction last_source = -1;
-	static int setup_ok;
-
-	if (last_source == source)
-		return;
-
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
-	}
-}
-
 static void s3cmci_send_command(struct s3cmci_host *host,
 					struct mmc_command *cmd)
 {
@@ -1162,43 +1084,45 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
 static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 {
-	int dma_len, i;
 	int rw = data->flags & MMC_DATA_WRITE;
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config conf = {
+		.src_addr = host->mem->start + host->sdidata,
+		.dst_addr = host->mem->start + host->sdidata,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	s3cmci_dma_setup(host, rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
-
-	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-	if (dma_len == 0)
-		return -ENOMEM;
-
-	host->dma_complete = 0;
-	host->dmatogo = dma_len;
-
-	for (i = 0; i < dma_len; i++) {
-		int res;
-
-		dbg(host, dbg_dma, "enqueue %i: %08x@%u\n", i,
-		    sg_dma_address(&data->sg[i]),
-		    sg_dma_len(&data->sg[i]));
+	/* Restore prescaler value */
+	writel(host->prescaler, host->base + S3C2410_SDIPRE);
 
-		res = s3c2410_dma_enqueue(host->dma, host,
-					  sg_dma_address(&data->sg[i]),
-					  sg_dma_len(&data->sg[i]));
+	if (!rw)
+		conf.direction = DMA_DEV_TO_MEM;
+	else
+		conf.direction = DMA_MEM_TO_DEV;
 
-		if (res) {
-			s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
-			return -EBUSY;
-		}
-	}
+	dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_START);
+	dmaengine_slave_config(host->dma, &conf);
+	desc = dmaengine_prep_slave_sg(host->dma, data->sg, data->sg_len,
+		conf.direction,
+		DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc)
+		goto unmap_exit;
+	desc->callback = s3cmci_dma_done_callback;
+	desc->callback_param = host;
+	dmaengine_submit(desc);
+	dma_async_issue_pending(host->dma);
 
 	return 0;
+
+unmap_exit:
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	return -ENOMEM;
 }
 
 static void s3cmci_send_request(struct mmc_host *mmc)
@@ -1676,10 +1600,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 	host->complete_what 	= COMPLETION_NONE;
 	host->pio_active 	= XFER_NONE;
 
-#ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->use_dma;
-#endif
-
 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!host->mem) {
 		dev_err(&pdev->dev,
@@ -1765,17 +1685,17 @@ static int s3cmci_probe(struct platform_device *pdev)
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
+		host->dma = dma_request_slave_channel_compat(mask,
+			s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
+		if (!host->dma) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
-			if (!s3cmci_host_canpio()) {
-				ret = -EBUSY;
-				goto probe_free_gpio_wp;
-			} else {
-				dev_warn(&pdev->dev, "falling back to PIO.\n");
-				host->dodma = 0;
-			}
+			ret = -EBUSY;
+			goto probe_free_gpio_wp;
 		}
 	}
 
@@ -1816,7 +1736,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	mmc->max_segs		= 128;
 
 	dbg(host, dbg_debug,
-	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%u.\n",
+	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%p.\n",
 	    (host->is2440?"2440":""),
 	    host->base, host->irq, host->irq_cd, host->dma);
 
@@ -1852,7 +1772,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 
  probe_free_dma:
 	if (s3cmci_host_usedma(host))
-		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
+		dma_release_channel(host->dma);
 
  probe_free_gpio_wp:
 	if (!host->pdata->no_wprotect)
@@ -1914,7 +1834,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 	tasklet_disable(&host->pio_tasklet);
 
 	if (s3cmci_host_usedma(host))
-		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
+		dma_release_channel(host->dma);
 
 	free_irq(host->irq, host);
 
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index c76b53d..cc2e46c 100644
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
@@ -36,8 +36,6 @@ struct s3cmci_host {
 	int			is2440;
 	unsigned		sdiimsk;
 	unsigned		sdidata;
-	int			dodma;
-	int			dmatogo;
 
 	bool			irq_disabled;
 	bool			irq_enabled;
-- 
1.9.3

