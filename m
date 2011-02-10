From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/11] sh_mmcif: map DMA buffers on the DMA engine device
Date: Thu, 10 Feb 2011 16:09:29 +0100
Message-ID: <1297350569-1806-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>

As established for the MMCI, it is proper to map the DMA buffers
on the DMA engine which is the one actually performing the DMA.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 12884c2..8e4aba9 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -194,10 +194,12 @@ static void mmcif_dma_complete(void *arg)
 		return;
 
 	if (host->data->flags & MMC_DATA_READ)
-		dma_unmap_sg(&host->pd->dev, host->data->sg, host->dma_sglen,
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     host->data->sg, host->dma_sglen,
 			     DMA_FROM_DEVICE);
 	else
-		dma_unmap_sg(&host->pd->dev, host->data->sg, host->dma_sglen,
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     host->data->sg, host->dma_sglen,
 			     DMA_TO_DEVICE);
 
 	complete(&host->dma_complete);
@@ -211,7 +213,8 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 	dma_cookie_t cookie = -EINVAL;
 	int ret;
 
-	ret = dma_map_sg(&host->pd->dev, sg, host->data->sg_len, DMA_FROM_DEVICE);
+	ret = dma_map_sg(chan->device->dev, sg, host->data->sg_len,
+			 DMA_FROM_DEVICE);
 	if (ret > 0) {
 		host->dma_sglen = ret;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
@@ -263,7 +266,8 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 	dma_cookie_t cookie = -EINVAL;
 	int ret;
 
-	ret = dma_map_sg(&host->pd->dev, sg, host->data->sg_len, DMA_TO_DEVICE);
+	ret = dma_map_sg(chan->device->dev, sg, host->data->sg_len,
+			 DMA_TO_DEVICE);
 	if (ret > 0) {
 		host->dma_sglen = ret;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
-- 
1.7.4

