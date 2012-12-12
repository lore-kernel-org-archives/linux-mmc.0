From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 05/14] mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout
Date: Wed, 12 Dec 2012 15:38:09 +0100
Message-ID: <1355323098-18061-6-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57914 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268Ab2LLOiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:38:25 -0500
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

Timeout period should be properly normalized using msecs_to_jiffies().

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1ec3339..1665ae4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1348,7 +1348,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
-	host->timeout	= 1000;
+	host->timeout	= msecs_to_jiffies(1000);
 
 	host->pd = pdev;
 
-- 
1.7.2.5

