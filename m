From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/14] mmc: s3cmci: handle chained sglists
Date: Tue, 12 Feb 2019 08:25:23 +0100
Message-ID: <20190212072528.13167-10-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/s3cmci.c | 19 +++++++++----------
 drivers/mmc/host/s3cmci.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 989fefea19f1..df7c27f78abf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -319,20 +319,19 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 
 static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	if (host->pio_sgptr >= host->mrq->data->sg_len) {
-		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
-		      host->pio_sgptr, host->mrq->data->sg_len);
+	if (!host->next_sg) {
+		dbg(host, dbg_debug, "no more buffers (%i)\n",
+		      host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->next_sg;
+	host->next_sg = sg_next(host->next_sg);
 
 	host->pio_bytes = host->cur_sg->length;
 	host->pio_offset = host->cur_sg->offset;
 
-	host->pio_sgptr++;
-
-	dbg(host, dbg_sg, "new buffer (%i/%i)\n",
-	    host->pio_sgptr, host->mrq->data->sg_len);
+	dbg(host, dbg_sg, "new buffer (%i)\n",
+	    host->mrq->data->sg_len);
 
 	return 0;
 }
@@ -1051,8 +1050,8 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	host->pio_sgptr = 0;
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->mrq->data->sg;
+	host->next_sg = sg_next(host->cur_sg);
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 4320f7d832dc..caf1078d07d1 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -51,7 +51,7 @@ struct s3cmci_host {
 	int			dma_complete;
 
 	struct scatterlist	*cur_sg;
-	u32			pio_sgptr;
+	struct scatterlist	*next_sg;
 	u32			pio_bytes;
 	u32			pio_count;
 	u32			pio_offset;
-- 
2.20.1
