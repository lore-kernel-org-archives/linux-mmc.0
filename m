From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 05/11] mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
Date: Wed, 16 Jan 2013 17:54:40 +0100
Message-ID: <1358355286-26029-6-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757911Ab3APQyt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 11:54:49 -0500
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

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

