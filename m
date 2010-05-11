From: akpm@linux-foundation.org
Subject: [patch 05/17] mmc: atmel-mci: prevent kernel oops while removing card
Date: Tue, 11 May 2010 14:06:49 -0700
Message-ID: <201005112106.o4BL6nQq023077@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40311 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab0EKVG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 17:06:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, stable@kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

The removing of an SD card in certain circumstances can lead to a kernel
oops if we do not make sure that the "data" field of the host structure is
valid.  This patch adds a test in atmci_dma_cleanup() function and also
calls atmci_stop_dma() before throwing away the reference to data.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/atmel-mci.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -puN drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-prevent-kernel-oops-while-removing-card drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-prevent-kernel-oops-while-removing-card
+++ a/drivers/mmc/host/atmel-mci.c
@@ -569,9 +569,10 @@ static void atmci_dma_cleanup(struct atm
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
@@ -1099,8 +1100,8 @@ static void atmci_command_complete(struc
 			"command error: status=0x%08x\n", status);
 
 		if (cmd->data) {
-			host->data = NULL;
 			atmci_stop_dma(host);
+			host->data = NULL;
 			mci_writel(host, IDR, MCI_NOTBUSY
 					| MCI_TXRDY | MCI_RXRDY
 					| ATMCI_DATA_ERROR_FLAGS);
_
