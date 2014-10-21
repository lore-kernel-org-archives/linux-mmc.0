From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/15] mmc: sdhci: Add 64-bit ADMA support
Date: Tue, 21 Oct 2014 12:26:22 +0300
Message-ID: <1413883585-16299-13-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbaJUJ2N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:13 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add 64-bit ADMA support including:
	- add 64-bit ADMA descriptor
	- add SDHCI_USE_64_BIT_DMA flag
	- set upper 32-bits of DMA addresses
	- ability to select 64-bit ADMA
	- ability to use 64-bit ADMA sizes and alignment
	- display "ADMA 64-bit" when host is added

It is assumed that a 64-bit capable device has set a 64-bit DMA mask
and *must* do 64-bit DMA.  A driver has the opportunity to change
that during the first call to ->enable_dma().  Similarly
SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
implement.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 109 ++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h  |  18 ++++++++
 include/linux/mmc/sdhci.h |   3 ++
 3 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e503fd4..9918225 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -117,10 +117,17 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	pr_debug(DRIVER_NAME ": Host ctl2: 0x%08x\n",
 		sdhci_readw(host, SDHCI_HOST_CONTROL2));
 
-	if (host->flags & SDHCI_USE_ADMA)
-		pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
-		       readl(host->ioaddr + SDHCI_ADMA_ERROR),
-		       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+	if (host->flags & SDHCI_USE_ADMA) {
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
+				 readl(host->ioaddr + SDHCI_ADMA_ERROR),
+				 readl(host->ioaddr + SDHCI_ADMA_ADDRESS_HI),
+				 readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+		else
+			pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
+				 readl(host->ioaddr + SDHCI_ADMA_ERROR),
+				 readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+	}
 
 	pr_debug(DRIVER_NAME ": ===========================================\n");
 }
@@ -446,19 +453,25 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(void *desc, u32 addr, int len, unsigned cmd)
+static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				  dma_addr_t addr, int len, unsigned cmd)
 {
-	struct sdhci_adma2_32_desc *dma_desc = desc;
+	struct sdhci_adma2_64_desc *dma_desc = desc;
 
+	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
 	dma_desc->len = cpu_to_le16(len);
-	dma_desc->addr = cpu_to_le32(addr);
+	dma_desc->addr_lo = cpu_to_le32((u32)addr);
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
 }
 
 static void sdhci_adma_mark_end(void *desc)
 {
-	struct sdhci_adma2_32_desc *dma_desc = desc;
+	struct sdhci_adma2_64_desc *dma_desc = desc;
 
+	/* 32-bit and 64-bit descriptors have 'cmd' in same position */
 	dma_desc->cmd |= cpu_to_le16(ADMA2_END);
 }
 
