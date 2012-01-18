From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: simplify capability calculation
Date: Wed, 18 Jan 2012 10:11:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201181010530.28782@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53300 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab2ARJMA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 04:12:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id EF1E918B04D
	for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2012 10:11:56 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ff8b63e..c4bfbb0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1307,9 +1307,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		mmc->f_min = mmc->f_max / 512;
 	if (pd->ocr)
 		mmc->ocr_avail = pd->ocr;
-	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
-	if (pd->caps)
-		mmc->caps |= pd->caps;
+	mmc->caps = MMC_CAP_MMC_HIGHSPEED | pd->caps;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
 	mmc->max_req_size = PAGE_CACHE_SIZE * mmc->max_segs;
-- 
1.7.2.5

