From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/3] mmc: omap_hsmmc: convert to dma_request_slave_channel_compat
Date: Fri, 10 May 2013 17:42:34 +0530
Message-ID: <1368187955-13069-3-git-send-email-balajitk@ti.com>
References: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Matt Porter <mporter@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mporter@ti.com>

Convert dmaengine channel requests to use
dma_request_slave_channel_compat(). This supports platforms booting
with or without DT populated.

Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 29a63d2..dc89aea 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1930,14 +1930,20 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
+	host->rx_chan =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &rx_req, &pdev->dev, "rx");
+
 	if (!host->rx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
 		ret = -ENXIO;
 		goto err_irq;
 	}
 
-	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
+	host->tx_chan =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &tx_req, &pdev->dev, "tx");
+
 	if (!host->tx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
 		ret = -ENXIO;
-- 
1.7.5.4

