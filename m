From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/11] sh_mmcif: unmap with the proper sglen
Date: Thu, 10 Feb 2011 16:09:40 +0100
Message-ID: <1297350580-2068-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756530Ab1BJPtO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>

According to the DMA-API you shall unmap the sglists with the same
sglist length as passed into the mapping function, not the
returned value from the mapping function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8e4aba9..61ad19e 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -195,11 +195,11 @@ static void mmcif_dma_complete(void *arg)
 
 	if (host->data->flags & MMC_DATA_READ)
 		dma_unmap_sg(host->chan_rx->device->dev,
-			     host->data->sg, host->dma_sglen,
+			     host->data->sg, host->data->sg_len,
 			     DMA_FROM_DEVICE);
 	else
 		dma_unmap_sg(host->chan_tx->device->dev,
-			     host->data->sg, host->dma_sglen,
+			     host->data->sg, host->data->sg_len,
 			     DMA_TO_DEVICE);
 
 	complete(&host->dma_complete);
-- 
1.7.4

