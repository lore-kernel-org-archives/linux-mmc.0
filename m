From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCHv2 01/12] mmci: use sg_miter API to fix multi-page sg handling
Date: Mon, 19 Jul 2010 18:53:10 +0530
Message-ID: <1279545790-15658-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:51787 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932376Ab0GSNX3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jul 2010 09:23:29 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, Rabin Vincent <rabin.vincent@stericsson.com>

The mmci driver's SG list iteration logic assumes that each SG entry
spans only one page, and only maps and flushes one page of the sg.  This
is not a valid assumption.  Fix it by converting the driver to the
sg_miter API, which correctly handles sgs which span multiple pages.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
v2:
 - Keep the flush_dcache_page() inside the driver, since the
   flush_kernel_dcache_page() call inside the sg_miter API is inadequate

 drivers/mmc/host/mmci.c |   60 +++++++++++++++++++++++++++++-----------------
 drivers/mmc/host/mmci.h |   35 +--------------------------
 2 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4917af9..d63d756 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -26,7 +26,6 @@
 #include <linux/amba/mmci.h>
 #include <linux/regulator/consumer.h>
 
-#include <asm/cacheflush.h>
 #include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -98,6 +97,18 @@ static void mmci_stop_data(struct mmci_host *host)
 	host->data = NULL;
 }
 
+static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
+{
+	unsigned int flags = SG_MITER_ATOMIC;
+
+	if (data->flags & MMC_DATA_READ)
+		flags |= SG_MITER_TO_SG;
+	else
+		flags |= SG_MITER_FROM_SG;
+
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	unsigned int datactrl, timeout, irqmask;
@@ -210,8 +221,17 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 * We hit an error condition.  Ensure that any data
 		 * partially written to a page is properly coherent.
 		 */
-		if (host->sg_len && data->flags & MMC_DATA_READ)
-			flush_dcache_page(sg_page(host->sg_ptr));
+		if (data->flags & MMC_DATA_READ) {
+			struct sg_mapping_iter *sg_miter = &host->sg_miter;
+			unsigned long flags;
+
+			local_irq_save(flags);
+			if (sg_miter_next(sg_miter)) {
+				flush_dcache_page(sg_miter->page);
+				sg_miter_stop(sg_miter);
+			}
+			local_irq_restore(flags);
+		}
 	}
 	if (status & MCI_DATAEND) {
 		mmci_stop_data(host);
@@ -314,15 +334,18 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
 	void __iomem *base = host->base;
+	unsigned long flags;
 	u32 status;
 
 	status = readl(base + MMCISTATUS);
 
 	dev_dbg(mmc_dev(host->mmc), "irq1 (pio) %08x\n", status);
 
+	local_irq_save(flags);
+
 	do {
-		unsigned long flags;
 		unsigned int remain, len;
 		char *buffer;
 
@@ -336,11 +359,11 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (!(status & (MCI_TXFIFOHALFEMPTY|MCI_RXDATAAVLBL)))
 			break;
 
-		/*
-		 * Map the current scatter buffer.
-		 */
-		buffer = mmci_kmap_atomic(host, &flags) + host->sg_off;
-		remain = host->sg_ptr->length - host->sg_off;
+		if (!sg_miter_next(sg_miter))
+			break;
+
+		buffer = sg_miter->addr;
+		remain = sg_miter->length;
 
 		len = 0;
 		if (status & MCI_RXACTIVE)
@@ -348,31 +371,24 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (status & MCI_TXACTIVE)
 			len = mmci_pio_write(host, buffer, remain, status);
 
-		/*
-		 * Unmap the buffer.
-		 */
-		mmci_kunmap_atomic(host, buffer, &flags);
+		sg_miter->consumed = len;
 
-		host->sg_off += len;
 		host->size -= len;
 		remain -= len;
 
 		if (remain)
 			break;
 
-		/*
-		 * If we were reading, and we have completed this
-		 * page, ensure that the data cache is coherent.
-		 */
 		if (status & MCI_RXACTIVE)
-			flush_dcache_page(sg_page(host->sg_ptr));
-
-		if (!mmci_next_sg(host))
-			break;
+			flush_dcache_page(sg_miter->page);
 
 		status = readl(base + MMCISTATUS);
 	} while (1);
 
+	sg_miter_stop(sg_miter);
+
+	local_irq_restore(flags);
+
 	/*
 	 * If we're nearing the end of the read, switch to
 	 * "any data available" mode.
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d77062e..7cb24ab 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -171,42 +171,9 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
-	unsigned int		sg_len;
-
 	/* pio stuff */
-	struct scatterlist	*sg_ptr;
-	unsigned int		sg_off;
+	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
 	struct regulator	*vcc;
 };
 
-static inline void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
-{
-	/*
-	 * Ideally, we want the higher levels to pass us a scatter list.
-	 */
-	host->sg_len = data->sg_len;
-	host->sg_ptr = data->sg;
-	host->sg_off = 0;
-}
-
-static inline int mmci_next_sg(struct mmci_host *host)
-{
-	host->sg_ptr++;
-	host->sg_off = 0;
-	return --host->sg_len;
-}
-
-static inline char *mmci_kmap_atomic(struct mmci_host *host, unsigned long *flags)
-{
-	struct scatterlist *sg = host->sg_ptr;
-
-	local_irq_save(*flags);
-	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
-}
-
-static inline void mmci_kunmap_atomic(struct mmci_host *host, void *buffer, unsigned long *flags)
-{
-	kunmap_atomic(buffer, KM_BIO_SRC_IRQ);
-	local_irq_restore(*flags);
-}
-- 
1.7.0

