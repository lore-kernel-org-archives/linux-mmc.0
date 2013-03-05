From: Matt Porter <mporter@ti.com>
Subject: [PATCH v2 1/3] mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
Date: Tue,  5 Mar 2013 16:13:22 -0500
Message-ID: <1362518004-7083-2-git-send-email-mporter@ti.com>
References: <1362518004-7083-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362518004-7083-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

Convert dmaengine channel requests to use
dma_request_slave_channel_compat(). This supports platforms booting
with or without DT populated.

Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bc58078..e79b12d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1915,14 +1915,20 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
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
1.7.9.5
