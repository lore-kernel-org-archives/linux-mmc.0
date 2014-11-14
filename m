From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 1/2] mmc: atmel-mci: remove compat for non DT board when requesting dma chan
Date: Fri, 14 Nov 2014 15:33:39 +0100
Message-ID: <1415975620-30140-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:55038 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934535AbaKNOdo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Nov 2014 09:33:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: =chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

All boards with a dma controller have DT support so using
dma_request_slave_channel_compat is no more needed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index a7b59ba..de2287c 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2272,23 +2272,6 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static bool atmci_filter(struct dma_chan *chan, void *pdata)
-{
-	struct mci_platform_data *sl_pdata = pdata;
-	struct mci_dma_data *sl;
-
-	if (!sl_pdata)
-		return false;
-
-	sl = sl_pdata->dma_slave;
-	if (sl && find_slave_dev(sl) == chan->device->dev) {
-		chan->private = slave_data_ptr(sl);
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static bool atmci_configure_dma(struct atmel_mci *host)
 {
 	struct mci_platform_data	*pdata;
@@ -2302,8 +2285,7 @@ static bool atmci_configure_dma(struct atmel_mci *host)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->dma.chan = dma_request_slave_channel_compat(mask, atmci_filter, pdata,
-							  &host->pdev->dev, "rxtx");
+	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
 	if (!host->dma.chan) {
 		dev_warn(&host->pdev->dev, "no DMA channel available\n");
 		return false;
-- 
2.0.3

