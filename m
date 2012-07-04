From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4] mmc: sh_mmcif: switch to the new DMA channel allocation and configuration
Date: Wed,  4 Jul 2012 18:17:43 +0200
Message-ID: <1341418663-24432-5-git-send-email-g.liakhovetski@gmx.de>
References: <1341418663-24432-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341418663-24432-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Using the "private" field from struct dma_chan is deprecated. The sh
dmaengine driver now also supports the preferred DMA channel allocation
and configuration method, using a standard filter function and a channel
configuration operation. This patch updates sh_mmcif to use this new
method.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   90 ++++++++++++++++++++++++------------------
 1 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9e3b9b1..0f07d28 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -211,8 +211,6 @@ struct sh_mmcif_host {
 	struct mmc_host *mmc;
 	struct mmc_request *mrq;
 	struct platform_device *pd;
-	struct sh_dmae_slave dma_slave_tx;
-	struct sh_dmae_slave dma_slave_rx;
 	struct clk *hclk;
 	unsigned int clk;
 	int bus_width;
@@ -371,52 +369,66 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 		desc, cookie);
 }
 
-static bool sh_mmcif_filter(struct dma_chan *chan, void *arg)
-{
-	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
-	chan->private = arg;
-	return true;
-}
-
 static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 				 struct sh_mmcif_plat_data *pdata)
 {
-	struct sh_dmae_slave *tx, *rx;
+	struct resource *res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
+	struct dma_slave_config cfg;
+	dma_cap_mask_t mask;
+	int ret;
+
 	host->dma_active = false;
 
+	if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
+		return;
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
-	tx = &host->dma_slave_tx;
-	tx->shdma_slave.slave_id = pdata->slave_id_tx;
-	rx = &host->dma_slave_rx;
-	rx->shdma_slave.slave_id = pdata->slave_id_rx;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	host->chan_tx = dma_request_channel(mask, shdma_chan_filter,
+					    (void *)pdata->slave_id_tx);
+	dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
+		host->chan_tx);
 
-	if (tx->shdma_slave.slave_id > 0 && rx->shdma_slave.slave_id > 0) {
-		dma_cap_mask_t mask;
+	if (!host->chan_tx)
+		return;
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
+	cfg.slave_id = pdata->slave_id_tx;
+	cfg.direction = DMA_MEM_TO_DEV;
+	cfg.dst_addr = res->start + MMCIF_CE_DATA;
+	cfg.src_addr = 0;
+	ret = dmaengine_slave_config(host->chan_tx, &cfg);
+	if (ret < 0)
+		goto ecfgtx;
 
-		host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
-						    &tx->shdma_slave);
-		dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
-			host->chan_tx);
+	host->chan_rx = dma_request_channel(mask, shdma_chan_filter,
+					    (void *)pdata->slave_id_rx);
+	dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
+		host->chan_rx);
 
-		if (!host->chan_tx)
-			return;
+	if (!host->chan_rx)
+		goto erqrx;
 
-		host->chan_rx = dma_request_channel(mask, sh_mmcif_filter,
-						    &rx->shdma_slave);
-		dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
-			host->chan_rx);
+	cfg.slave_id = pdata->slave_id_rx;
+	cfg.direction = DMA_DEV_TO_MEM;
+	cfg.dst_addr = 0;
+	cfg.src_addr = res->start + MMCIF_CE_DATA;
+	ret = dmaengine_slave_config(host->chan_rx, &cfg);
+	if (ret < 0)
+		goto ecfgrx;
 
-		if (!host->chan_rx) {
-			dma_release_channel(host->chan_tx);
-			host->chan_tx = NULL;
-			return;
-		}
+	init_completion(&host->dma_complete);
 
-		init_completion(&host->dma_complete);
-	}
+	return;
+
+ecfgrx:
+	dma_release_channel(host->chan_rx);
+	host->chan_rx = NULL;
+erqrx:
+ecfgtx:
+	dma_release_channel(host->chan_tx);
+	host->chan_tx = NULL;
 }
 
 static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
-- 
1.7.2.5
