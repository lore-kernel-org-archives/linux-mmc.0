From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 10/15] mmc: sdhci: Define ADMA constants
Date: Tue,  4 Nov 2014 12:42:44 +0200
Message-ID: <1415097769-19032-11-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64535 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbaKDKog (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:36 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Define all the ADMA constants instead of having numbers
scattered throughout the code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++----------
 drivers/mmc/host/sdhci.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 586c739..11b6217 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -464,7 +464,7 @@ static void sdhci_adma_mark_end(void *desc)
 {
 	u8 *dma_desc = desc;
 
-	dma_desc[0] |= 0x2; /* end */
+	dma_desc[0] |= ADMA2_END;
 }
 
 static int sdhci_adma_table_pre(struct sdhci_host *host,
@@ -532,7 +532,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(desc, align_addr, offset, 0x21);
+			sdhci_adma_write_desc(desc, align_addr, offset,
+					      ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
@@ -548,7 +549,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		BUG_ON(len > 65536);
 
 		/* tran, valid */
-		sdhci_adma_write_desc(desc, addr, len, 0x21);
+		sdhci_adma_write_desc(desc, addr, len, ADMA2_TRAN_VALID);
 		desc += host->desc_sz;
 
 		/*
@@ -572,7 +573,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		*/
 
 		/* nop, end, valid */
-		sdhci_adma_write_desc(desc, 0, 0, 0x3);
+		sdhci_adma_write_desc(desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 
 	/*
@@ -2312,7 +2313,7 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 
 		desc += host->desc_sz;
 
-		if (attr & 2)
+		if (attr & ADMA2_END)
 			break;
 	}
 }
@@ -2877,11 +2878,13 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * descriptor for each segment, plus 1 for a nop end descriptor,
 		 * all multipled by the descriptor size.
 		 */
-		host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) * 8;
-		host->align_buffer_sz = SDHCI_MAX_SEGS * 4;
-		host->desc_sz = 8;
-		host->align_sz = 4;
-		host->align_mask = 3;
+		host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+				      SDHCI_ADMA2_32_DESC_SZ;
+		host->align_buffer_sz = SDHCI_MAX_SEGS *
+					SDHCI_ADMA2_32_ALIGN;
+		host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
+		host->align_sz = SDHCI_ADMA2_32_ALIGN;
+		host->align_mask = SDHCI_ADMA2_32_ALIGN - 1;
 		host->adma_table = dma_alloc_coherent(mmc_dev(mmc),
 						      host->adma_table_sz,
 						      &host->adma_addr,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6ae75cd..823cce1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -266,6 +266,16 @@
 #define SDHCI_DEFAULT_BOUNDARY_SIZE  (512 * 1024)
 #define SDHCI_DEFAULT_BOUNDARY_ARG   (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12)
 
+/* ADMA2 32-bit DMA descriptor size */
+#define SDHCI_ADMA2_32_DESC_SZ	8
+
+/* ADMA2 32-bit DMA alignment */
+#define SDHCI_ADMA2_32_ALIGN	4
+
+#define ADMA2_TRAN_VALID	0x21
+#define ADMA2_NOP_END_VALID	0x3
+#define ADMA2_END		0x2
+
 /*
  * Maximum segments assuming a 512KiB maximum requisition size and a minimum
  * 4KiB page size.
-- 
1.9.1

