From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/14] mmc: davinci: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:18 +0100
Message-ID: <20190212072528.13167-5-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/davinci_mmc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..6a16d7a1d5bc 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -194,11 +194,12 @@ struct mmc_davinci_host {
 #define DAVINCI_MMC_DATADIR_WRITE	2
 	unsigned char data_dir;
 
-	/* buffer is used during PIO of one scatterlist segment, and
-	 * is updated along with buffer_bytes_left.  bytes_left applies
-	 * to all N blocks of the PIO transfer.
+	/*
+	 * buffer_offset is used during PIO of one scatterlist segment, and is
+	 * updated along with buffer_bytes_left.  bytes_left applies to all N
+	 * blocks of the PIO transfer.
 	 */
-	u8 *buffer;
+	u32 buffer_offset;
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
@@ -229,8 +230,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +239,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	u8 *p, *base;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +247,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	base = sg_kmap_atomic(host->sg);
+	p = base + host->buffer_offset;
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -275,7 +277,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 			p = p + (n & 3);
 		}
 	}
-	host->buffer = p;
+	host->buffer_offset = p - base;
+	sg_kunmap_atomic(host->sg, base);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +575,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
@@ -1291,6 +1294,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	mmc->ops = &mmc_davinci_ops;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->need_kmap = 1;
 
 	/* With no iommu coalescing pages, each phys_seg is a hw_seg.
 	 * Each hw_seg uses one EDMA parameter RAM slot, always one
-- 
2.20.1
