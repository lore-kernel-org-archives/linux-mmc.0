From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fix the wrong max_blk_size
Date: Wed, 04 May 2016 11:24:14 +0900
Message-ID: <1462328654-5165-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36812 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbcEDCYU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 22:24:20 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6M02Q9SS0HKK40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 May 2016 11:24:17 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

According to DesignWare TRM, BLKSIZ is 16bits.
Then it's correct that max_blk_size should be 0xFFFF, not 0x10000.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9dd1bd3..829a6ee 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2595,13 +2595,13 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
-		mmc->max_blk_size = 65536;
+		mmc->max_blk_size = 65535;
 		mmc->max_seg_size = 0x1000;
 		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
-		mmc->max_blk_size = 65536;
+		mmc->max_blk_size = 65535;
 		mmc->max_blk_count = 65535;
 		mmc->max_req_size =
 				mmc->max_blk_size * mmc->max_blk_count;
@@ -2609,7 +2609,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	} else {
 		/* TRANS_MODE_PIO */
 		mmc->max_segs = 64;
-		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
+		mmc->max_blk_size = 65535; /* BLKSIZ is 16 bits */
 		mmc->max_blk_count = 512;
 		mmc->max_req_size = mmc->max_blk_size *
 				    mmc->max_blk_count;
-- 
1.9.1

