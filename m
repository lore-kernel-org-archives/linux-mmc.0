From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: Initialize dma_slave_config to avoid random data
Date: Wed, 14 Sep 2016 13:10:48 +0300
Message-ID: <20160914101048.1061-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39269 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbcINKKz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 06:10:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: tony@atomide.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

It is wrong to not initialize the dma_slave_config struct as the DMAengine
driver might look at non initialized (random data) fields and tries to
interpret it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

would it be possible to send this patch for 4.8? I have omap-dma DMAengine
driver changes pending, but they break the MMC/SD because of the uninitialized
fields in dma_slave_config.

Thanks,
Peter

 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 24ebc9a8de89..0a5640156159 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1409,7 +1409,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	struct dma_slave_config cfg;
+	struct dma_slave_config cfg = {};
 	struct dma_async_tx_descriptor *tx;
 	int ret = 0, i;
 	struct mmc_data *data = req->data;
--
2.10.0

