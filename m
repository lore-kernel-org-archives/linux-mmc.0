From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mmc: omap: Initialize dma_slave_config to avoid random data in it's fields
Date: Wed, 14 Sep 2016 13:10:35 +0300
Message-ID: <20160914101035.972-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44238 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760751AbcINKK4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Sep 2016 06:10:56 -0400
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

 drivers/mmc/host/omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index f23d65eb070d..b49b3fa740a5 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1016,7 +1016,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)

 		/* Only reconfigure if we have a different burst size */
 		if (*bp != burst) {
-			struct dma_slave_config cfg;
+			struct dma_slave_config cfg = {};

 			cfg.src_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
 			cfg.dst_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
--
2.10.0

