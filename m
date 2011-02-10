From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/11] sh_mmcif: rename and retype activity variable
Date: Thu, 10 Feb 2011 16:09:50 +0100
Message-ID: <1297350590-2344-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>

The host_sglen is now actually used to keep track of whether DMA
is active or not, so rename and retype it to bool.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 61ad19e..e247031 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -169,7 +169,7 @@ struct sh_mmcif_host {
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
 	struct completion	dma_complete;
-	unsigned int            dma_sglen;
+	bool			dma_active;
 };
 
 static inline void sh_mmcif_bitset(struct sh_mmcif_host *host,
@@ -216,7 +216,7 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 	ret = dma_map_sg(chan->device->dev, sg, host->data->sg_len,
 			 DMA_FROM_DEVICE);
 	if (ret > 0) {
-		host->dma_sglen = ret;
+		host->dma_active = true;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
 			DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	}
@@ -241,7 +241,7 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_rx = NULL;
-		host->dma_sglen = 0;
+		host->dma_active = false;
 		dma_release_channel(chan);
 		/* Free the Tx channel too */
 		chan = host->chan_tx;
@@ -269,7 +269,7 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 	ret = dma_map_sg(chan->device->dev, sg, host->data->sg_len,
 			 DMA_TO_DEVICE);
 	if (ret > 0) {
-		host->dma_sglen = ret;
+		host->dma_active = true;
 		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
 			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	}
@@ -294,7 +294,7 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_tx = NULL;
-		host->dma_sglen = 0;
+		host->dma_active = false;
 		dma_release_channel(chan);
 		/* Free the Rx channel too */
 		chan = host->chan_rx;
@@ -321,7 +321,7 @@ static bool sh_mmcif_filter(struct dma_chan *chan, void *arg)
 static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 				 struct sh_mmcif_plat_data *pdata)
 {
-	host->dma_sglen = 0;
+	host->dma_active = false;
 
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (pdata->dma) {
@@ -368,7 +368,7 @@ static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
 		dma_release_channel(chan);
 	}
 
-	host->dma_sglen = 0;
+	host->dma_active = false;
 }
 
 static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
@@ -757,7 +757,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	}
 	sh_mmcif_get_response(host, cmd);
 	if (host->data) {
-		if (!host->dma_sglen) {
+		if (!host->dma_active) {
 			ret = sh_mmcif_data_trans(host, mrq, cmd->opcode);
 		} else {
 			long time =
@@ -769,7 +769,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 				ret = time;
 			sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC,
 					BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
-			host->dma_sglen = 0;
+			host->dma_active = false;
 		}
 		if (ret < 0)
 			mrq->data->bytes_xfered = 0;
-- 
1.7.4

