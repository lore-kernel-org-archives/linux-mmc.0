From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/14] mmc: sh_mmcif: handle chained sglists
Date: Tue, 12 Feb 2019 08:25:26 +0100
Message-ID: <20190212072528.13167-13-hch@lst.de>
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
 drivers/mmc/host/sh_mmcif.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 24c3f13bafdb..9e59dbe6ef30 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -234,7 +234,6 @@ struct sh_mmcif_host {
 	enum sh_mmcif_wait_for wait_for;
 	struct delayed_work timeout_work;
 	size_t blocksize;
-	int sg_idx;
 	int sg_blkidx;
 	bool power;
 	bool ccs_enable;		/* Command Completion Signal support */
@@ -606,13 +605,13 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len) {
-			data->sg++;
-			host->pio_offset = data->sg->offset / 4;
-		}
+		data->sg = sg_next(data->sg);
+		if (!data->sg)
+			return false;
+		host->pio_offset = data->sg->offset / 4;
 	}
 
-	return host->sg_idx != data->sg_len;
+	return true;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -665,7 +664,6 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
@@ -752,7 +750,6 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
-- 
2.20.1
