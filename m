From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/4] mmc: omap_hsmmc: use spinlock IRQ safe variant
Date: Mon, 9 Apr 2012 12:08:34 +0530
Message-ID: <1333953515-31925-4-git-send-email-svenkatr@ti.com>
References: <1333953515-31925-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125Ab2DIGjL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Apr 2012 02:39:11 -0400
In-Reply-To: <1333953515-31925-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, Venkatraman S <svenkatr@ti.com>

Prevent possible races between HSMMC/DMA IRQs and next requests.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9e701f3..e8f296d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -806,11 +806,12 @@ omap_hsmmc_get_dma_dir(struct omap_hsmmc_host *host, struct mmc_data *data)
 static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_request *mrq)
 {
 	int dma_ch;
+	unsigned long flags;
 
-	spin_lock(&host->irq_lock);
+	spin_lock_irqsave(&host->irq_lock, flags);
 	host->req_in_progress = 0;
 	dma_ch = host->dma_ch;
-	spin_unlock(&host->irq_lock);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
@@ -887,13 +888,14 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 {
 	int dma_ch;
+	unsigned long flags;
 
 	host->data->error = errno;
 
-	spin_lock(&host->irq_lock);
+	spin_lock_irqsave(&host->irq_lock, flags);
 	dma_ch = host->dma_ch;
 	host->dma_ch = -1;
-	spin_unlock(&host->irq_lock);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 
 	if (host->use_dma && dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
@@ -1247,6 +1249,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	struct omap_hsmmc_host *host = cb_data;
 	struct mmc_data *data;
 	int dma_ch, req_in_progress;
+	unsigned long flags;
 
 	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
 		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
@@ -1254,9 +1257,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		return;
 	}
 
-	spin_lock(&host->irq_lock);
+	spin_lock_irqsave(&host->irq_lock, flags);
 	if (host->dma_ch < 0) {
-		spin_unlock(&host->irq_lock);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
 		return;
 	}
 
@@ -1266,7 +1269,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		/* Fire up the next transfer. */
 		omap_hsmmc_config_dma_params(host, data,
 					   data->sg + host->dma_sg_idx);
-		spin_unlock(&host->irq_lock);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
 		return;
 	}
 
@@ -1277,7 +1280,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	req_in_progress = host->req_in_progress;
 	dma_ch = host->dma_ch;
 	host->dma_ch = -1;
-	spin_unlock(&host->irq_lock);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 
 	omap_free_dma(dma_ch);
 
-- 
1.7.10.rc2

