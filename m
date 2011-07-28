From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 8/9] mmc: atmel-mci: correct sg buffer size evaluation
Date: Thu, 28 Jul 2011 16:29:57 +0200
Message-ID: <1311863398-31579-9-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:27064 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1G1NYJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:09 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Assuming that a sg buffer size is a page size is false so use sg_dma_len.
A 4096 bytes can be required with two 2048-bytes sg buffer.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index c415322..963e320 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -608,7 +608,7 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
 	}
 
 	atmci_writel(host, pointer_reg, sg_dma_address(host->sg));
-	if (host->data_size <= PAGE_SIZE) {
+	if (host->data_size <= sg_dma_len(host->sg)) {
 		if (host->data_size & 0x3) {
 			/* If size is different from modulo 4, transfer bytes */
 			atmci_writel(host, counter_reg, host->data_size);
@@ -620,8 +620,8 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
 		host->data_size = 0;
 	} else {
 		/* We assume the size of a page is 32-bits aligned */
-		atmci_writel(host, counter_reg, PAGE_SIZE / 4);
-		host->data_size -= PAGE_SIZE;
+		atmci_writel(host, counter_reg, sg_dma_len(host->sg) / 4);
+		host->data_size -= sg_dma_len(host->sg);
 		if (host->data_size)
 			host->sg = sg_next(host->sg);
 	}
@@ -808,7 +808,6 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 	/* Configure PDC */
 	host->data_size = data->blocks * data->blksz;
 	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len, dir);
-	BUG_ON(sg_len < host->data_size / PAGE_SIZE);
 	if (host->data_size)
 		atmci_pdc_set_both_buf(host,
 			((dir == DMA_FROM_DEVICE)?XFER_RECEIVE:XFER_TRANSMIT));
-- 
1.7.0.4

