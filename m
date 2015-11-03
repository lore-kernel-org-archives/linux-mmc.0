From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: No need to check DMA channel validity at module remove
Date: Tue, 3 Nov 2015 13:37:31 +0200
Message-ID: <1446550651-7977-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, tony@atomide.com, kishon@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The driver will not probe without valid DMA channels so no need to check
if they are valid when the module is removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/omap_hsmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f70e52b05648..712c74fd0401 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2262,10 +2262,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
 
-	if (host->tx_chan)
-		dma_release_channel(host->tx_chan);
-	if (host->rx_chan)
-		dma_release_channel(host->rx_chan);
+	dma_release_channel(host->tx_chan);
+	dma_release_channel(host->rx_chan);
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-- 
2.6.2
