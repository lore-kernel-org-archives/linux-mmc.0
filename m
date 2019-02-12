From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/14] mmc: omap: handle chained sglists
Date: Tue, 12 Feb 2019 08:25:21 +0100
Message-ID: <20190212072528.13167-8-hch@lst.de>
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
 drivers/mmc/host/omap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 6741c95f2281..8cd39bc087fa 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -147,7 +147,7 @@ struct mmc_omap_host {
 	struct mmc_data		*stop_data;
 
 	unsigned int		sg_len;
-	int			sg_idx;
+	struct scatterlist	*cur_sg;
 	u32			buffer_offset;
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
@@ -645,11 +645,8 @@ mmc_omap_cmd_timer(struct timer_list *t)
 static void
 mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 {
-	struct scatterlist *sg;
-
-	sg = host->data->sg + host->sg_idx;
-	host->buffer_bytes_left = sg->length;
-	host->buffer_offset = sg->offset;
+	host->buffer_bytes_left = host->cur_sg->length;
+	host->buffer_offset = host->cur_sg->offset;
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -666,13 +663,12 @@ mmc_omap_clk_timer(struct timer_list *t)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
-	struct scatterlist *sg = host->data->sg + host->sg_idx;
+	struct scatterlist *sg = host->cur_sg;
 	int n, nwords;
 	void *p;
 
 	if (host->buffer_bytes_left == 0) {
-		host->sg_idx++;
-		BUG_ON(host->sg_idx == host->sg_len);
+		host->cur_sg = sg_next(host->cur_sg);
 		mmc_omap_sg_to_buf(host);
 	}
 	n = 64;
@@ -984,7 +980,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		}
 	}
 
-	host->sg_idx = 0;
+	host->cur_sg = host->data->sg;
 	if (use_dma) {
 		enum dma_data_direction dma_data_dir;
 		struct dma_async_tx_descriptor *tx;
-- 
2.20.1
