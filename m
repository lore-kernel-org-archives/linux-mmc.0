From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: If ADMA is broken try SDMA before PIO
Date: Mon, 11 Jul 2011 12:19:15 -0700
Message-ID: <7B0ED90B-2CF6-459C-B66A-55A1633C462E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40882 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1GKTT0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jul 2011 15:19:26 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>, Jun Nie <njun@marvell.com>

Extend the fallback path for doing DMA by allowing
SDMA to be used before PIO when doing writes.

New quirk added to indicate ADMA needs 32 bit
addressing.  For compatibility, the existing
32 BIT DMA quirk indicated that both ADMA and SDMA
address are broken.  The new quirk allows finer
control if needed.

When checking if for the broken xDMA quirks special
case if both SDMA and ADMA are supported.  If SDMA is
not broken then use that rather than PIO.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |  122 ++++++++++++++++++++++++++++++++++----------
 include/linux/mmc/sdhci.h |    7 ++-
 2 files changed, 99 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..4da6a4d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -40,6 +40,10 @@
 
 #define MAX_TUNING_LOOP 40
 
+#define BROKEN_ADMA	(1<<0)
+#define BROKEN_SDMA	(1<<1)
+#define BROKEN_BOTH_DMA	(BROKEN_ADMA | BROKEN_SDMA)
+
 static unsigned int debug_quirks = 0;
 
 static void sdhci_finish_data(struct sdhci_host *);
@@ -481,7 +485,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & ~PAGE_MASK) > (PAGE_SIZE - 3));
 				memcpy(align, buffer, offset);
 				sdhci_kunmap_atomic(buffer, &flags);
 			}
@@ -589,7 +593,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 				size = 4 - (sg_dma_address(sg) & 0x3);
 
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & ~PAGE_MASK) > (PAGE_SIZE - 3));
 				memcpy(buffer, align, size);
 				sdhci_kunmap_atomic(buffer, &flags);
 
@@ -677,6 +681,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 	int ret;
+	int dmaflags = 0;
 
 	WARN_ON(host->data);
 
@@ -697,34 +702,62 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
 
-	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
+	dmaflags = host->flags & SDHCI_USE_S_ADMA;
+	if (dmaflags)
 		host->flags |= SDHCI_REQ_USE_DMA;
 
 	/*
 	 * FIXME: This doesn't account for merging when mapping the
 	 * scatterlist.
+	 * if ADMA cannot work --> try SDMA --> else PIO
 	 */
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int broken, i;
 		struct scatterlist *sg;
 
 		broken = 0;
-		if (host->flags & SDHCI_USE_ADMA) {
+		if (dmaflags & SDHCI_USE_ADMA) {
 			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
-				broken = 1;
-		} else {
+				broken |= BROKEN_ADMA;
+		}
+
+		if (dmaflags & SDHCI_USE_SDMA) {
 			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_SIZE)
-				broken = 1;
+				broken |= BROKEN_SDMA;
 		}
 
 		if (unlikely(broken)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->length & 0x3) {
-					DBG("Reverting to PIO because of "
-						"transfer size (%d)\n",
-						sg->length);
-					host->flags &= ~SDHCI_REQ_USE_DMA;
-					break;
+					if ((dmaflags & SDHCI_USE_S_ADMA) ==
+						SDHCI_USE_S_ADMA) {
+						if ((broken & BROKEN_BOTH_DMA) ==
+							BROKEN_ADMA) {
+							DBG("Reverting to SDMA "
+								"because of "
+								"transfer size "
+								"sg_offset = %08X, "
+								"sg->length = %d\n",
+								sg->offset, sg->length);
+							dmaflags &= ~SDHCI_USE_ADMA;
+						} else {
+							DBG("Reverting to PIO "
+								"because of "
+								"transfer size "
+								"sg_offset = %08X, "
+								"sg->length = %d\n",
+								sg->offset,
+								sg->length);
+							host->flags &= ~SDHCI_REQ_USE_DMA;
+						}
+					} else {
+						DBG("Reverting to PIO because of "
+							"transfer size "
+							"sg_offset = %08X, "
+							"sg->length = %d\n",
+							sg->offset, sg->length);
+						host->flags &= ~SDHCI_REQ_USE_DMA;
+					}
 				}
 			}
 		}
@@ -733,39 +766,68 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/*
 	 * The assumption here being that alignment is the same after
 	 * translation to device address space.
+	 *
+	 * if ADMA cannot work --> try SDMA --> else PIO
 	 */
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int broken, i;
 		struct scatterlist *sg;
 
 		broken = 0;
