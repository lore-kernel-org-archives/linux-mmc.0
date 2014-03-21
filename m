From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 5/9] mmc: omap_hsmmc: use devm_ioremap
Date: Fri, 21 Mar 2014 21:47:34 +0530
Message-ID: <1395418658-2375-6-git-send-email-balajitk@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40058 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761031AbaCUQRz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Mar 2014 12:17:55 -0400
In-Reply-To: <1395418658-2375-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

With devm_ioremap conversion iounmap can be removed in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9952673..38a75bc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1905,7 +1905,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->irq	= irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
-	host->base	= ioremap(host->mapbase, SZ_4K);
+	host->base	= devm_ioremap(&pdev->dev, host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
@@ -2105,7 +2105,6 @@ err_irq:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 err1:
-	iounmap(host->base);
 	mmc_free_host(mmc);
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
@@ -2135,7 +2134,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		clk_disable_unprepare(host->dbclk);
 
 	omap_hsmmc_gpio_free(host->pdata);
-	iounmap(host->base);
 	mmc_free_host(host->mmc);
 
 	return 0;
-- 
1.7.5.4

