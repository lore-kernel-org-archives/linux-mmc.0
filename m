From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] mmc: mxcmmc: add DMA SG synchronisation
Date: Fri, 31 Jan 2014 12:54:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1401311249390.3234@axis700.grange>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52992 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaAaLyy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Jan 2014 06:54:54 -0500
In-Reply-To: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

According to the DMA API data has to be synchronised before starting
a DMA transfer to device and after completing a DMA transfer from device.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/mxcmmc.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index f7199c8..31dfc7b 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -326,6 +326,7 @@ static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
 
 static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 {
+	struct device *dev = host->dma->device->dev;
 	unsigned int nob = data->blocks;
 	unsigned int blksz = data->blksz;
 	unsigned int datasize = nob * blksz;
@@ -363,18 +364,20 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		mxcmci_swap_buffers(data);
 	}
 
-	nents = dma_map_sg(host->dma->device->dev, data->sg,
-				     data->sg_len,  host->dma_dir);
+	nents = dma_map_sg(dev, data->sg, data->sg_len,  host->dma_dir);
 	if (nents != data->sg_len)
 		return -EINVAL;
 
+	if (data->flags & MMC_DATA_WRITE)
+		dma_sync_sg_for_device(dev, data->sg, data->sg_len,
+				       host->dma_dir);
+
 	host->desc = dmaengine_prep_slave_sg(host->dma,
 		data->sg, data->sg_len, slave_dirn,
 		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!host->desc) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
-				host->dma_dir);
+		dma_unmap_sg(dev, data->sg, data->sg_len, host->dma_dir);
 		host->do_dma = 0;
 		return 0; /* Fall back to PIO */
 	}
@@ -487,8 +490,11 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	int data_error;
 
 	if (mxcmci_use_dma(host)) {
-		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
-				host->dma_dir);
+		struct device *dev = host->dma->device->dev;
+		dma_unmap_sg(dev, data->sg, data->sg_len, host->dma_dir);
+		if (host->dma_dir == DMA_FROM_DEVICE)
+			dma_sync_sg_for_cpu(dev, data->sg, data->sg_len,
+					    host->dma_dir);
 		mxcmci_swap_buffers(data);
 	}
 
-- 
1.7.2.5

