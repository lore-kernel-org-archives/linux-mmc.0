From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] omap hsmmc: fix processing of all dma interrupts as block completion
Date: Tue, 13 Jul 2010 21:59:48 +0530
Message-ID: <1279038588-16943-1-git-send-email-svenkatr@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab0GMQ1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2010 12:27:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
Cc: Venkatraman S <svenkatr@ti.com>

	If other informative DMA interrupts are enabled
	for the channel used by hsmmc, those are incorrectly
	treated as block completion. This patch	lets only
	the block completion interrupt to be processed.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..d2901f8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1273,8 +1273,11 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	struct mmc_data *data = host->mrq->data;
 	int dma_ch, req_in_progress;
 
-	if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
-		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");
+	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
+		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
+			ch_status);
+		return;
+	}
 
 	spin_lock(&host->irq_lock);
 	if (host->dma_ch < 0) {
-- 
1.6.3.3

