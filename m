From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v4 1/4] mmc: atmel-mci: remove useless DMA stuff for non-dt devices
Date: Mon, 1 Dec 2014 15:35:06 +0100
Message-ID: <1417444509-15501-2-git-send-email-ludovic.desroches@atmel.com>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52029 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbaLAOfe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 09:35:34 -0500
In-Reply-To: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

All devices with a DMA controller are DT compliant and legacy support
has been removed. For those reasons, some DMA stuff is useless.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index de2287c..f187e75 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2274,17 +2274,9 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static bool atmci_configure_dma(struct atmel_mci *host)
 {
-	struct mci_platform_data	*pdata;
-	dma_cap_mask_t mask;
-
 	if (host == NULL)
 		return false;
 
-	pdata = host->pdev->dev.platform_data;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
 	if (!host->dma.chan) {
 		dev_warn(&host->pdev->dev, "no DMA channel available\n");
-- 
2.0.3

