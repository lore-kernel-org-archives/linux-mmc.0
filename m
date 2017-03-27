From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/2] mmc: use new functions mmc_dma_(un)map_sg in host drivers
Date: Mon, 27 Mar 2017 20:29:07 +0200
Message-ID: <4194c3b3-f88e-2c9f-806c-b20e83101a3a@gmail.com>
References: <11e5aed4-c3ca-0d04-484a-9387302eaff2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36476 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdC0Sad (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 14:30:33 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so15798014wra.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 11:29:21 -0700 (PDT)
In-Reply-To: <11e5aed4-c3ca-0d04-484a-9387302eaff2@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Use new core functions mmc_dma_(un)map_sg in host drivers where applicable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/atmel-mci.c   | 17 +++++------------
 drivers/mmc/host/davinci_mmc.c | 10 +++-------
 drivers/mmc/host/dw_mmc.c      | 15 +++------------
 drivers/mmc/host/jz4740_mmc.c  | 10 ++--------
 drivers/mmc/host/mmci.c        |  9 +++------
 drivers/mmc/host/moxart-mmc.c  |  8 ++------
 drivers/mmc/host/mtk-sd.c      |  6 ++----
 drivers/mmc/host/mvsdio.c      |  7 ++-----
 drivers/mmc/host/omap.c        | 17 +++++------------
 drivers/mmc/host/omap_hsmmc.c  | 16 ++++------------
 drivers/mmc/host/s3cmci.c      |  6 ++----
 drivers/mmc/host/sdhci.c       | 10 +++-------
 drivers/mmc/host/sunxi-mmc.c   |  9 +++------
 13 files changed, 39 insertions(+), 101 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 388e4a3f..e7f88aba 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -952,9 +952,7 @@ static void atmci_pdc_cleanup(struct atmel_mci *host)
 	struct mmc_data         *data = host->data;
 
 	if (data)
-		dma_unmap_sg(&host->pdev->dev,
-				data->sg, data->sg_len,
-				mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(&host->pdev->dev, data);
 }
 
 /*
@@ -990,9 +988,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 	struct mmc_data                 *data = host->data;
 
 	if (data)
-		dma_unmap_sg(host->dma.chan->device->dev,
-				data->sg, data->sg_len,
-				mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(host->dma.chan->device->dev, data);
 }
 
 /*
@@ -1117,8 +1113,7 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 
 	/* Configure PDC */
 	host->data_size = data->blocks * data->blksz;
-	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
-			    mmc_get_dma_dir(data));
+	sg_len = mmc_dma_map_sg(&host->pdev->dev, data);
 
 	if ((!host->caps.has_rwproof)
 	    && (host->data->flags & MMC_DATA_WRITE)) {
@@ -1192,8 +1187,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) |
 			ATMCI_DMAEN);
 
-	sglen = dma_map_sg(chan->device->dev, data->sg,
-			data->sg_len, mmc_get_dma_dir(data));
+	sglen = mmc_dma_map_sg(chan->device->dev, data);
 
 	dmaengine_slave_config(chan, &host->dma_conf);
 	desc = dmaengine_prep_slave_sg(chan,
@@ -1208,8 +1202,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	return iflags;
 unmap_exit:
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	mmc_dma_unmap_sg(chan->device->dev, data);
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 621ce47e..39811ee1 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -477,15 +477,12 @@ static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 	int mask = rw_threshold - 1;
 	int ret = 0;
 
-	host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				  mmc_get_dma_dir(data));
+	host->sg_len = mmc_dma_map_sg(mmc_dev(host->mmc), data);
 
 	/* no individual DMA segment should need a partial FIFO */
 	for (i = 0; i < host->sg_len; i++) {
 		if (sg_dma_len(data->sg + i) & mask) {
-			dma_unmap_sg(mmc_dev(host->mmc),
-				     data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 			return -1;
 		}
 	}
@@ -797,8 +794,7 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 	if (host->do_dma) {
 		davinci_abort_dma(host);
 
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 		host->do_dma = false;
 	}
 	host->data_dir = DAVINCI_MMC_DATADIR_NONE;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 249ded65..9dffe99f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -436,10 +436,7 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
 	struct mmc_data *data = host->data;
 
 	if (data && data->host_cookie == COOKIE_MAPPED) {
-		dma_unmap_sg(host->dev,
-			     data->sg,
-			     data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(host->dev, data);
 		data->host_cookie = COOKIE_UNMAPPED;
 	}
 }
@@ -892,10 +889,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 			return -EINVAL;
 	}
 
-	sg_len = dma_map_sg(host->dev,
-			    data->sg,
-			    data->sg_len,
-			    mmc_get_dma_dir(data));
+	sg_len = mmc_dma_map_sg(host->dev, data);
 	if (sg_len == 0)
 		return -EINVAL;
 
@@ -932,10 +926,7 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 		return;
 
 	if (data->host_cookie != COOKIE_UNMAPPED)
