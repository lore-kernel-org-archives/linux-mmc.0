From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] mmc: omap_hsmmc: fix host reference after mmc_free_host
Date: Thu, 11 Oct 2012 21:07:04 +0530
Message-ID: <1349969825-12723-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45978 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510Ab2JKPhN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Oct 2012 11:37:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

struct omap_hsmmc_host *host should not be accessed after mmc_free_host().
Reorder mmc_free_host() after iounmap(host->base).

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d9af5f1..02421a9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2010,8 +2010,8 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 		clk_put(host->dbclk);
 	}
 
-	mmc_free_host(host->mmc);
 	iounmap(host->base);
+	mmc_free_host(host->mmc);
 	omap_hsmmc_gpio_free(pdev->dev.platform_data);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.5.4

