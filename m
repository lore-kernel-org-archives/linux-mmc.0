From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 08/25] mmc: sdhci: avoid unnecessary mapping/unmapping of
 align buffer
Date: Fri, 29 Jan 2016 09:44:26 +0000
Message-ID: <E1aP5bO-0001pJ-B1@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44218 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbcA2Jok (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:44:40 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Unnecessarily mapping and unmapping the align buffer for SD cards is
expensive: performance measurements on iMX6 show that this gives a hit
of 10% on hdparm buffered disk reads.

MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
for this case, the align buffer is not going to be used.  However, we
still map and unmap this buffer.

Eliminate this by switching the align buffer to be a DMA coherent
buffer, which needs no DMA maintenance to access the buffer.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 54 ++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f22b842cf25..b0655990defd 100644
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
-	BUG_ON(host->align_addr & SDHCI_ADMA2_MASK);
-
 	host->sg_count = sdhci_pre_dma_transfer(host, data);
 	if (host->sg_count < 0)
-		goto unmap_align;
+		return -EINVAL;
 
 	desc = host->adma_table;
 	align = host->align_buffer;
@@ -570,22 +557,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -605,9 +577,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	else
 		direction = DMA_TO_DEVICE;
 
-	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
-		host->align_buffer_sz, direction);
-
 	/* Do a quick scan of the SG list for any unaligned mappings */
 	has_unaligned = false;
 	for_each_sg(data->sg, sg, host->sg_count, i)
@@ -2983,14 +2952,21 @@ int sdhci_add_host(struct sdhci_host *host)
 						      &host->adma_addr,
 						      GFP_KERNEL);
 		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
-		host->align_buffer = kmalloc(host->align_buffer_sz, GFP_KERNEL);
+		host->align_buffer = dma_alloc_coherent(mmc_dev(mmc),
+							host->align_buffer_sz,
+							&host->align_addr,
+							GFP_KERNEL);
 		if (!host->adma_table || !host->align_buffer) {
 			if (host->adma_table)
 				dma_free_coherent(mmc_dev(mmc),
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
@@ -3002,10 +2978,14 @@ int sdhci_add_host(struct sdhci_host *host)
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
+		BUG_ON(host->align_addr & SDHCI_ADMA2_MASK);
 	}
 
 	/*
@@ -3469,7 +3449,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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

