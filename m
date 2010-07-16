From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2] omap hsmmc: fix processing of all dma interrupts as block completion
Date: Fri, 16 Jul 2010 14:51:02 +0530
Message-ID: <1279272062-9068-1-git-send-email-svenkatr@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936134Ab0GPJTZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Jul 2010 05:19:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Venkatraman S <svenkatr@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>

If other informative interrupts are enabled for
the DMA channel used by hsmmc, those are incorrectly
treated as block completion. This patch lets only the
block completion interrupt to be processed.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC: Madhusudhan Chikkature <madhu.cr@ti.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 Changes since v1: better commit log message

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