@@ -527,7 +540,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(desc, align_addr, offset,
+			sdhci_adma_write_desc(host, desc, align_addr, offset,
 					      ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
@@ -544,7 +557,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		BUG_ON(len > 65536);
 
 		/* tran, valid */
-		sdhci_adma_write_desc(desc, addr, len, ADMA2_TRAN_VALID);
+		sdhci_adma_write_desc(host, desc, addr, len, ADMA2_TRAN_VALID);
 		desc += host->desc_sz;
 
 		/*
@@ -568,7 +581,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		*/
 
 		/* nop, end, valid */
-		sdhci_adma_write_desc(desc, 0, 0, ADMA2_NOP_END_VALID);
+		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 
 	/*
@@ -827,6 +840,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			} else {
 				sdhci_writel(host, host->adma_addr,
 					SDHCI_ADMA_ADDRESS);
+				if (host->flags & SDHCI_USE_64_BIT_DMA)
+					sdhci_writel(host,
+						     (u64)host->adma_addr >> 32,
+						     SDHCI_ADMA_ADDRESS_HI);
 			}
 		} else {
 			int sg_cnt;
@@ -860,10 +877,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 		ctrl &= ~SDHCI_CTRL_DMA_MASK;
 		if ((host->flags & SDHCI_REQ_USE_DMA) &&
-			(host->flags & SDHCI_USE_ADMA))
-			ctrl |= SDHCI_CTRL_ADMA32;
-		else
+			(host->flags & SDHCI_USE_ADMA)) {
+			if (host->flags & SDHCI_USE_64_BIT_DMA)
+				ctrl |= SDHCI_CTRL_ADMA64;
+			else
+				ctrl |= SDHCI_CTRL_ADMA32;
+		} else {
 			ctrl |= SDHCI_CTRL_SDMA;
+		}
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 	}
 
@@ -2295,12 +2316,19 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 	sdhci_dumpregs(host);
 
 	while (true) {
-		struct sdhci_adma2_32_desc *dma_desc = desc;
-
-		DBG("%s: %p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
-		    name, desc, le32_to_cpu(dma_desc->addr),
-		    le16_to_cpu(dma_desc->len),
-		    le16_to_cpu(dma_desc->cmd));
+		struct sdhci_adma2_64_desc *dma_desc = desc;
+
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			DBG("%s: %p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    name, desc, le32_to_cpu(dma_desc->addr_hi),
+			    le32_to_cpu(dma_desc->addr_lo),
+			    le16_to_cpu(dma_desc->len),
+			    le16_to_cpu(dma_desc->cmd));
+		else
+			DBG("%s: %p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    name, desc, le32_to_cpu(dma_desc->addr_lo),
+			    le16_to_cpu(dma_desc->len),
+			    le16_to_cpu(dma_desc->cmd));
 
 		desc += host->desc_sz;
 
@@ -2851,6 +2879,16 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
+	/*
+	 * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
+	 * and *must* do 64-bit DMA.  A driver has the opportunity to change
+	 * that during the first call to ->enable_dma().  Similarly
+	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
+	 * implement.
+	 */
+	if (sdhci_readl(host, SDHCI_CAPABILITIES) & SDHCI_CAN_64BIT)
+		host->flags |= SDHCI_USE_64_BIT_DMA;
+
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma) {
 			if (host->ops->enable_dma(host)) {
@@ -2862,6 +2900,10 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}
 
+	/* SDMA does not support 64-bit DMA */
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		host->flags &= ~SDHCI_USE_SDMA;
+
 	if (host->flags & SDHCI_USE_ADMA) {
 		/*
 		 * The DMA descriptor table size is calculated as the maximum
@@ -2869,13 +2911,23 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * descriptor for each segment, plus 1 for a nop end descriptor,
 		 * all multipled by the descriptor size.
 		 */
-		host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
-				      SDHCI_ADMA2_32_DESC_SZ;
-		host->align_buffer_sz = SDHCI_MAX_SEGS *
-					SDHCI_ADMA2_32_ALIGN;
-		host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
-		host->align_sz = SDHCI_ADMA2_32_ALIGN;
-		host->align_mask = SDHCI_ADMA2_32_ALIGN - 1;
+		if (host->flags & SDHCI_USE_64_BIT_DMA) {
+			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+					      SDHCI_ADMA2_64_DESC_SZ;
+			host->align_buffer_sz = SDHCI_MAX_SEGS *
+						SDHCI_ADMA2_64_ALIGN;
+			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
+			host->align_sz = SDHCI_ADMA2_64_ALIGN;
+			host->align_mask = SDHCI_ADMA2_64_ALIGN - 1;
+		} else {
+			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+					      SDHCI_ADMA2_32_DESC_SZ;
+			host->align_buffer_sz = SDHCI_MAX_SEGS *
+						SDHCI_ADMA2_32_ALIGN;
+			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
+			host->align_sz = SDHCI_ADMA2_32_ALIGN;
+			host->align_mask = SDHCI_ADMA2_32_ALIGN - 1;
+		}
 		host->adma_table = dma_alloc_coherent(mmc_dev(mmc),
 						      host->adma_table_sz,
 						      &host->adma_addr,
@@ -3288,7 +3340,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
-		(host->flags & SDHCI_USE_ADMA) ? "ADMA" :
+		(host->flags & SDHCI_USE_ADMA) ?
+		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
 
 	sdhci_enable_card_detection(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 14c8b67..c2ec7fc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -227,6 +227,7 @@
 /* 55-57 reserved */
 
 #define SDHCI_ADMA_ADDRESS	0x58
+#define SDHCI_ADMA_ADDRESS_HI	0x5C
 
 /* 60-FB reserved */
 
@@ -279,6 +280,23 @@ struct sdhci_adma2_32_desc {
 	__le32	addr;
 }  __packed __aligned(SDHCI_ADMA2_32_ALIGN);
 
+/* ADMA2 64-bit DMA descriptor size */
+#define SDHCI_ADMA2_64_DESC_SZ	12
+
+/* ADMA2 64-bit DMA alignment */
+#define SDHCI_ADMA2_64_ALIGN	8
+
+/*
+ * ADMA2 64-bit descriptor. Note 12-byte descriptor can't always be 8-byte
+ * aligned.
+ */
+struct sdhci_adma2_64_desc {
+	__le16	cmd;
+	__le16	len;
+	__le32	addr_lo;
+	__le32	addr_hi;
+}  __packed __aligned(4);
+
 #define ADMA2_TRAN_VALID	0x21
 #define ADMA2_NOP_END_VALID	0x3
 #define ADMA2_END		0x2
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 2a72e95..931ac5e 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
 /* Stop command (CMD12) can set Transfer Complete when not using MMC_RSP_BUSY */
 #define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
+/* Controller does not support 64-bit DMA */
+#define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			(1<<9)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -130,6 +132,7 @@ struct sdhci_host {
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_SDR104_NEEDS_TUNING (1<<10)	/* SDR104/HS200 needs tuning */
 #define SDHCI_USING_RETUNING_TIMER (1<<11)	/* Host is using a retuning timer for the card */
+#define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.9.1

