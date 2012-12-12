From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 08/14] mmc: sh-mmcif: Terminate DMA transactions when detecting timeout or error
Date: Wed, 12 Dec 2012 15:38:12 +0100
Message-ID: <1355323098-18061-9-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
List-Id: linux-mmc@vger.kernel.org

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

If a DMA transaction fails, terminate all outstanding DMA transfers and
unmap buffers.

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
[g.liakhovetski@gmx.de: forward-port, add dma_unmap_sg() in error cases]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ac4c3c3..d8d65c0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -263,15 +263,6 @@ static void mmcif_dma_complete(void *arg)
 		 dev_name(&host->pd->dev)))
 		return;
 
-	if (data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_FROM_DEVICE);
-	else
-		dma_unmap_sg(host->chan_tx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_TO_DEVICE);
-
 	complete(&host->dma_complete);
 }
 
@@ -1088,14 +1079,20 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 	/* Running in the IRQ thread, can sleep */
 	time = wait_for_completion_interruptible_timeout(&host->dma_complete,
 							 host->timeout);
+
+	if (data->flags & MMC_DATA_READ)
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     data->sg, data->sg_len,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     data->sg, data->sg_len,
+			     DMA_TO_DEVICE);
+
 	if (host->sd_error) {
 		dev_err(host->mmc->parent,
 			"Error IRQ while waiting for DMA completion!\n");
 		/* Woken up by an error IRQ: abort DMA */
-		if (data->flags & MMC_DATA_READ)
-			dmaengine_terminate_all(host->chan_rx);
-		else
-			dmaengine_terminate_all(host->chan_tx);
 		data->error = sh_mmcif_error_manage(host);
 	} else if (!time) {
 		data->error = -ETIMEDOUT;
@@ -1106,8 +1103,14 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 			BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
 	host->dma_active = false;
 
-	if (data->error)
+	if (data->error) {
 		data->bytes_xfered = 0;
+		/* Abort DMA */
+		if (data->flags & MMC_DATA_READ)
+			dmaengine_terminate_all(host->chan_rx);
+		else
+			dmaengine_terminate_all(host->chan_tx);
+	}
 
 	return false;
 }
-- 
1.7.2.5

