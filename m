From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: modify the condition for platdata of blk-setting
Date: Mon, 16 Jan 2012 11:45:27 +0900
Message-ID: <4F138F47.7040709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38302 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2APCpa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2012 21:45:30 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXV00GQZEBPRL10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jan 2012 11:45:28 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXV001U4EBRUQ80@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jan 2012 11:45:27 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

When use the IDMAC, we can also want to use the pdata->blk-setting.
So if pdata->blk-setting is unset, use the default value.
if not, use the pdata->blk-setting.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0e34279..d458aaa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1714,13 +1714,6 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
-#ifdef CONFIG_MMC_DW_IDMAC
-	mmc->max_segs = host->ring_size;
-	mmc->max_blk_size = 65536;
-	mmc->max_blk_count = host->ring_size;
-	mmc->max_seg_size = 0x1000;
-	mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
-#else
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
 		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
@@ -1729,13 +1722,20 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
 	} else {
 		/* Useful defaults if platform data is unset. */
+#ifdef CONFIG_MMC_DW_IDMAC
+		mmc->max_segs = host->ring_size;
+		mmc->max_blk_size = 65536;
+		mmc->max_blk_count = host->ring_size;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
+#else
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
 		mmc->max_blk_count = 512;
 		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 		mmc->max_seg_size = mmc->max_req_size;
-	}
 #endif /* CONFIG_MMC_DW_IDMAC */
+	}
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
-- 
1.7.4.1
