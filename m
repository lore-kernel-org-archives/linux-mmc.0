From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] mmc: omap_hsmmc: Fix the warning
Date: Tue, 24 Jul 2012 14:17:20 +0530
Message-ID: <1343119640-24516-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50208 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab2GXIrl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Jul 2012 04:47:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Kevin Hilman <khilman@ti.com>

The commit 9c17d08 [mmc: omap_hsmmc: ensure probe returns error upon
resource failure] introduced the below warning.

  CC      drivers/of/of_net.o
drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
drivers/mmc/host/omap_hsmmc.c:1936: warning: statement with no effect

Fix the same by assigning the error value to ret.

Cc: Kevin Hilman <khilman@ti.com>
Reported-by: Archit Taneja <archit@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index be8631d..3a09f93 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1933,7 +1933,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
 	if (!host->tx_chan) {
 		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
-		ret -ENXIO;
+		ret = -ENXIO;
 		goto err_irq;
 	}
 
-- 
1.7.5.4

