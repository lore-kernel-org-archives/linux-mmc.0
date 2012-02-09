From: ludovic.desroches@atmel.com
Subject: [PATCH 1/2] mmc: atmel-mci: don't use dma features when dma is present but there is no chan available
Date: Thu,  9 Feb 2012 16:33:53 +0100
Message-ID: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:12258 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2BINew (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 08:34:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Some callbacks are set too early ie we can have dma capabilities but we can't
get a dma channel. So wait to get the dma channel before setting callbacks
and change logs consequently.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index a7ee502..e71a158 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1941,12 +1941,12 @@ static bool atmci_filter(struct dma_chan *chan, void *slave)
 	}
 }
 
-static void atmci_configure_dma(struct atmel_mci *host)
+static bool atmci_configure_dma(struct atmel_mci *host)
 {
 	struct mci_platform_data	*pdata;
 
 	if (host == NULL)
-		return;
+		return false;
 
 	pdata = host->pdev->dev.platform_data;
 
@@ -1963,12 +1963,15 @@ static void atmci_configure_dma(struct atmel_mci *host)
 		host->dma.chan =
 			dma_request_channel(mask, atmci_filter, pdata->dma_slave);
 	}
-	if (!host->dma.chan)
-		dev_notice(&host->pdev->dev, "DMA not available, using PIO\n");
-	else
+	if (!host->dma.chan) {
+		dev_warn(&host->pdev->dev, "no DMA channel available\n");
+		return false;
+	} else {
 		dev_info(&host->pdev->dev,
 					"Using %s for DMA transfers\n",
 					dma_chan_name(host->dma.chan));
+		return true;
+	}
 }
 
 static inline unsigned int atmci_get_version(struct atmel_mci *host)
@@ -2078,8 +2081,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
-	if (host->caps.has_dma) {
-		dev_info(&pdev->dev, "using DMA\n");
+	if (host->caps.has_dma && atmci_configure_dma(host)) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
 		host->stop_transfer = &atmci_stop_transfer_dma;
@@ -2089,15 +2091,12 @@ static int __init atmci_probe(struct platform_device *pdev)
 		host->submit_data = &atmci_submit_data_pdc;
 		host->stop_transfer = &atmci_stop_transfer_pdc;
 	} else {
-		dev_info(&pdev->dev, "no DMA, no PDC\n");
+		dev_info(&pdev->dev, "using PIO\n");
 		host->prepare_data = &atmci_prepare_data;
 		host->submit_data = &atmci_submit_data;
 		host->stop_transfer = &atmci_stop_transfer;
 	}
 
-	if (host->caps.has_dma)
-		atmci_configure_dma(host);
-
 	platform_set_drvdata(pdev, host);
 
 	/* We need at least one slot to succeed */
-- 
1.7.5.4

