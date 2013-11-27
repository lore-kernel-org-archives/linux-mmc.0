From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/2] mmc: sh_mmcif: Factorize DMA channel request and configuration code
Date: Wed, 27 Nov 2013 01:34:39 +0100
Message-ID: <1385512480-10432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The channel request and configuration code is duplicated for the rx and
tx channels. Create a function that requests a single channel and call
it twice instead.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 100 ++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d032b08..bebf2fe 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -381,73 +381,75 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 		desc, cookie);
 }
 
-static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
-				 struct sh_mmcif_plat_data *pdata)
+static struct dma_chan *
+sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
+			 struct sh_mmcif_plat_data *pdata,
+			 enum dma_transfer_direction direction)
 {
-	struct resource *res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
 	struct dma_slave_config cfg;
+	struct dma_chan *chan;
+	unsigned int slave_id;
+	struct resource *res;
 	dma_cap_mask_t mask;
 	int ret;
 
-	host->dma_active = false;
-
-	if (pdata) {
-		if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
-			return;
-	} else if (!host->pd->dev.of_node) {
-		return;
-	}
-
-	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->chan_tx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				pdata ? (void *)pdata->slave_id_tx : NULL,
-				&host->pd->dev, "tx");
-	dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
-		host->chan_tx);
+	if (pdata)
+		slave_id = direction == DMA_MEM_TO_DEV
+			 ? pdata->slave_id_tx : pdata->slave_id_rx;
+	else
+		slave_id = 0;
 
-	if (!host->chan_tx)
-		return;
+	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				(void *)slave_id, &host->pd->dev,
+				direction == DMA_MEM_TO_DEV ? "tx" : "rx");
+
+	dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
+		direction == DMA_MEM_TO_DEV ? "TX" : "RX", chan);
+
+	if (!chan)
+		return NULL;
+
+	res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
 
 	/* In the OF case the driver will get the slave ID from the DT */
-	if (pdata)
-		cfg.slave_id = pdata->slave_id_tx;
-	cfg.direction = DMA_MEM_TO_DEV;
+	cfg.slave_id = slave_id;
+	cfg.direction = direction;
 	cfg.dst_addr = res->start + MMCIF_CE_DATA;
 	cfg.src_addr = 0;
-	ret = dmaengine_slave_config(host->chan_tx, &cfg);
-	if (ret < 0)
-		goto ecfgtx;
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret < 0) {
+		dma_release_channel(chan);
+		return NULL;
+	}
 
-	host->chan_rx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				pdata ? (void *)pdata->slave_id_rx : NULL,
-				&host->pd->dev, "rx");
-	dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
-		host->chan_rx);
+	return chan;
+}
 
-	if (!host->chan_rx)
-		goto erqrx;
+static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
+				 struct sh_mmcif_plat_data *pdata)
+{
+	host->dma_active = false;
 
-	if (pdata)
-		cfg.slave_id = pdata->slave_id_rx;
-	cfg.direction = DMA_DEV_TO_MEM;
-	cfg.dst_addr = 0;
-	cfg.src_addr = res->start + MMCIF_CE_DATA;
-	ret = dmaengine_slave_config(host->chan_rx, &cfg);
-	if (ret < 0)
-		goto ecfgrx;
+	if (pdata) {
+		if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
+			return;
+	} else if (!host->pd->dev.of_node) {
+		return;
+	}
 
-	return;
+	/* We can only either use DMA for both Tx and Rx or not use it at all */
+	host->chan_tx = sh_mmcif_request_dma_one(host, pdata, DMA_MEM_TO_DEV);
+	if (!host->chan_tx)
+		return;
 
-ecfgrx:
-	dma_release_channel(host->chan_rx);
-	host->chan_rx = NULL;
-erqrx:
-ecfgtx:
-	dma_release_channel(host->chan_tx);
-	host->chan_tx = NULL;
+	host->chan_rx = sh_mmcif_request_dma_one(host, pdata, DMA_DEV_TO_MEM);
+	if (!host->chan_rx) {
+		dma_release_channel(host->chan_tx);
+		host->chan_tx = NULL;
+	}
 }
 
 static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
-- 
1.8.3.2

