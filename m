From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/11] atmel-mci: map DMA sglist on the DMA engine
Date: Thu, 10 Feb 2011 16:08:06 +0100
Message-ID: <1297350486-1004-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756547Ab1BJPtR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>

As established for the MMCI, it is proper to map the DMA buffers
on the DMA engine which is the one actually performing the DMA.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/atmel-mci.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index ad2a7a0..045bdbb 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -578,7 +578,8 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 	struct mmc_data			*data = host->data;
 
 	if (data)
-		dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
+		dma_unmap_sg(host->dma.chan->device->dev,
+			     data->sg, data->sg_len,
 			     ((data->flags & MMC_DATA_WRITE)
 			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
 }
@@ -684,7 +685,8 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	else
 		direction = DMA_TO_DEVICE;
 
-	sglen = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len, direction);
+	sglen = dma_map_sg(chan->device->dev, data->sg,
+			   data->sg_len, direction);
 	if (sglen != data->sg_len)
 		goto unmap_exit;
 	desc = chan->device->device_prep_slave_sg(chan,
@@ -699,7 +701,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	return 0;
 unmap_exit:
-	dma_unmap_sg(&host->pdev->dev, data->sg, sglen, direction);
+	dma_unmap_sg(chan->device->dev, data->sg, sglen, direction);
 	return -ENOMEM;
 }
 
-- 
1.7.4

