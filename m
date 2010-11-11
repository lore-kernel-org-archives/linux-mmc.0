From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RESEND] mmc: tmio_mmc: allow multi-element scatter-gather
 lists (fwd)
Date: Thu, 11 Nov 2010 12:15:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011111214020.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:60815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754927Ab0KKLPB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 06:15:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

The driver is capable of handling multi-element sg lists in both PIO and DMA
modes. In DMA mode this also allows to use the DMA sg capability more
efficiently and almost doubles the throughput.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Sorry, one of the addresses was wrong last time, resending to all again to 
simplify commenting.

 drivers/mmc/host/tmio_mmc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e7765a8..9034414 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -864,10 +864,14 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 		goto host_free;
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
-	mmc->caps |= pdata->capabilities;
+	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
+	mmc->max_segs = 32;
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = PAGE_CACHE_SIZE / mmc->max_blk_size * mmc->max_segs;
+	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+	mmc->max_seg_size = mmc->max_req_size;
 	if (pdata->ocr_mask)
 		mmc->ocr_avail = pdata->ocr_mask;
 	else
-- 
1.7.2.3

