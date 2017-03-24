From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/2] mmc: use new core function mmc_get_dma_dir
Date: Fri, 24 Mar 2017 21:07:21 +0100
Message-ID: <339c021c-725a-e421-b5ef-15c2e1935d6e@gmail.com>
References: <7f8a382e-ff2f-db2f-ef24-25cdee9d2f68@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35068 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965897AbdCXUHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 16:07:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so86747wrb.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 13:07:42 -0700 (PDT)
In-Reply-To: <7f8a382e-ff2f-db2f-ef24-25cdee9d2f68@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

Use new core function mmc_get_dma_dir().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
v2:
- use new function in more places
---
 drivers/mmc/host/android-goldfish.c | 10 ++--------
 drivers/mmc/host/atmel-mci.c        | 25 +++++++++----------------
 drivers/mmc/host/davinci_mmc.c      | 14 ++++----------
 drivers/mmc/host/dw_mmc.c           | 14 +++-----------
 drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
 drivers/mmc/host/mmc_spi.c          |  5 +----
 drivers/mmc/host/mmci.c             | 20 ++++++++------------
 drivers/mmc/host/moxart-mmc.c       |  8 +++-----
 drivers/mmc/host/mtk-sd.c           |  8 ++------
 drivers/mmc/host/mvsdio.c           | 11 +++++------
 drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  9 +++------
 drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
 14 files changed, 51 insertions(+), 117 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 590a8a45..5b3e1c9b 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -212,10 +212,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
 	if (host->dma_in_use) {
 		enum dma_data_direction dma_data_dir;
 
-		if (data->flags & MMC_DATA_WRITE)
-			dma_data_dir = DMA_TO_DEVICE;
-		else
-			dma_data_dir = DMA_FROM_DEVICE;
+		dma_data_dir = mmc_get_dma_dir(data);
 
 		if (dma_data_dir == DMA_FROM_DEVICE) {
 			/*
@@ -390,10 +387,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
 	 */
 	sg_len = (data->blocks == 1) ? 1 : data->sg_len;
 
-	if (data->flags & MMC_DATA_WRITE)
-		dma_data_dir = DMA_TO_DEVICE;
-	else
-		dma_data_dir = DMA_FROM_DEVICE;
+	dma_data_dir = mmc_get_dma_dir(data);
 
 	host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
 				  sg_len, dma_data_dir);
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 0ad8ef56..4708abcc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -954,8 +954,7 @@ static void atmci_pdc_cleanup(struct atmel_mci *host)
 	if (data)
 		dma_unmap_sg(&host->pdev->dev,
 				data->sg, data->sg_len,
-				((data->flags & MMC_DATA_WRITE)
-				 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+				mmc_get_dma_dir(data));
 }
 
 /*
@@ -993,8 +992,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 	if (data)
 		dma_unmap_sg(host->dma.chan->device->dev,
 				data->sg, data->sg_len,
-				((data->flags & MMC_DATA_WRITE)
-				 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+				mmc_get_dma_dir(data));
 }
 
 /*
@@ -1095,7 +1093,6 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 {
 	u32 iflags, tmp;
 	unsigned int sg_len;
-	enum dma_data_direction dir;
 	int i;
 
 	data->error = -EINPROGRESS;
@@ -1107,13 +1104,10 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 	/* Enable pdc mode */
 	atmci_writel(host, ATMCI_MR, host->mode_reg | ATMCI_MR_PDCMODE);
 
-	if (data->flags & MMC_DATA_READ) {
-		dir = DMA_FROM_DEVICE;
+	if (data->flags & MMC_DATA_READ)
 		iflags |= ATMCI_ENDRX | ATMCI_RXBUFF;
-	} else {
-		dir = DMA_TO_DEVICE;
+	else
 		iflags |= ATMCI_ENDTX | ATMCI_TXBUFE | ATMCI_BLKE;
-	}
 
 	/* Set BLKLEN */
 	tmp = atmci_readl(host, ATMCI_MR);
@@ -1123,7 +1117,8 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 
 	/* Configure PDC */
 	host->data_size = data->blocks * data->blksz;
-	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len, dir);
+	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
+			    mmc_get_dma_dir(data));
 
 	if ((!host->caps.has_rwproof)
 	    && (host->data->flags & MMC_DATA_WRITE)) {
@@ -1148,7 +1143,6 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	struct dma_async_tx_descriptor	*desc;
 	struct scatterlist		*sg;
 	unsigned int			i;
-	enum dma_data_direction		direction;
 	enum dma_transfer_direction	slave_dirn;
 	unsigned int			sglen;
 	u32				maxburst;
@@ -1186,12 +1180,10 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		return -ENODEV;
 
 	if (data->flags & MMC_DATA_READ) {
-		direction = DMA_FROM_DEVICE;
 		host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
 		maxburst = atmci_convert_chksize(host,
 						 host->dma_conf.src_maxburst);
 	} else {
-		direction = DMA_TO_DEVICE;
 		host->dma_conf.direction = slave_dirn = DMA_MEM_TO_DEV;
 		maxburst = atmci_convert_chksize(host,
 						 host->dma_conf.dst_maxburst);
@@ -1202,7 +1194,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 			ATMCI_DMAEN);
 
 	sglen = dma_map_sg(chan->device->dev, data->sg,
-			data->sg_len, direction);
+			data->sg_len, mmc_get_dma_dir(data));
 
 	dmaengine_slave_config(chan, &host->dma_conf);
 	desc = dmaengine_prep_slave_sg(chan,
@@ -1217,7 +1209,8 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	return iflags;
 unmap_exit:
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, direction);
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 1e2600da..621ce47e 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -478,18 +478,14 @@ static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 	int ret = 0;
 
 	host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				((data->flags & MMC_DATA_WRITE)
-				? DMA_TO_DEVICE
-				: DMA_FROM_DEVICE));
+				  mmc_get_dma_dir(data));
 
 	/* no individual DMA segment should need a partial FIFO */
 	for (i = 0; i < host->sg_len; i++) {
 		if (sg_dma_len(data->sg + i) & mask) {
 			dma_unmap_sg(mmc_dev(host->mmc),
-					data->sg, data->sg_len,
-					(data->flags & MMC_DATA_WRITE)
-					? DMA_TO_DEVICE
-					: DMA_FROM_DEVICE);
+				     data->sg, data->sg_len,
+				     mmc_get_dma_dir(data));
 			return -1;
 		}
 	}
