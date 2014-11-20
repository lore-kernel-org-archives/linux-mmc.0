From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 3/3] mmc: atmel-mci: use probe deferring if dma controller is not ready yet
Date: Thu, 20 Nov 2014 11:07:55 +0100
Message-ID: <1416478075-17059-3-git-send-email-ludovic.desroches@atmel.com>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:45093 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbaKTKIn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 05:08:43 -0500
In-Reply-To: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Return probe defer if requesting a dma channel without a dma controller
probed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9b85c4e..29bfd5e 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2265,29 +2265,29 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static bool atmci_configure_dma(struct atmel_mci *host)
+static int atmci_configure_dma(struct atmel_mci *host)
 {
-	if (host == NULL)
-		return false;
+	int ret = 0;
 
-	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
-	if (!host->dma.chan) {
-		dev_warn(&host->pdev->dev, "no DMA channel available\n");
-		return false;
-	} else {
-		dev_info(&host->pdev->dev,
-					"using %s for DMA transfers\n",
-					dma_chan_name(host->dma.chan));
-
-		host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
-		host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.src_maxburst = 1;
-		host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
-		host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.dst_maxburst = 1;
-		host->dma_conf.device_fc = false;
-		return true;
+	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
+	if (IS_ERR(host->dma.chan)) {
+		ret = PTR_ERR(host->dma.chan);
+		host->dma.chan = NULL;
+		return ret;
 	}
+
+	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
+		 dma_chan_name(host->dma.chan));
+
+	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
+	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.src_maxburst = 1;
+	host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
+	host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.dst_maxburst = 1;
+	host->dma_conf.device_fc = false;
+
+	return ret;
 }
 
 /*
@@ -2403,7 +2403,10 @@ static int atmci_probe(struct platform_device *pdev)
 
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
-	if (atmci_configure_dma(host)) {
+	ret = atmci_configure_dma(host);
+	if (ret == -EPROBE_DEFER)
+		goto err_dma_probe_defer;
+	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
 		host->stop_transfer = &atmci_stop_transfer_dma;
@@ -2476,6 +2479,7 @@ err_init_slot:
 	del_timer_sync(&host->timer);
 	if (host->dma.chan)
 		dma_release_channel(host->dma.chan);
+err_dma_probe_defer:
 	free_irq(irq, host);
 	return ret;
 }
-- 
2.0.3

