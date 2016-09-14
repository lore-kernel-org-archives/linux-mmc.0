From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] mmc: omap_hsmmc: Initialize dma_slave_config to avoid random data
Date: Wed, 14 Sep 2016 14:22:07 +0300
Message-ID: <20160914112207.4648-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42344 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761892AbcINLWX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 07:22:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de
Cc: tony@atomide.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

It is wrong to use uninitialized dma_slave_config and configure only
certain fields as the DMAengine driver might look at non initialized
(random data) fields and tries to interpret it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- do the field initialization in one step

would it be possible to send this patch for 4.8? I have omap-dma DMAengine
driver changes pending, but they break the MMC/SD because of the uninitialized
fields in dma_slave_config.

Thanks,
Peter

 drivers/mmc/host/omap_hsmmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 24ebc9a8de89..5f2f24a7360d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1409,11 +1409,18 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	struct dma_slave_config cfg;
 	struct dma_async_tx_descriptor *tx;
 	int ret = 0, i;
 	struct mmc_data *data = req->data;
 	struct dma_chan *chan;
+	struct dma_slave_config cfg = {
+		.src_addr = host->mapbase + OMAP_HSMMC_DATA,
+		.dst_addr = host->mapbase + OMAP_HSMMC_DATA,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.src_maxburst = data->blksz / 4,
+		.dst_maxburst = data->blksz / 4,
+	};

 	/* Sanity check: all the SG entries must be aligned by block size. */
 	for (i = 0; i < data->sg_len; i++) {
@@ -1433,13 +1440,6 @@ static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,

 	chan = omap_hsmmc_get_dma_chan(host, data);

-	cfg.src_addr = host->mapbase + OMAP_HSMMC_DATA;
-	cfg.dst_addr = host->mapbase + OMAP_HSMMC_DATA;
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.src_maxburst = data->blksz / 4;
-	cfg.dst_maxburst = data->blksz / 4;
-
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret)
 		return ret;
--
2.10.0