@@ -802,9 +798,7 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 		davinci_abort_dma(host);
 
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     (data->flags & MMC_DATA_WRITE)
-			     ? DMA_TO_DEVICE
-			     : DMA_FROM_DEVICE);
+			     mmc_get_dma_dir(data));
 		host->do_dma = false;
 	}
 	host->data_dir = DAVINCI_MMC_DATADIR_NONE;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e165db05..249ded65 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -431,14 +431,6 @@ static void dw_mci_stop_dma(struct dw_mci *host)
 	set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 }
 
-static int dw_mci_get_dma_dir(struct mmc_data *data)
-{
-	if (data->flags & MMC_DATA_WRITE)
-		return DMA_TO_DEVICE;
-	else
-		return DMA_FROM_DEVICE;
-}
-
 static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
@@ -447,7 +439,7 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
 		dma_unmap_sg(host->dev,
 			     data->sg,
 			     data->sg_len,
-			     dw_mci_get_dma_dir(data));
+			     mmc_get_dma_dir(data));
 		data->host_cookie = COOKIE_UNMAPPED;
 	}
 }
@@ -903,7 +895,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 	sg_len = dma_map_sg(host->dev,
 			    data->sg,
 			    data->sg_len,
-			    dw_mci_get_dma_dir(data));
+			    mmc_get_dma_dir(data));
 	if (sg_len == 0)
 		return -EINVAL;
 
@@ -943,7 +935,7 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 		dma_unmap_sg(slot->host->dev,
 			     data->sg,
 			     data->sg_len,
-			     dw_mci_get_dma_dir(data));
+			     mmc_get_dma_dir(data));
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 819ad329..57e254aa 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -200,11 +200,6 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 	return -ENODEV;
 }
 
