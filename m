From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/11] tmio_mmc: map DMA buffers on the DMA engine device
Date: Thu, 10 Feb 2011 16:10:37 +0100
Message-ID: <1297350637-2877-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Linus Walleij <linus.walleij@linaro.org>

As established for the MMCI, it is proper to map the DMA buffers
on the DMA engine which is the one actually performing the DMA.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e3c6ef2..c82d8e2 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -825,7 +825,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 		sg = host->sg_ptr;
 	}
 
-	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_FROM_DEVICE);
+	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0) {
 		host->dma_sglen = ret;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
@@ -906,7 +906,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 		sg = host->sg_ptr;
 	}
 
-	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_TO_DEVICE);
+	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0) {
 		host->dma_sglen = ret;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
@@ -978,10 +978,12 @@ static void tmio_tasklet_fn(unsigned long arg)
 		goto out;
 
 	if (host->data->flags & MMC_DATA_READ)
-		dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->dma_sglen,
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     host->sg_ptr, host->dma_sglen,
 			     DMA_FROM_DEVICE);
 	else
-		dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->dma_sglen,
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     host->sg_ptr, host->dma_sglen,
 			     DMA_TO_DEVICE);
 
 	tmio_mmc_do_data_irq(host);
-- 
1.7.4

