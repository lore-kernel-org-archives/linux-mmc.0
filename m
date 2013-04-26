From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] mmc: sdhi/tmio: switch to using dmaengine_slave_config()
Date: Fri, 26 Apr 2013 17:47:18 +0200
Message-ID: <1366991239-22602-3-git-send-email-g.liakhovetski@gmx.de>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This removes the deprecated use of the .private member of struct dma_chan
and switches the sdhi / tmio mmc driver to using the
dmaengine_slave_config() channel configuration method.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   33 ++++++++++++++++-----------------
 drivers/mmc/host/tmio_mmc_dma.c   |   25 +++++++++++++++++++++++++
 include/linux/mfd/tmio.h          |    2 ++
 3 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index e0088d7..7f45f62 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -20,7 +20,6 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/dmaengine.h>
 #include <linux/slab.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -47,8 +46,6 @@ static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
 struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
-	struct sh_dmae_slave param_tx;
-	struct sh_dmae_slave param_rx;
 	struct tmio_mmc_dma dma_priv;
 };
 
@@ -125,13 +122,6 @@ static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
 	mmc_detect_change(dev_get_drvdata(&pdev->dev), msecs_to_jiffies(100));
 }
 
-static bool sh_mobile_sdhi_filter(struct dma_chan *chan, void *arg)
-{
-	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
-	chan->private = arg;
-	return true;
-}
-
 static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
@@ -194,13 +184,22 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
-			priv->param_tx.shdma_slave.slave_id = p->dma_slave_tx;
-			priv->param_rx.shdma_slave.slave_id = p->dma_slave_rx;
-			priv->dma_priv.chan_priv_tx = &priv->param_tx.shdma_slave;
-			priv->dma_priv.chan_priv_rx = &priv->param_rx.shdma_slave;
-			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
-			priv->dma_priv.filter = sh_mobile_sdhi_filter;
-			mmc_data->dma = &priv->dma_priv;
+			struct tmio_mmc_dma *dma_priv = &priv->dma_priv;
+
+			/*
+			 * Yes, we have to provide slave IDs twice to TMIO:
+			 * once as a filter parameter and once for channel
+			 * configuration as an explicit slave ID
+			 */
+			dma_priv->chan_priv_tx = (void *)p->dma_slave_tx;
+			dma_priv->chan_priv_rx = (void *)p->dma_slave_rx;
+			dma_priv->slave_id_tx = p->dma_slave_tx;
+			dma_priv->slave_id_rx = p->dma_slave_rx;
+
+			dma_priv->alignment_shift = 1; /* 2-byte alignment */
+			dma_priv->filter = shdma_chan_filter;
+
+			mmc_data->dma = dma_priv;
 		}
 	}
 
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index dc4b10b..5fcf14f 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -268,7 +268,14 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		return;
 
 	if (!host->chan_tx && !host->chan_rx) {
+		struct resource *res = platform_get_resource(host->pdev,
+							     IORESOURCE_MEM, 0);
+		struct dma_slave_config cfg = {};
 		dma_cap_mask_t mask;
+		int ret;
+
+		if (!res)
+			return;
 
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -281,6 +288,14 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_tx)
 			return;
 
+		cfg.slave_id = pdata->dma->slave_id_tx;
+		cfg.direction = DMA_MEM_TO_DEV;
+		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
+		cfg.src_addr = 0;
+		ret = dmaengine_slave_config(host->chan_tx, &cfg);
+		if (ret < 0)
+			goto ecfgtx;
+
 		host->chan_rx = dma_request_channel(mask, pdata->dma->filter,
 						    pdata->dma->chan_priv_rx);
 		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
@@ -289,6 +304,14 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_rx)
 			goto ereqrx;
 
+		cfg.slave_id = pdata->dma->slave_id_rx;
+		cfg.direction = DMA_DEV_TO_MEM;
+		cfg.src_addr = cfg.dst_addr;
+		cfg.dst_addr = 0;
+		ret = dmaengine_slave_config(host->chan_rx, &cfg);
+		if (ret < 0)
+			goto ecfgrx;
+
 		host->bounce_buf = (u8 *)__get_free_page(GFP_KERNEL | GFP_DMA);
 		if (!host->bounce_buf)
 			goto ebouncebuf;
@@ -302,9 +325,11 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 	return;
 
 ebouncebuf:
+ecfgrx:
 	dma_release_channel(host->chan_rx);
 	host->chan_rx = NULL;
 ereqrx:
+ecfgtx:
 	dma_release_channel(host->chan_tx);
 	host->chan_tx = NULL;
 }
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 0990d8a..ce35113 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -86,6 +86,8 @@ struct dma_chan;
 struct tmio_mmc_dma {
 	void *chan_priv_tx;
 	void *chan_priv_rx;
+	int slave_id_tx;
+	int slave_id_rx;
 	int alignment_shift;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 };
-- 
1.7.2.5