-static inline int jz4740_mmc_get_dma_dir(struct mmc_data *data)
-{
-	return (data->flags & MMC_DATA_READ) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-}
-
 static inline struct dma_chan *jz4740_mmc_get_dma_chan(struct jz4740_mmc_host *host,
 						       struct mmc_data *data)
 {
@@ -215,7 +210,7 @@ static void jz4740_mmc_dma_unmap(struct jz4740_mmc_host *host,
 				 struct mmc_data *data)
 {
 	struct dma_chan *chan = jz4740_mmc_get_dma_chan(host, data);
-	enum dma_data_direction dir = jz4740_mmc_get_dma_dir(data);
+	enum dma_data_direction dir = mmc_get_dma_dir(data);
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
 }
@@ -227,7 +222,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 				       struct dma_chan *chan)
 {
 	struct jz4740_mmc_host_next *next_data = &host->next_data;
-	enum dma_data_direction dir = jz4740_mmc_get_dma_dir(data);
+	enum dma_data_direction dir = mmc_get_dma_dir(data);
 	int sg_len;
 
 	if (!next && data->host_cookie &&
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index e77d79c8..476e53d3 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -888,10 +888,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	u32			clock_rate;
 	unsigned long		timeout;
 
-	if (data->flags & MMC_DATA_READ)
-		direction = DMA_FROM_DEVICE;
-	else
-		direction = DMA_TO_DEVICE;
+	direction = mmc_get_dma_dir(data);
 	mmc_spi_setup_data_message(host, multiple, direction);
 	t = &host->t;
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0c6420bb..d1ca2f48 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -516,17 +516,14 @@ static void mmci_dma_data_error(struct mmci_host *host)
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
 	struct dma_chan *chan;
-	enum dma_data_direction dir;
 
-	if (data->flags & MMC_DATA_READ) {
-		dir = DMA_FROM_DEVICE;
+	if (data->flags & MMC_DATA_READ)
 		chan = host->dma_rx_channel;
-	} else {
-		dir = DMA_TO_DEVICE;
+	else
 		chan = host->dma_tx_channel;
-	}
 
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
 }
 
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
@@ -589,17 +586,14 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	struct dma_chan *chan;
 	struct dma_device *device;
 	struct dma_async_tx_descriptor *desc;
-	enum dma_data_direction buffer_dirn;
 	int nr_sg;
 	unsigned long flags = DMA_CTRL_ACK;
 
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_DEV_TO_MEM;
-		buffer_dirn = DMA_FROM_DEVICE;
 		chan = host->dma_rx_channel;
 	} else {
 		conf.direction = DMA_MEM_TO_DEV;
-		buffer_dirn = DMA_TO_DEVICE;
 		chan = host->dma_tx_channel;
 	}
 
@@ -612,7 +606,8 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 		return -EINVAL;
 
 	device = chan->device;
-	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
+	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
+			   mmc_get_dma_dir(data));
 	if (nr_sg == 0)
 		return -EINVAL;
 
@@ -631,7 +626,8 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 	return 0;
 
  unmap_exit:
-	dma_unmap_sg(device->dev, data->sg, data->sg_len, buffer_dirn);
+	dma_unmap_sg(device->dev, data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index bbad3096..d4dc55ac 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -256,7 +256,7 @@ static void moxart_dma_complete(void *param)
 
 static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 {
-	u32 len, dir_data, dir_slave;
+	u32 len, dir_slave;
 	long dma_time;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
@@ -266,16 +266,14 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 	if (data->flags & MMC_DATA_WRITE) {
 		dma_chan = host->dma_chan_tx;
-		dir_data = DMA_TO_DEVICE;
 		dir_slave = DMA_MEM_TO_DEV;
 	} else {
 		dma_chan = host->dma_chan_rx;
-		dir_data = DMA_FROM_DEVICE;
 		dir_slave = DMA_DEV_TO_MEM;
 	}
 
 	len = dma_map_sg(dma_chan->device->dev, data->sg,
-			 data->sg_len, dir_data);
+			 data->sg_len, mmc_get_dma_dir(data));
 
 	if (len > 0) {
 		desc = dmaengine_prep_slave_sg(dma_chan, data->sg,
@@ -301,7 +299,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 	dma_unmap_sg(dma_chan->device->dev,
 		     data->sg, data->sg_len,
-		     dir_data);
+		     mmc_get_dma_dir(data));
 }
 
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b235d8da..c8b0b6b9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -462,11 +462,9 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
-		bool read = (data->flags & MMC_DATA_READ) != 0;
-
 		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
-					   read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+					    mmc_get_dma_dir(data));
 	}
 }
 
@@ -478,10 +476,8 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
 		return;
 
 	if (data->host_cookie & MSDC_PREPARE_FLAG) {
-		bool read = (data->flags & MMC_DATA_READ) != 0;
-
 		dma_unmap_sg(host->dev, data->sg, data->sg_len,
-			     read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			     mmc_get_dma_dir(data));
 		data->host_cookie &= ~MSDC_PREPARE_FLAG;
 	}
 }
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 42296e55..58d74b8d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -125,10 +125,10 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
-		int dma_dir = (data->flags & MMC_DATA_READ) ?
-			DMA_FROM_DEVICE : DMA_TO_DEVICE;
-		host->sg_frags = dma_map_sg(mmc_dev(host->mmc), data->sg,
-					    data->sg_len, dma_dir);
+
+		host->sg_frags = dma_map_sg(mmc_dev(host->mmc),
+					    data->sg, data->sg_len,
+					    mmc_get_dma_dir(data));
 		phys_addr = sg_dma_address(data->sg);
 		mvsd_write(MVSD_SYS_ADDR_LOW, (u32)phys_addr & 0xffff);
 		mvsd_write(MVSD_SYS_ADDR_HI,  (u32)phys_addr >> 16);
@@ -294,8 +294,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
-			     (data->flags & MMC_DATA_READ) ?
-				DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			     mmc_get_dma_dir(data));
 	}
 
 	if (err_status & MVSD_ERR_DATA_TIMEOUT)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a58bd653..bf64cf23 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -935,15 +935,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
 }
 
