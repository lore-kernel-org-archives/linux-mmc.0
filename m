From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 2/6] mmc: omap: Remove duplicate host->irq assignment
Date: Wed, 11 Sep 2013 21:01:53 +0300
Message-ID: <1378922517-3968-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1378922517-3968-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:45648 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab3IKS3Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Sep 2013 14:29:25 -0400
In-Reply-To: <1378922517-3968-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>

host-irq is set twice so remove needless one.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 03179da..4d9fc5c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1384,7 +1384,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->mem_res = res;
 	host->irq = irq;
 	host->use_dma = 1;
-	host->irq = irq;
 	host->phys_base = host->mem_res->start;
 	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
-- 
1.8.4.rc3