-		dma_unmap_sg(slot->host->dev,
-			     data->sg,
-			     data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(slot->host->dev, data);
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 57e254aa..fcd05f8d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -210,9 +210,8 @@ static void jz4740_mmc_dma_unmap(struct jz4740_mmc_host *host,
 				 struct mmc_data *data)
 {
 	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
-	enum dma_data_direction dir = mmc_get_dma_dir(data);
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	mmc_dma_unmap_sg(chan->device->dev, data);
 }
 
 /* Prepares DMA data for current/next transfer, returns non-zero on failure */
@@ -222,7 +221,6 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 				       struct dma_chan *chan)
 {
 	struct jz4740_mmc_host_next *next_data = &host->next_data;
-	enum dma_data_direction dir = mmc_get_dma_dir(data);
 	int sg_len;
 
 	if (!next && data->host_cookie &&
@@ -237,11 +235,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 
 	/* Check if next job is already prepared */
 	if (next || data->host_cookie != host->next_data.cookie) {
-		sg_len = dma_map_sg(chan->device->dev,
-				    data->sg,
-				    data->sg_len,
-				    dir);
-
+		sg_len = mmc_dma_map_sg(chan->device->dev, data);
 	} else {
 		sg_len = next_data->sg_len;
 		next_data->sg_len = 0;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d1ca2f48..59eaa15d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -522,8 +522,7 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	else
 		chan = host->dma_tx_channel;
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	mmc_dma_unmap_sg(chan->device->dev, data);
 }
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
@@ -606,8 +605,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 		return -EINVAL;
 
 	device = chan->device;
-	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
-			   mmc_get_dma_dir(data));
+	nr_sg = mmc_dma_map_sg(device->dev, data);
 	if (nr_sg == 0)
 		return -EINVAL;
 
@@ -626,8 +624,7 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return 0;
 
  unmap_exit:
-	dma_unmap_sg(device->dev, data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	mmc_dma_unmap_sg(device->dev, data);
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d4dc55ac..24a21eca 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -272,9 +272,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 		dir_slave = DMA_DEV_TO_MEM;
 	}
 
-	len = dma_map_sg(dma_chan->device->dev, data->sg,
-			 data->sg_len, mmc_get_dma_dir(data));
-
+	len = mmc_dma_map_sg(dma_chan->device->dev, data);
 	if (len > 0) {
 		desc = dmaengine_prep_slave_sg(dma_chan, data->sg,
 					       len, dir_slave,
@@ -297,9 +295,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 	dma_time = wait_for_completion_interruptible_timeout(
 		   &host->dma_complete, host->timeout);
 
-	dma_unmap_sg(dma_chan->device->dev,
-		     data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	mmc_dma_unmap_sg(dma_chan->device->dev, data);
 }
 
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5c1e178f..2aef3c94 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -475,8 +475,7 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
 
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
 		data->host_cookie |= MSDC_PREPARE_FLAG;
-		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
-					    mmc_get_dma_dir(data));
+		data->sg_count = mmc_dma_map_sg(host->dev, data);
 	}
 }
 
@@ -488,8 +487,7 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
 		return;
 
 	if (data->host_cookie & MSDC_PREPARE_FLAG) {
-		dma_unmap_sg(host->dev, data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(host->dev, data);
 		data->host_cookie &= ~MSDC_PREPARE_FLAG;
 	}
 }
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 58d74b8d..61f38e7c 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -126,9 +126,7 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	} else {
 		dma_addr_t phys_addr;
 
-		host->sg_frags = dma_map_sg(mmc_dev(host->mmc),
-					    data->sg, data->sg_len,
-					    mmc_get_dma_dir(data));
+		host->sg_frags = mmc_dma_map_sg(mmc_dev(host->mmc), data);
 		phys_addr = sg_dma_address(data->sg);
 		mvsd_write(MVSD_SYS_ADDR_LOW, (u32)phys_addr & 0xffff);
 		mvsd_write(MVSD_SYS_ADDR_HI,  (u32)phys_addr >> 16);
@@ -293,8 +291,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 	}
 
 	if (err_status & MVSD_ERR_DATA_TIMEOUT)
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index bd49f34d..fee3d1b6 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -404,17 +404,14 @@ static void
 mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
 		     int abort)
 {
-	enum dma_data_direction dma_data_dir;
 	struct device *dev = mmc_dev(host->mmc);
 	struct dma_chan *c;
 
-	if (data->flags & MMC_DATA_WRITE) {
-		dma_data_dir = DMA_TO_DEVICE;
+	if (data->flags & MMC_DATA_WRITE)
 		c = host->dma_tx;
-	} else {
-		dma_data_dir = DMA_FROM_DEVICE;
+	else
 		c = host->dma_rx;
-	}
+
 	if (c) {
 		if (data->error) {
 			dmaengine_terminate_all(c);
@@ -423,7 +420,7 @@ mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
 		}
 		dev = c->device->dev;
 	}
-	dma_unmap_sg(dev, data->sg, host->sg_len, dma_data_dir);
+	mmc_dma_unmap_sg(dev, data);
 }
 
 static void mmc_omap_send_stop_work(struct work_struct *work)
