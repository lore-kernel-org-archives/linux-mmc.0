From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/14] mmc: s3cmci: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:22 +0100
Message-ID: <20190212072528.13167-9-hch@lst.de>
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
 drivers/mmc/host/s3cmci.c | 107 +++++++++++++++++++-------------------
 drivers/mmc/host/s3cmci.h |   3 +-
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 10f5219b3b40..989fefea19f1 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -317,26 +317,17 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 	}
 }
 
-static inline int get_data_buffer(struct s3cmci_host *host,
-				  u32 *bytes, u32 **pointer)
+static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	struct scatterlist *sg;
-
-	if (host->pio_active == XFER_NONE)
-		return -EINVAL;
-
-	if ((!host->mrq) || (!host->mrq->data))
-		return -EINVAL;
-
 	if (host->pio_sgptr >= host->mrq->data->sg_len) {
 		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
 		      host->pio_sgptr, host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 
-	*bytes = sg->length;
-	*pointer = sg_virt(sg);
+	host->pio_bytes = host->cur_sg->length;
+	host->pio_offset = host->cur_sg->offset;
 
 	host->pio_sgptr++;
 
@@ -422,11 +413,16 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
 
 static void do_pio_read(struct s3cmci_host *host)
 {
-	int res;
 	u32 fifo;
 	u32 *ptr;
 	u32 fifo_words;
 	void __iomem *from_ptr;
+	void *buf;
+
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
 
 	/* write real prescaler to host, it might be set slow to fix */
 	writel(host->prescaler, host->base + S3C2410_SDIPRE);
@@ -435,20 +431,12 @@ static void do_pio_read(struct s3cmci_host *host)
 
 	while ((fifo = fifo_count(host))) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-					      &host->pio_ptr);
-			if (res) {
-				host->pio_active = XFER_NONE;
-				host->complete_what = COMPLETION_FINALIZE;
-
-				dbg(host, dbg_pio, "pio_read(): "
-				    "complete (no more data).\n");
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_read(): new target: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_read(): new target: [%i]@[%zu]\n",
+			    host->pio_bytes, host->pio_offset);
 		}
 
 		dbg(host, dbg_pio,
@@ -470,63 +458,65 @@ static void do_pio_read(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo_words = fifo >> 2;
-		ptr = host->pio_ptr;
-		while (fifo_words--)
+
+		buf = (sg_kmap_atomic(host->cur_sg) + host->pio_offset);
+		ptr = buf;
+		while (fifo_words--) {
 			*ptr++ = readl(from_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
 
 		if (fifo & 3) {
 			u32 n = fifo & 3;
 			u32 data = readl(from_ptr);
-			u8 *p = (u8 *)host->pio_ptr;
+			u8 *p = (u8 *)ptr;
 
 			while (n--) {
 				*p++ = data;
 				data >>= 8;
+				host->pio_offset++;
 			}
 		}
+		sg_kunmap_atomic(host->cur_sg, buf);
 	}
 
 	if (!host->pio_bytes) {
-		res = get_data_buffer(host, &host->pio_bytes, &host->pio_ptr);
-		if (res) {
-			dbg(host, dbg_pio,
-			    "pio_read(): complete (no more buffers).\n");
-			host->pio_active = XFER_NONE;
-			host->complete_what = COMPLETION_FINALIZE;
-
-			return;
-		}
+		if (get_data_buffer(host) < 0)
+			goto done;
 	}
 
 	enable_imask(host,
 		     S3C2410_SDIIMSK_RXFIFOHALF | S3C2410_SDIIMSK_RXFIFOLAST);
+	return;
+
+done:
+	host->pio_active = XFER_NONE;
+	host->complete_what = COMPLETION_FINALIZE;
+	dbg(host, dbg_pio, "pio_read(): complete (no more data).\n");
 }
 
 static void do_pio_write(struct s3cmci_host *host)
 {
 	void __iomem *to_ptr;
-	int res;
+	void *buf;
 	u32 fifo;
 	u32 *ptr;
 
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
+
 	to_ptr = host->base + host->sdidata;
 
 	while ((fifo = fifo_free(host)) > 3) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-							&host->pio_ptr);
-			if (res) {
-				dbg(host, dbg_pio,
-				    "pio_write(): complete (no more data).\n");
-				host->pio_active = XFER_NONE;
-
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_write(): new source: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_write(): new source: [%i]@[%zd]\n",
+			    host->pio_bytes, host->pio_offset);
 
 		}
 
@@ -543,13 +533,20 @@ static void do_pio_write(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo = (fifo + 3) >> 2;
-		ptr = host->pio_ptr;
-		while (fifo--)
+		buf = (sg_kmap_atomic(host->cur_sg) + host->pio_offset);
+		ptr = buf;
+		while (fifo--) {
 			writel(*ptr++, to_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
+		sg_kunmap_atomic(host->cur_sg, buf);
 	}
 
 	enable_imask(host, S3C2410_SDIIMSK_TXFIFOHALF);
+	return;
+done:
+	dbg(host, dbg_pio, "pio_write(): complete (no more data).\n");
+	host->pio_active = XFER_NONE;
 }
 
 static void pio_tasklet(unsigned long data)
@@ -1055,6 +1052,7 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
 	host->pio_sgptr = 0;
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
@@ -1678,6 +1676,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	host->clk_rate = clk_get_rate(host->clk);
 
 	mmc->ops 	= &s3cmci_ops;
+	mmc->need_kmap	= 1;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
 #ifdef CONFIG_MMC_S3C_HW_SDIO_IRQ
 	mmc->caps	= MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..4320f7d832dc 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -50,10 +50,11 @@ struct s3cmci_host {
 
 	int			dma_complete;
 
+	struct scatterlist	*cur_sg;
 	u32			pio_sgptr;
 	u32			pio_bytes;
 	u32			pio_count;
-	u32			*pio_ptr;
+	u32			pio_offset;
 #define XFER_NONE 0
 #define XFER_READ 1
 #define XFER_WRITE 2
-- 
2.20.1
