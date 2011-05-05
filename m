From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 05/22] mmc: omap_hsmmc: fix dma sglist use
Date: Thu,  5 May 2011 14:51:05 +0300
Message-ID: <1304596282-4095-6-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:46887 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab1EELvv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:51:51 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>, Venkatraman S <svenkatr@ti.com>, Shilimkar Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Allow for the super block end event used by sglist
DMA transfers and tidy the detection of the DMA
sglist feature.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
CC: Venkatraman S <svenkatr@ti.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ebcef31..114cd68 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1333,7 +1333,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	struct mmc_data *data = host->mrq->data;
 	int dma_ch, req_in_progress;
 
-	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
+	if (!(ch_status & (OMAP_DMA_BLOCK_IRQ | OMAP2_DMA_SUPER_BLOCK_IRQ))) {
 		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
 			ch_status);
 		return;
@@ -2230,7 +2230,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 							" clk failed\n");
 	}
 
-	if (cpu_is_omap44xx() || cpu_is_omap3630()) {
+	if (omap_dma_has_sglist_mode()) {
 		host->dma_ctrl_buf = dma_alloc_coherent(NULL,
 					DMA_CTRL_BUF_SIZE,
 					&host->dma_ctrl_buf_phy,
-- 
1.7.0.4

