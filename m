From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 09/15] mmc: sdhci: Define maximum segments
Date: Tue,  4 Nov 2014 12:42:43 +0200
Message-ID: <1415097769-19032-10-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34410 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbaKDKof (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:35 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Define the maximum number of segments instead of
having the constant 128 appearing in the code in
various places.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 drivers/mmc/host/sdhci.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 053b55d..586c739 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2877,8 +2877,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * descriptor for each segment, plus 1 for a nop end descriptor,
 		 * all multipled by the descriptor size.
 		 */
-		host->adma_table_sz = (128 * 2 + 1) * 8;
-		host->align_buffer_sz = 128 * 4;
+		host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) * 8;
+		host->align_buffer_sz = SDHCI_MAX_SEGS * 4;
 		host->desc_sz = 8;
 		host->align_sz = 4;
 		host->align_mask = 3;
@@ -3192,11 +3192,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * can do scatter/gather or not.
 	 */
 	if (host->flags & SDHCI_USE_ADMA)
-		mmc->max_segs = 128;
+		mmc->max_segs = SDHCI_MAX_SEGS;
 	else if (host->flags & SDHCI_USE_SDMA)
 		mmc->max_segs = 1;
 	else /* PIO */
-		mmc->max_segs = 128;
+		mmc->max_segs = SDHCI_MAX_SEGS;
 
 	/*
 	 * Maximum number of sectors in one transfer. Limited by DMA boundary
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 31896a7..6ae75cd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -266,6 +266,12 @@
 #define SDHCI_DEFAULT_BOUNDARY_SIZE  (512 * 1024)
 #define SDHCI_DEFAULT_BOUNDARY_ARG   (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12)
 
+/*
+ * Maximum segments assuming a 512KiB maximum requisition size and a minimum
+ * 4KiB page size.
+ */
+#define SDHCI_MAX_SEGS		128
+
 struct sdhci_ops {
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
 	u32		(*read_l)(struct sdhci_host *host, int reg);
-- 
1.9.1

