From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/17] mmc: sdhci: avoid unnecessary mapping/unmapping of
 align buffer
Date: Sat, 19 Dec 2015 20:30:39 +0000
Message-ID: <E1aAO9H-0007yC-Dl@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36139 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSUaz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:30:55 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Unnecessarily mapping and unmapping the align buffer for SD cards is
expensive: performance measurements on iMX6 show that this gives a hit
of 10% on hdparm buffered disk reads.

MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
for this case, the align buffer is not going to be used.  However, we
still map and unmap this buffer.

Eliminate this by switching the align buffer to be a DMA coherent
buffer, which needs no DMA maintanence to access the buffer.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 53 ++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3e718e465a1b..8a4eb1c41f3e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -465,8 +465,6 @@ static void sdhci_adma_mark_end(void *desc)
 static int sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data)
 {
-	int direction;
-
 	void *desc;
 	void *align;
 	dma_addr_t addr;
@@ -483,20 +481,9 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	if (data->flags & MMC_DATA_READ)
-		direction = DMA_FROM_DEVICE;
-	else
-		direction = DMA_TO_DEVICE;
-
-	host->align_addr = dma_map_single(mmc_dev(host->mmc),
-		host->align_buffer, host->align_buffer_sz, direction);
-	if (dma_mapping_error(mmc_dev(host->mmc), host->align_addr))
-		goto fail;
-	BUG_ON(host->align_addr & host->align_mask);
-
 	host->sg_count = sdhci_pre_dma_transfer(host, data);
 	if (host->sg_count < 0)
-		goto unmap_align;
+		return -EINVAL;
 
 	desc = host->adma_table;
 	align = host->align_buffer;
@@ -567,22 +554,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		/* nop, end, valid */
 		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
-
-	/*
-	 * Resync align buffer as we might have changed it.
-	 */
-	if (data->flags & MMC_DATA_WRITE) {
-		dma_sync_single_for_device(mmc_dev(host->mmc),
-			host->align_addr, host->align_buffer_sz, direction);
-	}
-
 	return 0;
-
-unmap_align:
-	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
-		host->align_buffer_sz, direction);
-fail:
-	return -EINVAL;
 }
 
 static void sdhci_adma_table_post(struct sdhci_host *host,
@@ -602,9 +574,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	else
 		direction = DMA_TO_DEVICE;
 
-	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
-		host->align_buffer_sz, direction);
-
 	/* Do a quick scan of the SG list for any unaligned mappings */
 	has_unaligned = false;
 	for_each_sg(data->sg, sg, host->sg_count, i)
@@ -3003,6 +2972,10 @@ int sdhci_add_host(struct sdhci_host *host)
 						      host->adma_table_sz,
 						      &host->adma_addr,
 						      GFP_KERNEL);
+		host->align_buffer = dma_alloc_coherent(mmc_dev(mmc),
+							host->align_buffer_sz,
+							&host->align_addr,
+							GFP_KERNEL);
 		host->align_buffer = kmalloc(host->align_buffer_sz, GFP_KERNEL);
 		if (!host->adma_table || !host->align_buffer) {
 			if (host->adma_table)
@@ -3010,7 +2983,11 @@ int sdhci_add_host(struct sdhci_host *host)
 						  host->adma_table_sz,
 						  host->adma_table,
 						  host->adma_addr);
-			kfree(host->align_buffer);
+			if (host->align_buffer)
+				dma_free_coherent(mmc_dev(mmc),
+						  host->align_buffer_sz,
+						  host->align_buffer,
+						  host->align_addr);
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
@@ -3022,10 +2999,14 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->flags &= ~SDHCI_USE_ADMA;
 			dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
 					  host->adma_table, host->adma_addr);
-			kfree(host->align_buffer);
+			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz,
+					  host->align_buffer, host->align_addr);
 			host->adma_table = NULL;
 			host->align_buffer = NULL;
 		}
+
+		/* dma_alloc_coherent returns page aligned and sized buffers */
+		BUG_ON(host->align_addr & host->align_mask);
 	}
 
 	/*
@@ -3489,7 +3470,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (host->adma_table)
 		dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
 				  host->adma_table, host->adma_addr);
-	kfree(host->align_buffer);
+	if (host->align_buffer)
+		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz,
+				  host->align_buffer, host->align_addr);
 
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
-- 
2.1.0

