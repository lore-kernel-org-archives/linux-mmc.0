From: akpm@linux-foundation.org
Subject: [patch 048/177] omap hsmmc: fix processing of all dma interrupts as block completion
Date: Tue, 10 Aug 2010 18:01:54 -0700
Message-ID: <201008110101.o7B11sTA027090@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236Ab0HKBC3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:02:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, svenkatr@ti.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Venkatraman S <svenkatr@ti.com>

If other informative interrupts are enabled for the DMA channel used by
hsmmc, those are incorrectly treated as block completion.  This patch lets
only the block completion interrupt to be processed.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-processing-of-all-dma-interrupts-as-block-completion drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap-hsmmc-fix-processing-of-all-dma-interrupts-as-block-completion
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -1273,8 +1273,11 @@ static void omap_hsmmc_dma_cb(int lch, u
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
_
