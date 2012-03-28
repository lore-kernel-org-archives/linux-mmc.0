From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/3] mmc: sh_mmcif: Simplify calculation of mmc->f_min
Date: Wed, 28 Mar 2012 18:01:11 +0900
Message-ID: <1332925271-23860-4-git-send-email-horms@verge.net.au>
References: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50925 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab2C1JBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:01:20 -0400
In-Reply-To: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Cao Minh Hiep <hiepcm@gmail.com>, Simon Horman <horms@verge.net.au>

There is no need to tune mmc->f_min to a value near 400kHz as the MMC core
begins testing frequencies at 400kHz regardless of the value of mmc->f_min.

As suggested by Guennadi Liakhovetski.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mmcif.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1410baa..f23b9bd 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1298,13 +1298,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	mmc->ops = &sh_mmcif_ops;
 	mmc->f_max = host->clk / 2;
-	/* close to 400KHz */
-	if (host->clk < 51200000)
-		mmc->f_min = host->clk / 128;
-	else if (host->clk < 102400000)
-		mmc->f_min = host->clk / 256;
-	else
-		mmc->f_min = host->clk / 512;
+	mmc->f_min = host->clk / 512;
 	if (pd->ocr)
 		mmc->ocr_avail = pd->ocr;
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
-- 
1.7.6.3

