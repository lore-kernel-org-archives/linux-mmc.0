From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] mmc: omap_hsmmc: don't print uninitialized variables
Date: Tue, 26 Jan 2016 16:26:31 +0100
Message-ID: <3411189.gO0215GrNM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:59543 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966058AbcAZP1C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 10:27:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

When DT based probing is used but the DMA request fails, the
driver will print uninitialized stack data from the rx_req
and tx_req variables, as indicated by this warning:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);

This removes the DMA request line number from the warning, which
is the easiest solution and won't hurt us any more as we are
planning to remove the legacy code path anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
A simpler patch as v1 with the same result, as suggested by Peter Ujfalusi.

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b6639ea0bf18..87f0d840a166 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2159,7 +2159,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 						 &rx_req, &pdev->dev, "rx");
 
 	if (!host->rx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
+		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
 		ret = -ENXIO;
 		goto err_irq;
 	}
@@ -2169,7 +2169,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 						 &tx_req, &pdev->dev, "tx");
 
 	if (!host->tx_chan) {
-		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
+		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
 		ret = -ENXIO;
 		goto err_irq;
 	}

