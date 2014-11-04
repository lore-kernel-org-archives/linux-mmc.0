From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 05/15] mmc: sdhci: Rename adma_desc to adma_table
Date: Tue,  4 Nov 2014 12:42:39 +0200
Message-ID: <1415097769-19032-6-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbaKDKo3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:29 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

In preparation for 64-bit ADMA, rename adma_desc to
adma_table.  That is because members will be added
for descriptor size and table size, so using adma_desc
(which is the table) is confusing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c  | 31 ++++++++++++++++---------------
 include/linux/mmc/sdhci.h |  2 +-
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e40414a..f2062b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -505,7 +505,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	if (host->sg_count == 0)
 		goto unmap_align;
 
-	desc = host->adma_desc;
+	desc = host->adma_table;
 	align = host->align_buffer;
 
 	align_addr = host->align_addr;
@@ -555,14 +555,14 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_desc) >= ADMA_SIZE);
+		WARN_ON((desc - host->adma_table) >= ADMA_SIZE);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
 		/*
 		* Mark the last descriptor as the terminating descriptor
 		*/
-		if (desc != host->adma_desc) {
+		if (desc != host->adma_table) {
 			desc -= 8;
 			desc[0] |= 0x2; /* end */
 		}
@@ -2294,7 +2294,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
-	u8 *desc = host->adma_desc;
+	u8 *desc = host->adma_table;
 	__le32 *dma;
 	__le16 *len;
 	u8 attr;
@@ -2875,27 +2875,28 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * (128) and potentially one alignment transfer for
 		 * each of those entries.
 		 */
-		host->adma_desc = dma_alloc_coherent(mmc_dev(mmc),
-						     ADMA_SIZE, &host->adma_addr,
-						     GFP_KERNEL);
+		host->adma_table = dma_alloc_coherent(mmc_dev(mmc),
+						      ADMA_SIZE,
+						      &host->adma_addr,
+						      GFP_KERNEL);
 		host->align_buffer = kmalloc(128 * 4, GFP_KERNEL);
-		if (!host->adma_desc || !host->align_buffer) {
+		if (!host->adma_table || !host->align_buffer) {
 			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
-					  host->adma_desc, host->adma_addr);
+					  host->adma_table, host->adma_addr);
 			kfree(host->align_buffer);
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
-			host->adma_desc = NULL;
+			host->adma_table = NULL;
 			host->align_buffer = NULL;
 		} else if (host->adma_addr & 3) {
 			pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
 			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
-					  host->adma_desc, host->adma_addr);
+					  host->adma_table, host->adma_addr);
 			kfree(host->align_buffer);
-			host->adma_desc = NULL;
+			host->adma_table = NULL;
 			host->align_buffer = NULL;
 		}
 	}
@@ -3351,12 +3352,12 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
 
-	if (host->adma_desc)
+	if (host->adma_table)
 		dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
-				  host->adma_desc, host->adma_addr);
+				  host->adma_table, host->adma_addr);
 	kfree(host->align_buffer);
 
-	host->adma_desc = NULL;
+	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dba793e..76e0432 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -155,7 +155,7 @@ struct sdhci_host {
 
 	int sg_count;		/* Mapped sg entries */
 
-	u8 *adma_desc;		/* ADMA descriptor table */
+	u8 *adma_table;		/* ADMA descriptor table */
 	u8 *align_buffer;	/* Bounce buffer */
 
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
-- 
1.9.1