@@ -981,7 +978,6 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 
 	host->sg_idx = 0;
 	if (use_dma) {
-		enum dma_data_direction dma_data_dir;
 		struct dma_async_tx_descriptor *tx;
 		struct dma_chan *c;
 		u32 burst, *bp;
@@ -1003,12 +999,10 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 			c = host->dma_tx;
 			bp = &host->dma_tx_burst;
 			buf = 0x0f80 | (burst - 1) << 0;
-			dma_data_dir = DMA_TO_DEVICE;
 		} else {
 			c = host->dma_rx;
 			bp = &host->dma_rx_burst;
 			buf = 0x800f | (burst - 1) << 8;
-			dma_data_dir = DMA_FROM_DEVICE;
 		}
 
 		if (!c)
@@ -1033,8 +1027,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 			*bp = burst;
 		}
 
-		host->sg_len = dma_map_sg(c->device->dev, data->sg, sg_len,
-					  dma_data_dir);
+		host->sg_len = mmc_dma_map_sg(c->device->dev, data);
 		if (host->sg_len == 0)
 			goto use_pio;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bf64cf23..5c5d4aea 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1044,10 +1044,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
 
 		dmaengine_terminate_all(chan);
-		dma_unmap_sg(chan->device->dev,
-			host->data->sg, host->data->sg_len,
-			mmc_get_dma_dir(host->data));
-
+		mmc_dma_unmap_sg(chan->device->dev, host->data);
 		host->data->host_cookie = 0;
 	}
 	host->data = NULL;
@@ -1339,9 +1336,7 @@ static void omap_hsmmc_dma_callback(void *param)
 	data = host->mrq->data;
 	chan = omap_hsmmc_get_dma_chan(host, data);
 	if (!data->host_cookie)
-		dma_unmap_sg(chan->device->dev,
-			     data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(chan->device->dev, data);
 
 	req_in_progress = host->req_in_progress;
 	host->dma_ch = -1;
@@ -1373,9 +1368,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 
 	/* Check if next job is already prepared */
 	if (next || data->host_cookie != host->next_data.cookie) {
-		dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
-
+		dma_len = mmc_dma_map_sg(chan->device->dev, data);
 	} else {
 		dma_len = host->next_data.dma_len;
 		host->next_data.dma_len = 0;
@@ -1559,8 +1552,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (host->use_dma && data->host_cookie) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
 
-		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(c->device->dev, data);
 		data->host_cookie = 0;
 	}
 }
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 09eab212..bd85d37a 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1092,8 +1092,7 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 	else
 		conf.direction = DMA_MEM_TO_DEV;
 
-	dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		   mmc_get_dma_dir(data));
+	mmc_dma_map_sg(mmc_dev(host->mmc), data);
 
 	dmaengine_slave_config(host->dma, &conf);
 	desc = dmaengine_prep_slave_sg(host->dma, data->sg, data->sg_len,
@@ -1109,8 +1108,7 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 	return 0;
 
 unmap_exit:
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 81198139..52130155 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -501,9 +501,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	if (data->host_cookie == COOKIE_PRE_MAPPED)
 		return data->sg_count;
 
-	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			      mmc_get_dma_dir(data));
-
+	sg_count = mmc_dma_map_sg(mmc_dev(host->mmc), data);
 	if (sg_count == 0)
 		return -ENOSPC;
 
@@ -2211,8 +2209,7 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmc_data *data = mrq->data;
 
 	if (data->host_cookie != COOKIE_UNMAPPED)
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(mmc_dev(host->mmc), dataa);
 
 	data->host_cookie = COOKIE_UNMAPPED;
 }
@@ -2327,8 +2324,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		struct mmc_data *data = mrq->data;
 
 		if (data && data->host_cookie == COOKIE_MAPPED) {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 			data->host_cookie = COOKIE_UNMAPPED;
 		}
 	}
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d6fa2214..a896c8cd 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -391,8 +391,7 @@ static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
 	u32 i, dma_len;
 	struct scatterlist *sg;
 
-	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+	dma_len = mmc_dma_map_sg(mmc_dev(host->mmc), data);
 	if (dma_len == 0) {
 		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
 		return -ENOMEM;
@@ -542,8 +541,7 @@ static irqreturn_t sunxi_mmc_finalize_request(struct sunxi_mmc_host *host)
 		mmc_writel(host, REG_GCTRL, rval);
 		rval |= SDXC_FIFO_RESET;
 		mmc_writel(host, REG_GCTRL, rval);
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
+		mmc_dma_unmap_sg(mmc_dev(host->mmc), data);
 	}
 
 	mmc_writel(host, REG_RINTR, 0xffff);
@@ -1013,8 +1011,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		spin_unlock_irqrestore(&host->lock, iflags);
 
 		if (data)
-			dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
-				     mmc_get_dma_dir(data));
+			mmc_dma_unmap_sg(mmc_dev(mmc), data);
 
 		dev_err(mmc_dev(mmc), "request already pending\n");
 		mrq->cmd->error = -EBUSY;
-- 
2.12.1


