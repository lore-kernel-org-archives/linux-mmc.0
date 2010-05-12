From: <gregkh@suse.de>
Subject: patch mmc-atmel-mci-prevent-kernel-oops-while-removing-card.patch added to 2.6.33-stable tree
Date: Wed, 12 May 2010 16:20:22 -0700
Message-ID: <12737064221145@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45771 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514Ab0ELXUi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 May 2010 19:20:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nicolas.ferre@atmel.com, akpm@linux-foundation.org, gregkh@suse.de, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc: atmel-mci: prevent kernel oops while removing card

to the 2.6.33-stable tree.  Its filename is

    mmc-atmel-mci-prevent-kernel-oops-while-removing-card.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From 009a891b22395fc86e5f34057d79fffee4509ab5 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 11 May 2010 14:06:49 -0700
Subject: mmc: atmel-mci: prevent kernel oops while removing card

From: Nicolas Ferre <nicolas.ferre@atmel.com>

commit 009a891b22395fc86e5f34057d79fffee4509ab5 upstream.

The removing of an SD card in certain circumstances can lead to a kernel
oops if we do not make sure that the "data" field of the host structure is
valid.  This patch adds a test in atmci_dma_cleanup() function and also
calls atmci_stop_dma() before throwing away the reference to data.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/atmel-mci.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -568,9 +568,10 @@ static void atmci_dma_cleanup(struct atm
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
@@ -1098,8 +1099,8 @@ static void atmci_command_complete(struc
 			"command error: status=0x%08x\n", status);
 
 		if (cmd->data) {
-			host->data = NULL;
 			atmci_stop_dma(host);
+			host->data = NULL;
 			mci_writel(host, IDR, MCI_NOTBUSY
 					| MCI_TXRDY | MCI_RXRDY
 					| ATMCI_DATA_ERROR_FLAGS);


Patches currently in stable-queue which might be from nicolas.ferre@atmel.com are

queue-2.6.33/mmc-atmel-mci-remove-data-error-interrupt-after-xfer.patch
queue-2.6.33/mmc-atmel-mci-prevent-kernel-oops-while-removing-card.patch
queue-2.6.33/mmc-atmel-mci-fix-two-parameters-swapped.patch
