From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/15] mmc: sdhci: Use 'void *' for not 'u8 *' for ADMA data
Date: Tue, 21 Oct 2014 12:26:17 +0300
Message-ID: <1413883585-16299-8-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316AbaJUJ2F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:05 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

It is kernel-style to use 'void *' for anonymous data.
This is being applied to the ADMA bounce buffer which
contains unaligned bytes, and to the ADMA descriptor
table which will contain 32-bit ADMA descriptors
or 64-bit ADMA descriptors when support is added.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 10 +++++-----
 include/linux/mmc/sdhci.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 833e792..a4322e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -454,7 +454,7 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(u8 *desc, u32 addr, int len, unsigned cmd)
+static void sdhci_adma_write_desc(void *desc, u32 addr, int len, unsigned cmd)
 {
 	__le32 *dataddr = (__le32 __force *)(desc + 4);
 	__le16 *cmdlen = (__le16 __force *)desc;
@@ -480,8 +480,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 {
 	int direction;
 
-	u8 *desc;
-	u8 *align;
+	void *desc;
+	void *align;
 	dma_addr_t addr;
 	dma_addr_t align_addr;
 	int len, offset;
@@ -606,7 +606,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 	struct scatterlist *sg;
 	int i, size;
-	u8 *align;
+	void *align;
 	char *buffer;
 	unsigned long flags;
 	bool has_unaligned;
@@ -2300,7 +2300,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
-	u8 *desc = host->adma_table;
+	void *desc = host->adma_table;
 	__le32 *dma;
 	__le16 *len;
 	u8 attr;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 76e0432..933dbbb 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -155,8 +155,8 @@ struct sdhci_host {
 
 	int sg_count;		/* Mapped sg entries */
 
-	u8 *adma_table;		/* ADMA descriptor table */
-	u8 *align_buffer;	/* Bounce buffer */
+	void *adma_table;	/* ADMA descriptor table */
+	void *align_buffer;	/* Bounce buffer */
 
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
-- 
1.9.1

