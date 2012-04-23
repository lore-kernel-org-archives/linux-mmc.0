From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 01/12] ARM: OMAP: fix DMA vs memory ordering
Date: Mon, 23 Apr 2012 17:04:30 +0100
Message-ID: <E1SMLkc-0002W0-Bn@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41409 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2DWQEk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 12:04:40 -0400
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Using coherent DMA memory with the OMAP DMA engine results in
unpredictable behaviour due to memory ordering issues; as things stand,
there is no guarantee that data written to coherent DMA memory will be
visible to the DMA hardware.

This is because the OMAP dma_write() accessor contains no barriers,
necessary on ARMv6 and above.  The effect of this can be seen in comments
in the OMAP serial driver, which incorrectly talks about cache flushing
for the coherent DMA stuff.

Rather than adding barriers to the accessors, add it in the DMA support
code just before we enable DMA, and just after we disable DMA.  This
avoids having barriers for every DMA register access.

Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/dma.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ecdb3da..c58d896 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -916,6 +916,13 @@ void omap_start_dma(int lch)
 			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 	l |= OMAP_DMA_CCR_EN;
 
+	/*
+	 * As dma_write() uses IO accessors which are weakly ordered, there
+	 * is no guarantee that data in coherent DMA memory will be visible
+	 * to the DMA device.  Add a memory barrier here to ensure that any
+	 * such data is visible prior to enabling DMA.
+	 */
+	mb();
 	p->dma_write(l, CCR, lch);
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
@@ -965,6 +972,13 @@ void omap_stop_dma(int lch)
 		p->dma_write(l, CCR, lch);
 	}
 
+	/*
+	 * Ensure that data transferred by DMA is visible to any access
+	 * after DMA has been disabled.  This is important for coherent
+	 * DMA regions.
+	 */
+	mb();
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[dma_lch_count];
-- 
1.7.4.4