-		if (host->flags & SDHCI_USE_ADMA) {
+		if (dmaflags & SDHCI_USE_ADMA) {
 			/*
 			 * As we use 3 byte chunks to work around
 			 * alignment problems, we need to check this
 			 * quirk.
 			 */
 			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_SIZE)
-				broken = 1;
-		} else {
-			if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR)
-				broken = 1;
+				broken |= BROKEN_ADMA;
+			if (host->quirks & SDHCI_QUIRK_32BIT_ADMA_ADDR)
+				broken |= BROKEN_ADMA;
+		}
+		if (dmaflags & SDHCI_USE_SDMA) {
+			if (host->quirks & SDHCI_QUIRK_32BIT_SDMA_ADDR)
+				broken |= BROKEN_SDMA;
 		}
 
 		if (unlikely(broken)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->offset & 0x3) {
-					DBG("Reverting to PIO because of "
-						"bad alignment\n");
-					host->flags &= ~SDHCI_REQ_USE_DMA;
-					break;
+					if ((dmaflags & SDHCI_USE_S_ADMA) ==
+						SDHCI_USE_S_ADMA) {
+						if ((broken & BROKEN_BOTH_DMA) ==
+							BROKEN_ADMA) {
+							DBG("Reverting to SDMA "
+								"because of "
+								"bad alignment "
+								"sg_offset = %08X, "
+								"sg->length = %d\n",
+								sg->offset, sg->length);
+							dmaflags &= ~SDHCI_USE_ADMA;
+						} else {
+							DBG("Reverting to PIO "
+								"because of "
+								"bad alignment "
+								"sg_offset = %08X, "
+								"sg->length = %d\n",
+								sg->offset, sg->length);
+							host->flags &= ~SDHCI_REQ_USE_DMA;
+						}
+					} else {
+						DBG("Reverting to PIO because of "
+							"bad alignment "
+							"sg_offset = %08X, "
+							"sg->length = %d\n",
+							sg->offset, sg->length);
+						host->flags &= ~SDHCI_REQ_USE_DMA;
+					}
 				}
 			}
 		}
 	}
 
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		if (host->flags & SDHCI_USE_ADMA) {
+		if (dmaflags & SDHCI_USE_ADMA) {
 			ret = sdhci_adma_table_pre(host, data);
 			if (ret) {
 				/*
@@ -810,7 +872,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 		ctrl &= ~SDHCI_CTRL_DMA_MASK;
 		if ((host->flags & SDHCI_REQ_USE_DMA) &&
-			(host->flags & SDHCI_USE_ADMA))
+			(dmaflags & SDHCI_USE_ADMA))
 			ctrl |= SDHCI_CTRL_ADMA32;
 		else
 			ctrl |= SDHCI_CTRL_SDMA;
@@ -2260,7 +2322,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 
-	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
+	if (host->flags & SDHCI_USE_S_ADMA) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
 	}
@@ -2381,14 +2443,13 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
-	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
+	if (host->flags & SDHCI_USE_S_ADMA) {
 		if (host->ops->enable_dma) {
 			if (host->ops->enable_dma(host)) {
 				printk(KERN_WARNING "%s: No suitable DMA "
 					"available. Falling back to PIO.\n",
 					mmc_hostname(mmc));
-				host->flags &=
-					~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+				host->flags &= ~SDHCI_USE_S_ADMA;
 			}
 		}
 	}
@@ -2416,7 +2477,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * mask, but PIO does not need the hw shim so we set a new
 	 * mask here in that case.
 	 */
-	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
+	if (!(host->flags & SDHCI_USE_S_ADMA)) {
 		host->dma_mask = DMA_BIT_MASK(64);
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}
@@ -2758,6 +2819,11 @@ int sdhci_add_host(struct sdhci_host *host)
 		(host->flags & SDHCI_USE_ADMA) ? "ADMA" :
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
 
+	if ((host->flags & SDHCI_USE_S_ADMA) == SDHCI_USE_S_ADMA)
+		printk(KERN_INFO "%s: SDHCI controller on %s [%s] can also"
+		" use SDMA\n",
+		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)));
+
 	sdhci_enable_card_detection(host);
 
 	return 0;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 13c13f8..74d8cbd 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -38,7 +38,7 @@ struct sdhci_host {
 /* Controller has an unusable ADMA engine */
 #define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
 /* Controller can only DMA from 32-bit aligned addresses */
-#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
+#define SDHCI_QUIRK_32BIT_SDMA_ADDR			(1<<7)
 /* Controller can only DMA chunk sizes that are a multiple of 32 bits */
 #define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
 /* Controller can only ADMA chunks that are a multiple of 32 bits */
@@ -64,7 +64,7 @@ struct sdhci_host {
 /* Controller losing signal/interrupt enable states after reset */
 #define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 /* Reclaimed, available for use */
-#define SDHCI_QUIRK_UNUSED_20				(1<<20)
+#define SDHCI_QUIRK_32BIT_ADMA_ADDR			(1<<20)
 /* Reclaimed, available for use */
 #define SDHCI_QUIRK_UNUSED_21				(1<<21)
 /* Controller can only handle 1-bit data transfers */
@@ -87,6 +87,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
 #define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+#define SDHCI_QUIRK_32BIT_DMA_ADDR	(SDHCI_QUIRK_32BIT_SDMA_ADDR | \
+						SDHCI_QUIRK_32BIT_ADMA_ADDR)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -115,6 +117,7 @@ struct sdhci_host {
 #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
 #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
+#define SDHCI_USE_S_ADMA	(SDHCI_USE_SDMA | SDHCI_USE_ADMA)
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.0.4


