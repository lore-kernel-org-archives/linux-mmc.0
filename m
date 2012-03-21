From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus clock
Date: Wed, 21 Mar 2012 18:02:29 +0900
Message-ID: <1332320549-28584-3-git-send-email-horms@verge.net.au>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41244 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab2CUJCl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 05:02:41 -0400
In-Reply-To: <1332320549-28584-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

mmc->f_max should be half of the bus clock.
And now that mmc->f_max is not equal to the bus clock the
latter should be used directly to calculate mmc->f_min.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mmcif.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5014bc4..1410baa 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1297,14 +1297,14 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
-	mmc->f_max = host->clk;
+	mmc->f_max = host->clk / 2;
 	/* close to 400KHz */
-	if (mmc->f_max < 51200000)
-		mmc->f_min = mmc->f_max / 128;
-	else if (mmc->f_max < 102400000)
-		mmc->f_min = mmc->f_max / 256;
+	if (host->clk < 51200000)
+		mmc->f_min = host->clk / 128;
+	else if (host->clk < 102400000)
+		mmc->f_min = host->clk / 256;
 	else
-		mmc->f_min = mmc->f_max / 512;
+		mmc->f_min = host->clk / 512;
 	if (pd->ocr)
 		mmc->ocr_avail = pd->ocr;
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
-- 
1.7.6.3

