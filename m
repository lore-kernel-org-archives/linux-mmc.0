From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/14] mmc: omap: handle highmem pages
Date: Tue, 12 Feb 2019 08:25:20 +0100
Message-ID: <20190212072528.13167-7-hch@lst.de>
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
 drivers/mmc/host/omap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c60a7625b1fa..6741c95f2281 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -148,7 +148,7 @@ struct mmc_omap_host {
 
 	unsigned int		sg_len;
 	int			sg_idx;
-	u16 *			buffer;
+	u32			buffer_offset;
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
 
@@ -649,7 +649,7 @@ mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 
 	sg = host->data->sg + host->sg_idx;
 	host->buffer_bytes_left = sg->length;
-	host->buffer = sg_virt(sg);
+	host->buffer_offset = sg->offset;
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -666,7 +666,9 @@ mmc_omap_clk_timer(struct timer_list *t)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
+	struct scatterlist *sg = host->data->sg + host->sg_idx;
 	int n, nwords;
+	void *p;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -684,15 +686,17 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	host->total_bytes_left -= n;
 	host->data->bytes_xfered += n;
 
+	p = sg_kmap_atomic(sg);
 	if (write) {
 		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			      host->buffer, nwords);
+			      p + host->buffer_offset, nwords);
 	} else {
 		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			     host->buffer, nwords);
+			     p + host->buffer_offset, nwords);
 	}
+	sg_kunmap_atomic(sg, p);
 
-	host->buffer += nwords;
+	host->buffer_offset += nwords;
 }
 
 #ifdef CONFIG_MMC_DEBUG
@@ -1250,6 +1254,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_ERASE;
 
 	mmc->ops = &mmc_omap_ops;
+	mmc->need_kmap = 1;
 	mmc->f_min = 400000;
 
 	if (mmc_omap2())
-- 
2.20.1
