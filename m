From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/14] mmc: mvsdio: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:24 +0100
Message-ID: <20190212072528.13167-11-hch@lst.de>
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
 drivers/mmc/host/mvsdio.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff89c8d..d04c78125a4d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -42,7 +42,8 @@ struct mvsd_host {
 	unsigned int intr_en;
 	unsigned int ctrl;
 	unsigned int pio_size;
-	void *pio_ptr;
+	struct scatterlist *pio_sg;
+	unsigned int pio_offset; /* offset in words into the segment */
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -96,9 +97,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
 		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
 
-	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
+	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
 		(data->flags & MMC_DATA_READ) ? "read" : "write",
-		(u32)sg_virt(data->sg), data->blocks, data->blksz,
+		(u64)sg_phys(data->sg), data->blocks, data->blksz,
 		tmout, tmout_index);
 
 	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
@@ -118,10 +119,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		 * boundary.
 		 */
 		host->pio_size = data->blocks * data->blksz;
-		host->pio_ptr = sg_virt(data->sg);
+		host->pio_sg = data->sg;
+		host->pio_offset = data->sg->offset / 2;
 		if (!nodma)
-			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
-				host->pio_ptr, host->pio_size);
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
+				host->pio_offset, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -291,8 +293,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 {
 	void __iomem *iobase = host->base;
 
-	if (host->pio_ptr) {
-		host->pio_ptr = NULL;
+	if (host->pio_sg) {
+		host->pio_sg = NULL;
+		host->pio_offset = 0;
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
@@ -376,8 +379,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
+
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
 			readsw(iobase + MVSD_FIFO, p, 16);
 			p += 16;
@@ -416,13 +421,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
@@ -453,8 +460,9 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	}
 
@@ -737,6 +745,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	clk_prepare_enable(host->clk);
 
 	mmc->ops = &mvsd_ops;
+	mmc->need_kmap = 1;
 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-- 
2.20.1
