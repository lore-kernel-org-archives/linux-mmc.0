From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: use packet sync'd DMA
Date: Wed, 10 Feb 2010 11:51:58 +0000
Message-ID: <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43021 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab0BJLw6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2010 06:52:58 -0500
In-Reply-To: <cover.1265801967.git.david.vrabel@csr.com>
In-Reply-To: <cover.1265801967.git.david.vrabel@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: David Vrabel <david.vrabel@csr.com>, linux-omap@vger.kernel.org, madhu.cr@ti.com

Use packet sync'd DMA in the omap_hsmmc driver to avoid the
restriction that transfers must be a multiple of the block size.  This
is required for byte-mode transfers to SDIO cards.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/host/omap_hsmmc.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b23225..e7142a2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -114,6 +114,7 @@
 
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
+#define OMAP_HSMMC_FIFO_WORDS	(512/4)
 #define DRIVER_NAME		"mmci-omap-hs"
 
 /* Timeouts for entering power saving states on inactivity, msec */
@@ -887,12 +888,12 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
 	dma_ch = host->dma_ch;
 	if (data->flags & MMC_DATA_WRITE) {
 		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+			(host->mapbase + OMAP_HSMMC_DATA), 0, OMAP_HSMMC_FIFO_WORDS);
 		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
 			sg_dma_address(sgl), 0, 0);
 	} else {
 		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+			(host->mapbase + OMAP_HSMMC_DATA), 0, OMAP_HSMMC_FIFO_WORDS);
 		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
 			sg_dma_address(sgl), 0, 0);
 	}
@@ -901,7 +902,7 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
 	nblk = sg_dma_len(sgl) / blksz;
 
 	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
-			blksz / 4, nblk, OMAP_DMA_SYNC_FRAME,
+			blksz / 4, nblk, OMAP_DMA_SYNC_PACKET,
 			omap_hsmmc_get_dma_sync_dev(host, data),
 			!(data->flags & MMC_DATA_WRITE));
 
@@ -944,17 +945,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *data)
 static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	int dma_ch = 0, ret = 0, err = 1, i;
+	int dma_ch = 0, ret = 0, err = 1;
 	struct mmc_data *data = req->data;
 
-	/* Sanity check: all the SG entries must be aligned by block size. */
-	for (i = 0; i < data->sg_len; i++) {
-		struct scatterlist *sgl;
-
-		sgl = data->sg + i;
-		if (sgl->length % data->blksz)
-			return -EINVAL;
-	}
 	if ((data->blksz % 4) != 0)
 		/* REVISIT: The MMC buffer increments only when MSB is written.
 		 * Return error for blksz which is non multiple of four.
-- 
1.6.3.3

