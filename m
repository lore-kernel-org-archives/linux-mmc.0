From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 06/22] mmc: omap_hsmmc: limit scatterlist size for sDMA autoloading
Date: Thu,  5 May 2011 14:51:06 +0300
Message-ID: <1304596282-4095-7-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62840 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1EELwY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:24 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

The sDMA descriptor autoloading feature uses a fixed size
buffer to store descriptors for scatterlist segments.
That limits the scatterlist size to the maximum number
of descriptors that fit in the buffer.  The driver must
set this limit for upper layers to obey.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 114cd68..bab25ff 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2239,9 +2239,18 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 			host->dma_caps |= DMA_TYPE_SDMA_DLOAD;
 	}
 
-	/* Since we do only SG emulation, we can have as many segs
-	 * as we want. */
-	mmc->max_segs = 1024;
+	if (host->dma_caps & DMA_TYPE_SDMA_DLOAD) {
+		unsigned int max = DMA_CTRL_BUF_SIZE /
+				   sizeof(struct omap_dma_sglist_node);
+
+		mmc->max_segs = 1 << (fls(max) - 1);
+	} else {
+		/*
+		 * Since we do only SG emulation, we can have as many segs as we
+		 * want.
+		 */
+		mmc->max_segs = 1024;
+	}
 
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
-- 
1.7.0.4

