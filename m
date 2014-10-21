From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/15] mmc: sdhci: Parameterize ADMA sizes and alignment
Date: Tue, 21 Oct 2014 12:26:18 +0300
Message-ID: <1413883585-16299-9-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316AbaJUJ2H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:07 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

In preparation for 64-bit ADMA, parameterize ADMA sizes
and alignment.  64-bit ADMA has a larger descriptor
because it contains a 64-bit address instead of a 32-bit
address.  Also data must be 8-byte aligned instead
of 4-byte aligned.  Consequently, sdhci_host members
are added for descriptor, table, and buffer sizes
and alignment.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 68 +++++++++++++++++++++++------------------------
 include/linux/mmc/sdhci.h |  7 +++++
 2 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a4322e2..41a3f79 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -44,14 +44,6 @@
 
 #define MAX_TUNING_LOOP 40
 
-/*
- * The ADMA2 descriptor table size is calculated as the maximum number of
- * segments (128), times 2 to allow for an alignment descriptor for each
- * segment, plus 1 for a nop end descriptor, all multipled by the 32-bit
- * descriptor size (8).
- */
-#define ADMA_SIZE	((128 * 2 + 1) * 8)
-
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
@@ -502,10 +494,10 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		direction = DMA_TO_DEVICE;
 
 	host->align_addr = dma_map_single(mmc_dev(host->mmc),
-		host->align_buffer, 128 * 4, direction);
+		host->align_buffer, host->align_buffer_sz, direction);
 	if (dma_mapping_error(mmc_dev(host->mmc), host->align_addr))
 		goto fail;
-	BUG_ON(host->align_addr & 0x3);
+	BUG_ON(host->align_addr & host->align_mask);
 
 	host->sg_count = dma_map_sg(mmc_dev(host->mmc),
 		data->sg, data->sg_len, direction);
@@ -528,7 +520,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		 * the (up to three) bytes that screw up the
 		 * alignment.
 		 */
-		offset = (4 - (addr & 0x3)) & 0x3;
+		offset = (host->align_sz - (addr & host->align_mask)) &
+			 host->align_mask;
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
@@ -543,10 +536,10 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 
 			BUG_ON(offset > 65536);
 
-			align += 4;
-			align_addr += 4;
+			align += host->align_sz;
+			align_addr += host->align_sz;
 
-			desc += 8;
+			desc += host->desc_sz;
 
 			addr += offset;
 			len -= offset;
@@ -556,13 +549,13 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 
 		/* tran, valid */
 		sdhci_adma_write_desc(desc, addr, len, 0x21);
-		desc += 8;
+		desc += host->desc_sz;
 
 		/*
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_table) >= ADMA_SIZE);
+		WARN_ON((desc - host->adma_table) >= host->adma_table_sz);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
@@ -570,7 +563,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		* Mark the last descriptor as the terminating descriptor
 		*/
 		if (desc != host->adma_table) {
-			desc -= 8;
+			desc -= host->desc_sz;
 			sdhci_adma_mark_end(desc);
 		}
 	} else {
@@ -587,14 +580,14 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	 */
 	if (data->flags & MMC_DATA_WRITE) {
 		dma_sync_single_for_device(mmc_dev(host->mmc),
-			host->align_addr, 128 * 4, direction);
+			host->align_addr, host->align_buffer_sz, direction);
 	}
 
 	return 0;
 
 unmap_align:
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
-		128 * 4, direction);
+		host->align_buffer_sz, direction);
 fail:
 	return -EINVAL;
 }
@@ -617,12 +610,12 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		direction = DMA_TO_DEVICE;
 
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
-		128 * 4, direction);
+		host->align_buffer_sz, direction);
 
 	/* Do a quick scan of the SG list for any unaligned mappings */
 	has_unaligned = false;
 	for_each_sg(data->sg, sg, host->sg_count, i)
-		if (sg_dma_address(sg) & 3) {
+		if (sg_dma_address(sg) & host->align_mask) {
 			has_unaligned = true;
 			break;
 		}
@@ -634,8 +627,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		align = host->align_buffer;
 
 		for_each_sg(data->sg, sg, host->sg_count, i) {
-			if (sg_dma_address(sg) & 0x3) {
-				size = 4 - (sg_dma_address(sg) & 0x3);
+			if (sg_dma_address(sg) & host->align_mask) {
+				size = host->align_sz -
+				       (sg_dma_address(sg) & host->align_mask);
 
 				buffer = sdhci_kmap_atomic(sg, &flags);
 				WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
@@ -643,7 +637,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 				memcpy(buffer, align, size);
 				sdhci_kunmap_atomic(buffer, &flags);
 
-				align += 4;
+				align += host->align_sz;
 			}
 		}
 	}
@@ -2315,7 +2309,7 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 		DBG("%s: %p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
 		    name, desc, le32_to_cpu(*dma), le16_to_cpu(*len), attr);
 
-		desc += 8;
+		desc += host->desc_sz;
 
 		if (attr & 2)
 			break;
@@ -2877,17 +2871,23 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	if (host->flags & SDHCI_USE_ADMA) {
 		/*
-		 * We need to allocate descriptors for all sg entries
-		 * (128) and potentially one alignment transfer for
-		 * each of those entries.
+		 * The DMA descriptor table size is calculated as the maximum
+		 * number of segments times 2, to allow for an alignment
+		 * descriptor for each segment, plus 1 for a nop end descriptor,
+		 * all multipled by the descriptor size.
 		 */
+		host->adma_table_sz = (128 * 2 + 1) * 8;
+		host->align_buffer_sz = 128 * 4;
+		host->desc_sz = 8;
+		host->align_sz = 4;
+		host->align_mask = 3;
 		host->adma_table = dma_alloc_coherent(mmc_dev(mmc),
-						      ADMA_SIZE,
+						      host->adma_table_sz,
 						      &host->adma_addr,
 						      GFP_KERNEL);
-		host->align_buffer = kmalloc(128 * 4, GFP_KERNEL);
+		host->align_buffer = kmalloc(host->align_buffer_sz, GFP_KERNEL);
 		if (!host->adma_table || !host->align_buffer) {
-			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
+			dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
 					  host->adma_table, host->adma_addr);
 			kfree(host->align_buffer);
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
@@ -2895,11 +2895,11 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->flags &= ~SDHCI_USE_ADMA;
 			host->adma_table = NULL;
 			host->align_buffer = NULL;
-		} else if (host->adma_addr & 3) {
+		} else if (host->adma_addr & host->align_mask) {
 			pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
-			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
+			dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
 					  host->adma_table, host->adma_addr);
 			kfree(host->align_buffer);
 			host->adma_table = NULL;
@@ -3362,7 +3362,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->adma_table)
-		dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
+		dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
 				  host->adma_table, host->adma_addr);
 	kfree(host->align_buffer);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 933dbbb..2a72e95 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -158,9 +158,16 @@ struct sdhci_host {
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 
+	size_t adma_table_sz;	/* ADMA descriptor table size */
+	size_t align_buffer_sz;	/* Bounce buffer size */
+
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
+	unsigned int desc_sz;	/* ADMA descriptor size */
+	unsigned int align_sz;	/* ADMA alignment */
+	unsigned int align_mask;	/* ADMA alignment mask */
+
 	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
 
 	struct timer_list timer;	/* Timer for timeouts */
-- 
1.9.1