-static int
-omap_hsmmc_get_dma_dir(struct omap_hsmmc_host *host, struct mmc_data *data)
-{
-	if (data->flags & MMC_DATA_WRITE)
-		return DMA_TO_DEVICE;
-	else
-		return DMA_FROM_DEVICE;
-}
-
 static struct dma_chan *omap_hsmmc_get_dma_chan(struct omap_hsmmc_host *host,
 	struct mmc_data *data)
 {
@@ -1055,7 +1046,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 		dmaengine_terminate_all(chan);
 		dma_unmap_sg(chan->device->dev,
 			host->data->sg, host->data->sg_len,
-			omap_hsmmc_get_dma_dir(host, host->data));
+			mmc_get_dma_dir(host->data));
 
 		host->data->host_cookie = 0;
 	}
@@ -1350,7 +1341,7 @@ static void omap_hsmmc_dma_callback(void *param)
 	if (!data->host_cookie)
 		dma_unmap_sg(chan->device->dev,
 			     data->sg, data->sg_len,
-			     omap_hsmmc_get_dma_dir(host, data));
+			     mmc_get_dma_dir(data));
 
 	req_in_progress = host->req_in_progress;
 	host->dma_ch = -1;
@@ -1383,7 +1374,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 	/* Check if next job is already prepared */
 	if (next || data->host_cookie != host->next_data.cookie) {
 		dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
-				     omap_hsmmc_get_dma_dir(host, data));
+				     mmc_get_dma_dir(data));
 
 	} else {
 		dma_len = host->next_data.dma_len;
@@ -1569,7 +1560,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
 
 		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
-			     omap_hsmmc_get_dma_dir(host, data));
+			     mmc_get_dma_dir(data));
 		data->host_cookie = 0;
 	}
 }
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 7a173f8c..5c9037eb 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1104,7 +1104,7 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 		conf.direction = DMA_MEM_TO_DEV;
 
 	dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		   mmc_get_dma_dir(data));
 
 	dmaengine_slave_config(host->dma, &conf);
 	desc = dmaengine_prep_slave_sg(host->dma, data->sg, data->sg_len,
@@ -1121,7 +1121,7 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 
 unmap_exit:
 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		     mmc_get_dma_dir(data));
 	return -ENOMEM;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a33102fc..af8b60f3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -502,8 +502,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 		return data->sg_count;
 
 	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				data->flags & MMC_DATA_WRITE ?
-				DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			      mmc_get_dma_dir(data));
 
 	if (sg_count == 0)
 		return -ENOSPC;
@@ -2213,8 +2212,7 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 
 	if (data->host_cookie != COOKIE_UNMAPPED)
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     data->flags & MMC_DATA_WRITE ?
-			       DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			     mmc_get_dma_dir(data));
 
 	data->host_cookie = COOKIE_UNMAPPED;
 }
@@ -2330,8 +2328,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 		if (data && data->host_cookie == COOKIE_MAPPED) {
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     (data->flags & MMC_DATA_READ) ?
-				     DMA_FROM_DEVICE : DMA_TO_DEVICE);
+				     mmc_get_dma_dir(data));
 			data->host_cookie = COOKIE_UNMAPPED;
 		}
 	}
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6ffcd283..ea415b0d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -385,14 +385,6 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 	wmb();
 }
 
-static enum dma_data_direction sunxi_mmc_get_dma_dir(struct mmc_data *data)
-{
-	if (data->flags & MMC_DATA_WRITE)
-		return DMA_TO_DEVICE;
-	else
-		return DMA_FROM_DEVICE;
-}
-
 static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
 			     struct mmc_data *data)
 {
@@ -400,7 +392,7 @@ static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
 	struct scatterlist *sg;
 
 	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     sunxi_mmc_get_dma_dir(data));
+			     mmc_get_dma_dir(data));
 	if (dma_len == 0) {
 		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
 		return -ENOMEM;
@@ -551,7 +543,7 @@ static irqreturn_t sunxi_mmc_finalize_request(struct sunxi_mmc_host *host)
 		rval |= SDXC_FIFO_RESET;
 		mmc_writel(host, REG_GCTRL, rval);
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     sunxi_mmc_get_dma_dir(data));
+			     mmc_get_dma_dir(data));
 	}
 
 	mmc_writel(host, REG_RINTR, 0xffff);
@@ -1022,7 +1014,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		if (data)
 			dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
-				     sunxi_mmc_get_dma_dir(data));
+				     mmc_get_dma_dir(data));
 
 		dev_err(mmc_dev(mmc), "request already pending\n");
 		mrq->cmd->error = -EBUSY;
-- 
2.12.0


