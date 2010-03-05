From: akpm@linux-foundation.org
Subject: [patch 110/160] mmc: at91_mci: use one coherent DMA buffer
Date: Fri, 05 Mar 2010 13:43:40 -0800
Message-ID: <201003052143.o25LheCj029834@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456Ab0CEVnw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, wolfgang.mues@auerswald.de, avictor.za@gmail.com, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

The TX DMA buffer is allocated only once, because the
allocation/deallocation of the buffer for EACH chunk of data is
time-consuming and prone to memory fragmentation.

Using a coherent DMA buffer avoids extra data cache calls.

[nicolas.ferre@atmel.com: coding style modifications]
Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/at91_mci.c |   49 ++++++++++++++++------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff -puN drivers/mmc/host/at91_mci.c~mmc-at91_mci-use-one-coherent-dma-buffer drivers/mmc/host/at91_mci.c
--- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-use-one-coherent-dma-buffer
+++ a/drivers/mmc/host/at91_mci.c
@@ -88,6 +88,10 @@
 #define at91_mci_read(host, reg)	__raw_readl((host)->baseaddr + (reg))
 #define at91_mci_write(host, reg, val)	__raw_writel((val), (host)->baseaddr + (reg))
 
+#define MCI_BLKSIZE 		512
+#define MCI_MAXBLKSIZE 		4095
+#define MCI_BLKATONCE 		256
+#define MCI_BUFSIZE 		(MCI_BLKSIZE * MCI_BLKATONCE)
 
 /*
  * Low level type for this driver
@@ -604,7 +608,6 @@ static void at91_mci_send_command(struct
 				/*
 				 * Handle a read
 				 */
-				host->buffer = NULL;
 				host->total_length = 0;
 
 				at91_mci_pre_dma_read(host);
@@ -623,20 +626,8 @@ static void at91_mci_send_command(struct
 					if (host->total_length < 12)
 						host->total_length = 12;
 
-				host->buffer = kmalloc(host->total_length, GFP_KERNEL);
-				if (!host->buffer) {
-					pr_debug("Can't alloc tx buffer\n");
-					cmd->error = -ENOMEM;
-					mmc_request_done(host->mmc, host->request);
-					return;
-				}
-
 				at91_mci_sg_to_dma(host, data);
 
-				host->physical_address = dma_map_single(NULL,
-						host->buffer, host->total_length,
-						DMA_TO_DEVICE);
-
 				pr_debug("Transmitting %d bytes\n", host->total_length);
 
 				at91_mci_write(host, ATMEL_PDC_TPR, host->physical_address);
@@ -703,14 +694,6 @@ static void at91_mci_completed_command(s
 	cmd->resp[2] = at91_mci_read(host, AT91_MCI_RSPR(2));
 	cmd->resp[3] = at91_mci_read(host, AT91_MCI_RSPR(3));
 
-	if (host->buffer) {
-		dma_unmap_single(NULL,
-				host->physical_address, host->total_length,
-				DMA_TO_DEVICE);
-		kfree(host->buffer);
-		host->buffer = NULL;
-	}
-
 	pr_debug("Status = %08X/%08x [%08X %08X %08X %08X]\n",
 		 status, at91_mci_read(host, AT91_MCI_SR),
 		 cmd->resp[0], cmd->resp[1], cmd->resp[2], cmd->resp[3]);
@@ -1012,12 +995,12 @@ static int __init at91_mci_probe(struct 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_SDIO_IRQ;
 
-	mmc->max_blk_size = 4095;
-	mmc->max_blk_count = mmc->max_req_size;
+	mmc->max_blk_size  = MCI_MAXBLKSIZE;
+	mmc->max_blk_count = MCI_BLKATONCE;
+	mmc->max_req_size  = MCI_BUFSIZE;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-	host->buffer = NULL;
 	host->bus_mode = 0;
 	host->board = pdev->dev.platform_data;
 	if (host->board->wire4) {
@@ -1028,6 +1011,14 @@ static int __init at91_mci_probe(struct 
 				" - using 1 wire\n");
 	}
 
+	host->buffer = dma_alloc_coherent(&pdev->dev, MCI_BUFSIZE,
+					&host->physical_address, GFP_KERNEL);
+	if (!host->buffer) {
+		ret = -ENOMEM;
+		dev_err(&pdev->dev, "Can't allocate transmit buffer\n");
+		goto fail5;
+	}
+
 	/*
 	 * Reserve GPIOs ... board init code makes sure these pins are set
 	 * up as GPIOs with the right direction (input, except for vcc)
@@ -1036,7 +1027,7 @@ static int __init at91_mci_probe(struct 
 		ret = gpio_request(host->board->det_pin, "mmc_detect");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "couldn't claim card detect pin\n");
-			goto fail5;
+			goto fail4b;
 		}
 	}
 	if (host->board->wp_pin) {
@@ -1136,6 +1127,10 @@ fail3:
 fail4:
 	if (host->board->det_pin)
 		gpio_free(host->board->det_pin);
+fail4b:
+	if (host->buffer)
+		dma_free_coherent(&pdev->dev, MCI_BUFSIZE,
+				host->buffer, host->physical_address);
 fail5:
 	mmc_free_host(mmc);
 fail6:
@@ -1158,6 +1153,10 @@ static int __exit at91_mci_remove(struct
 
 	host = mmc_priv(mmc);
 
+	if (host->buffer)
+		dma_free_coherent(&pdev->dev, MCI_BUFSIZE,
+				host->buffer, host->physical_address);
+
 	if (host->board->det_pin) {
 		if (device_can_wakeup(&pdev->dev))
 			free_irq(gpio_to_irq(host->board->det_pin), host);
_
