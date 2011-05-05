From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 03/22] OMAP: DMA: Ensure the sglist registers are cleared
Date: Thu,  5 May 2011 14:51:03 +0300
Message-ID: <1304596282-4095-4-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:46911 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab1EELvx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:51:53 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>, Venkatraman S <svenkatr@ti.com>, Shilimkar Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

The new DMA descriptor auto-loading feature (referred to
as sglist in the code) uses new registers.  Ensure they
are cleared.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
CC: Venkatraman S <svenkatr@ti.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 32a923a..a8264a0 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1914,13 +1914,14 @@ void omap_clear_dma_sglist_mode(int lch)
 {
 	/* Clear entire CDP which is related to sglist handling */
 	p->dma_write(0, CDP, lch);
+	p->dma_write(0, CNDP, lch);
 	p->dma_write(0, CCDN, lch);
-	/**
-	 * Put back the original enabled irqs, which
-	 * could have been overwritten by type 1 or type 2
-	 * descriptors
+	/*
+	 * CICR could have been overwritten by type 1 or type 2
+	 * descriptors.  It is set up in omap_start_dma() anyway
+	 * so just clear it to be on the safe side.
 	 */
-	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+	p->dma_write(0, CICR, lch);
 	return;
 }
 EXPORT_SYMBOL(omap_clear_dma_sglist_mode);
-- 
1.7.0.4

