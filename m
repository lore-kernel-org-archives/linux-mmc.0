From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/11] mmc: davinci: handle highmem pages
Date: Mon, 14 Jan 2019 10:57:54 +0100
Message-ID: <20190114095804.27978-2-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/davinci_mmc.c | 43 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..9c500c52b63d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -194,11 +195,12 @@ struct mmc_davinci_host {
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
 
@@ -229,8 +231,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +240,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	void *p;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +248,7 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	p = kmap_atomic(sg_page(host->sg));
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -258,24 +260,31 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 	 */
 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
 		for (i = 0; i < (n >> 2); i++) {
-			writel(*((u32 *)p), host->base + DAVINCI_MMCDXR);
-			p = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			writel(*val, host->base + DAVINCI_MMCDXR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			iowrite8_rep(host->base + DAVINCI_MMCDXR, p, (n & 3));
-			p = p + (n & 3);
+			iowrite8_rep(host->base + DAVINCI_MMCDXR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	} else {
 		for (i = 0; i < (n >> 2); i++) {
-			*((u32 *)p) = readl(host->base + DAVINCI_MMCDRR);
-			p  = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			*val = readl(host->base + DAVINCI_MMCDRR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			ioread8_rep(host->base + DAVINCI_MMCDRR, p, (n & 3));
-			p = p + (n & 3);
+			ioread8_rep(host->base + DAVINCI_MMCDRR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	}
-	host->buffer = p;
+
+	kunmap_atomic(p);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +581,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
-- 
2.20.1
