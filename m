From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/11] mmc: sh_mmcif: handle highmem pages
Date: Mon, 14 Jan 2019 10:58:01 +0100
Message-ID: <20190114095804.27978-9-hch@lst.de>
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
 drivers/mmc/host/sh_mmcif.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 81bd9afb0980..0d2bbb8943f5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -228,7 +228,7 @@ struct sh_mmcif_host {
 	bool dying;
 	long timeout;
 	void __iomem *addr;
-	u32 *pio_ptr;
+	u32 pio_offset;
 	spinlock_t lock;		/* protect sh_mmcif_host::state */
 	enum sh_mmcif_state state;
 	enum sh_mmcif_wait_for wait_for;
@@ -595,7 +595,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	return ret;
 }
 
-static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
+static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 {
 	struct mmc_data *data = host->mrq->data;
 
@@ -606,10 +606,10 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len)
-			host->pio_ptr = sg_virt(++data->sg);
-	} else {
-		host->pio_ptr = p;
+		if (++host->sg_idx < data->sg_len) {
+			data->sg++;
+			host->pio_offset = data->sg->offset / 4;
+		}
 	}
 
 	return host->sg_idx != data->sg_len;
@@ -631,8 +631,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -640,8 +640,11 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = kmap_atomic(sg_page(data->sg));
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+		p[off++] = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	kunmap_atomic(p);
 
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
@@ -664,7 +667,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
@@ -673,7 +676,7 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -684,10 +687,14 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	p = kmap_atomic(sg_page(data->sg));
+	for (i = 0; i < host->blocksize / 4; i++) {
+		p[host->pio_offset++] =
+			sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	}
+	kunmap_atomic(p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -711,8 +718,8 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -720,8 +727,11 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = kmap_atomic(sg_page(data->sg));
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, p[off++]);
+	kunmap_atomic(p);
 
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
@@ -744,7 +754,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
@@ -753,7 +763,7 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -764,10 +774,14 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+	p = kmap_atomic(sg_page(data->sg));
+	for (i = 0; i < host->blocksize / 4; i++) {
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA,
+				p[host->pio_offset++]);
+	}
+	kunmap_atomic(p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
-- 
2.20.1
