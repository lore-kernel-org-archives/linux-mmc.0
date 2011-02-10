From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/11] tmio_mmc: drop dma_sglen state variable
Date: Thu, 10 Feb 2011 16:10:56 +0100
Message-ID: <1297350656-3392-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Linus Walleij <linus.walleij@linaro.org>

This variable doesn't seem to be used for anything after the
other patches so just drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 5da2e17..708b3a1 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -152,7 +152,6 @@ struct tmio_mmc_host {
 	struct tasklet_struct	dma_complete;
 	struct tasklet_struct	dma_issue;
 #ifdef CONFIG_TMIO_MMC_DMA
-	unsigned int            dma_sglen;
 	u8			bounce_buf[PAGE_CACHE_SIZE] __attribute__((aligned(MAX_ALIGN)));
 	struct scatterlist	bounce_sg;
 #endif
@@ -826,11 +825,9 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	}
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
-	if (ret > 0) {
-		host->dma_sglen = ret;
+	if (ret > 0)
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
 			DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	}
 
 	if (desc) {
 		desc->callback = tmio_dma_complete;
@@ -907,11 +904,9 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	}
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
-	if (ret > 0) {
-		host->dma_sglen = ret;
+	if (ret > 0)
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
 			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	}
 
 	if (desc) {
 		desc->callback = tmio_dma_complete;
-- 
1.7.4

