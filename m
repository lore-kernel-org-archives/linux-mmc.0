From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 3/8] mmc: omap: Remove duplicate host->irq assignment
Date: Sat, 16 Nov 2013 17:53:09 +0200
Message-ID: <1384617194-22126-3-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
 <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47021 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab3KPPxk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Nov 2013 10:53:40 -0500
In-Reply-To: <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>

host-irq is set twice so remove needless one.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 4ea13e3..e6987ae 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1385,7 +1385,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->mem_res = res;
 	host->irq = irq;
 	host->use_dma = 1;
-	host->irq = irq;
 	host->phys_base = host->mem_res->start;
 	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
-- 
1.8.4.2

