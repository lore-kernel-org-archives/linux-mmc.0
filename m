From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 05/11] mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
Date: Wed, 23 Jan 2013 16:32:32 +0100
Message-ID: <1358955158-1510-6-git-send-email-g.liakhovetski@gmx.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57029 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab3AWPkT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 10:40:19 -0500
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Use mmc_of_parse() to get interface capability flags and used GPIOs from
device-tree bindings.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 741aeb9..4de94a1 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1329,6 +1329,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto ealloch;
 	}
+	mmc_of_parse(mmc);
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
@@ -1341,7 +1342,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
 
-	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
+	mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
-- 
1.7.2.5

