From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/11] tmio_mmc: unmap with the proper sglen
Date: Thu, 10 Feb 2011 16:10:47 +0100
Message-ID: <1297350647-3135-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756413Ab1BJPtM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Linus Walleij <linus.walleij@linaro.org>

According to the DMA-API you shall unmap the sglists with the same
sglist length as passed into the mapping function, not the
returned value from the mapping function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index c82d8e2..5da2e17 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -979,11 +979,11 @@ static void tmio_tasklet_fn(unsigned long arg)
 
 	if (host->data->flags & MMC_DATA_READ)
 		dma_unmap_sg(host->chan_rx->device->dev,
-			     host->sg_ptr, host->dma_sglen,
+			     host->sg_ptr, host->sg_len,
 			     DMA_FROM_DEVICE);
 	else
 		dma_unmap_sg(host->chan_tx->device->dev,
-			     host->sg_ptr, host->dma_sglen,
+			     host->sg_ptr, host->sg_len,
 			     DMA_TO_DEVICE);
 
 	tmio_mmc_do_data_irq(host);
-- 
1.7.4

