From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/11] atmel-mci: conform to DMA-API
Date: Thu, 10 Feb 2011 16:08:16 +0100
Message-ID: <1297350496-1263-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756547Ab1BJPtQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>

Fixes the following:
- It is perfectly legal for the dma_map_sg() to return fewer
  entries than were passed in.
- Supply the returned numer of (possibly coalesced) entries to
  the device_pre_slave_sg() function.
- Use the proper original sg_len when unmapping the sglist
  in the error path.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/atmel-mci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 045bdbb..df5a135 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -687,10 +687,9 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	sglen = dma_map_sg(chan->device->dev, data->sg,
 			   data->sg_len, direction);
-	if (sglen != data->sg_len)
-		goto unmap_exit;
+
 	desc = chan->device->device_prep_slave_sg(chan,
-			data->sg, data->sg_len, direction,
+			data->sg, sglen, direction,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		goto unmap_exit;
@@ -701,7 +700,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 	return 0;
 unmap_exit:
-	dma_unmap_sg(chan->device->dev, data->sg, sglen, direction);
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, direction);
 	return -ENOMEM;
 }
 
-- 
1.7.4

