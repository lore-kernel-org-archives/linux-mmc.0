From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/15] mmc: sdhci: Define ADMA descriptor structure
Date: Tue, 21 Oct 2014 12:26:21 +0300
Message-ID: <1413883585-16299-12-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbaJUJ2L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:11 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Define the ADMA descriptor structure instead of
using manual offsets and casts.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 30 +++++++++++-------------------
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5dd5408..e503fd4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -448,23 +448,18 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 
 static void sdhci_adma_write_desc(void *desc, u32 addr, int len, unsigned cmd)
 {
-	__le32 *dataddr = (__le32 __force *)(desc + 4);
-	__le16 *cmdlen = (__le16 __force *)desc;
+	struct sdhci_adma2_32_desc *dma_desc = desc;
 
-	/* SDHCI specification says ADMA descriptors should be 4 byte
-	 * aligned, so using 16 or 32bit operations should be safe. */
-
-	cmdlen[0] = cpu_to_le16(cmd);
-	cmdlen[1] = cpu_to_le16(len);
-
-	dataddr[0] = cpu_to_le32(addr);
+	dma_desc->cmd = cpu_to_le16(cmd);
+	dma_desc->len = cpu_to_le16(len);
+	dma_desc->addr = cpu_to_le32(addr);
 }
 
 static void sdhci_adma_mark_end(void *desc)
 {
-	u8 *dma_desc = desc;
+	struct sdhci_adma2_32_desc *dma_desc = desc;
 
-	dma_desc[0] |= ADMA2_END;
+	dma_desc->cmd |= cpu_to_le16(ADMA2_END);
 }
 
 static int sdhci_adma_table_pre(struct sdhci_host *host,
@@ -2296,23 +2291,20 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
 	void *desc = host->adma_table;
-	__le32 *dma;
-	__le16 *len;
-	u8 attr;
 
 	sdhci_dumpregs(host);
 
 	while (true) {
-		dma = (__le32 *)(desc + 4);
-		len = (__le16 *)(desc + 2);
-		attr = *desc;
+		struct sdhci_adma2_32_desc *dma_desc = desc;
 
 		DBG("%s: %p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
-		    name, desc, le32_to_cpu(*dma), le16_to_cpu(*len), attr);
+		    name, desc, le32_to_cpu(dma_desc->addr),
+		    le16_to_cpu(dma_desc->len),
+		    le16_to_cpu(dma_desc->cmd));
 
 		desc += host->desc_sz;
 
-		if (attr & ADMA2_END)
+		if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
 			break;
 	}
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 823cce1..14c8b67 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -272,6 +272,13 @@
 /* ADMA2 32-bit DMA alignment */
 #define SDHCI_ADMA2_32_ALIGN	4
 
+/* ADMA2 32-bit descriptor */
+struct sdhci_adma2_32_desc {
+	__le16	cmd;
+	__le16	len;
+	__le32	addr;
+}  __packed __aligned(SDHCI_ADMA2_32_ALIGN);
+
 #define ADMA2_TRAN_VALID	0x21
 #define ADMA2_NOP_END_VALID	0x3
 #define ADMA2_END		0x2
-- 
1.9.1

