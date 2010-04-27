From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 2/4] MMC: atmel-mci: prevent kernel oops while removing card
Date: Tue, 27 Apr 2010 16:36:27 +0200
Message-ID: <8256ee3820a516fc6383a5e689a5c570a3b6ec75.1272378853.git.nicolas.ferre@atmel.com>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:55138 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab0D0NUm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Apr 2010 09:20:42 -0400
In-Reply-To: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
In-Reply-To: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: haavard.skinnemoen@atmel.com, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@avr32linux.org, Nicolas Ferre <nicolas.ferre@atmel.com>

The removing of an SD card in certain circumstances can lead to a kernel oops
if we do not make sure that the "data" field of the host structure is valid.
This patch adds a test in atmci_dma_cleanup() function and also calls
atmci_stop_dma() before throwing away the reference to data.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 321e0bf..12572e5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -569,9 +569,10 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 {
 	struct mmc_data			*data = host->data;
 
-	dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
-		     ((data->flags & MMC_DATA_WRITE)
-		      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+	if (data)
+		dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
+			     ((data->flags & MMC_DATA_WRITE)
+			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
 }
 
 static void atmci_stop_dma(struct atmel_mci *host)
@@ -1113,8 +1114,8 @@ static void atmci_command_complete(struct atmel_mci *host,
 			"command error: status=0x%08x\n", status);
 
 		if (cmd->data) {
-			host->data = NULL;
 			atmci_stop_dma(host);
+			host->data = NULL;
 			mci_writel(host, IDR, MCI_NOTBUSY
 					| MCI_TXRDY | MCI_RXRDY
 					| ATMCI_DATA_ERROR_FLAGS);
-- 
1.5.6.5

