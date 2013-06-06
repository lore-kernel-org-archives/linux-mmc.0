From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4] mmc: sh_mmcif: add support for Device Tree DMA bindings
Date: Thu,  6 Jun 2013 17:46:25 +0200
Message-ID: <1370533588-23642-2-git-send-email-g.liakhovetski@gmx.de>
References: <1370533588-23642-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57716 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3FFPqk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 11:46:40 -0400
In-Reply-To: <1370533588-23642-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

To use DMA in the Device Tree case the driver has to be modified
to use suitable API to obtain DMA channels.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 06caaae..a0937ae 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -386,25 +386,30 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 
 	host->dma_active = false;
 
-	if (!pdata)
-		return;
-
-	if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
-		return;
+	if (pdata) {
+		if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
+			return;
+	} else {
+		if (!host->pd->dev.of_node)
+			return;
+	}
 
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->chan_tx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_tx);
+	host->chan_tx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				pdata ? (void *)pdata->slave_id_tx : NULL,
+				&host->pd->dev, "tx");
 	dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
 		host->chan_tx);
 
 	if (!host->chan_tx)
 		return;
 
-	cfg.slave_id = pdata->slave_id_tx;
+	/* In the OF case the driver will get the slave ID from the DT */
+	if (pdata)
+		cfg.slave_id = pdata->slave_id_tx;
 	cfg.direction = DMA_MEM_TO_DEV;
 	cfg.dst_addr = res->start + MMCIF_CE_DATA;
 	cfg.src_addr = 0;
@@ -412,15 +417,17 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	if (ret < 0)
 		goto ecfgtx;
 
-	host->chan_rx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_rx);
+	host->chan_rx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				pdata ? (void *)pdata->slave_id_rx : NULL,
+				&host->pd->dev, "rx");
 	dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
 		host->chan_rx);
 
 	if (!host->chan_rx)
 		goto erqrx;
 
-	cfg.slave_id = pdata->slave_id_rx;
+	if (pdata)
+		cfg.slave_id = pdata->slave_id_rx;
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.dst_addr = 0;
 	cfg.src_addr = res->start + MMCIF_CE_DATA;
-- 
1.7.2.5

