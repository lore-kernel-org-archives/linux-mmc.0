From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] mmc: sdhci: combined dma buffer support for sdma
Date: Mon, 23 Dec 2013 21:22:03 +0800
Message-ID: <1387804924-3372-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61374 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab3LWNWi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 08:22:38 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so5262631pab.6
        for <linux-mmc@vger.kernel.org>; Mon, 23 Dec 2013 05:22:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>, Barry Song <Barry.Song@csr.com>

From: Bin Shi <Bin.Shi@csr.com>

Since some SD host controller has just sdma scheme, no adma for
sd/mmc/sdio host, in current sdhci driver, sdma just enable max_segs
be 1, so all the sg list length will be 1 and host driver will
handler each one by one with lots of cost in request/cmd_done/
irq_handler/tasklet_handler, which make worse read/write performance.

A better solution is copy sg data to pre-defined dma coherent buffer
and write to sd, or copy data from dma buffer to sg data and let high
layer core to access. So we define quirks2
SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER to distinglish with
normal dma mapping.

Also this will involve one more memory copy, but good IO performance
is got:
On CSR SiRFprimaII, reading 8192KB will speed up from 17444KB/s to
18687KB/s, 7% lift.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 drivers/mmc/host/sdhci.c  |   98 ++++++++++++++++++++++++++++++++++++---------
 include/linux/mmc/sdhci.h |    5 ++
 2 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..aac92bd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -726,6 +726,40 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
 }
 
+static inline void sdhci_sg_to_dma(struct sdhci_host *host, struct mmc_data *data)
+{
+        unsigned int len, i;
+        struct scatterlist *sg;
+        void *dmabuf = host->combined_dma_buffer;
+        void *sgbuf;
+
+        sg = data->sg;
+        len = data->sg_len;
+
+        for (i = 0; i < len; i++) {
+                sgbuf = sg_virt(&sg[i]);
+                memcpy(dmabuf, sgbuf, sg[i].length);
+                dmabuf += sg[i].length;
+        }
+}
+
+static inline void sdhci_dma_to_sg(struct sdhci_host *host, struct mmc_data *data)
+{
+        unsigned int len, i;
+        struct scatterlist *sg;
+        void *dmabuf = host->combined_dma_buffer;
+        void *sgbuf;
+
+        sg = data->sg;
+        len = data->sg_len;
+
+        for (i = 0; i < len; i++) {
+                sgbuf = sg_virt(&sg[i]);
+                memcpy(sgbuf, dmabuf, sg[i].length);
+                dmabuf += sg[i].length;
+        }
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -836,22 +870,34 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		} else {
 			int sg_cnt;
 
-			sg_cnt = dma_map_sg(mmc_dev(host->mmc),
-					data->sg, data->sg_len,
-					(data->flags & MMC_DATA_READ) ?
-						DMA_FROM_DEVICE :
-						DMA_TO_DEVICE);
-			if (sg_cnt == 0) {
-				/*
-				 * This only happens when someone fed
-				 * us an invalid request.
-				 */
-				WARN_ON(1);
-				host->flags &= ~SDHCI_REQ_USE_DMA;
-			} else {
-				WARN_ON(sg_cnt != 1);
-				sdhci_writel(host, sg_dma_address(data->sg),
+			/*
+			 * Transfer data from the SG list to
+			 * the DMA buffer.
+			 */
+			if (host->quirks2 & SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER) {
+				if (data->flags & MMC_DATA_WRITE)
+					sdhci_sg_to_dma(host, data);
+				sdhci_writel(host, host->combined_dma_addr,
 					SDHCI_DMA_ADDRESS);
+			} else {
+
+				sg_cnt = dma_map_sg(mmc_dev(host->mmc),
+						data->sg, data->sg_len,
+						(data->flags & MMC_DATA_READ) ?
+							DMA_FROM_DEVICE :
+							DMA_TO_DEVICE);
+				if (sg_cnt == 0) {
+					/*
+					 * This only happens when someone fed
+					 * us an invalid request.
+					 */
+					WARN_ON(1);
+					host->flags &= ~SDHCI_REQ_USE_DMA;
+				} else {
+					WARN_ON(sg_cnt != 1);
+						sdhci_writel(host, sg_dma_address(data->sg),
+							SDHCI_DMA_ADDRESS);
+				}
 			}
 		}
 	}
@@ -939,9 +985,11 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		if (host->flags & SDHCI_USE_ADMA)
 			sdhci_adma_table_post(host, data);
 		else {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-				data->sg_len, (data->flags & MMC_DATA_READ) ?
-					DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			if (!(host->quirks2 & SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER)) {
+				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+					data->sg_len, (data->flags & MMC_DATA_READ) ?
+						DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			}
 		}
 	}
 
@@ -2147,6 +2195,15 @@ static void sdhci_tasklet_finish(unsigned long param)
 	mrq = host->mrq;
 
 	/*
+	 * Transfer data from DMA buffer to
+	 * SG list.
+	 */
+	if ((host->quirks2 & SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER) &&
+		mrq->data && (mrq->data->flags & MMC_DATA_READ))
+			if (host->flags & SDHCI_REQ_USE_DMA)
+				sdhci_dma_to_sg(host, mrq->data);
+
+	/*
 	 * The controller needs a reset of internal state machines
 	 * upon error conditions.
 	 */
@@ -3152,7 +3209,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->flags & SDHCI_USE_ADMA)
 		mmc->max_segs = 128;
 	else if (host->flags & SDHCI_USE_SDMA)
-		mmc->max_segs = 1;
+		if (host->quirks2 & SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER)
+			mmc->max_segs = 128;
+		else
+			mmc->max_segs = 1;
 	else /* PIO */
 		mmc->max_segs = 128;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 3e781b8..c2fc13f 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+/* For better performance for SDMA controller, alloc a buffer to combine */
+#define SDHCI_QUIRK2_SG_LIST_COMBINED_DMA_BUFFER	(1<<6)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -160,6 +162,9 @@ struct sdhci_host {
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
+	dma_addr_t combined_dma_addr;	/* combined dma buffer */
+	void *combined_dma_buffer;/* Mapped combined dma buffer */
+
 	struct tasklet_struct card_tasklet;	/* Tasklet structures */
 	struct tasklet_struct finish_tasklet;
 
-- 
1.7.5.4

