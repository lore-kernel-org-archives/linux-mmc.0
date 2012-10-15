From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/4] mmc: omap_hsmmc: fix host reference after mmc_free_host
Date: Mon, 15 Oct 2012 21:35:07 +0530
Message-ID: <1350317108-10657-3-git-send-email-svenkatr@ti.com>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab2JOQFX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 12:05:23 -0400
In-Reply-To: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Balaji T K <balajitk@ti.com>

struct omap_hsmmc_host *host should not be accessed after mmc_free_host().
Reorder mmc_free_host() after iounmap(host->base).

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a33ab74..a3929b7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2019,8 +2019,8 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 		clk_put(host->dbclk);
 	}
 
-	mmc_free_host(host->mmc);
 	iounmap(host->base);
+	mmc_free_host(host->mmc);
 	omap_hsmmc_gpio_free(pdev->dev.platform_data);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.11.1.25.g0e18bef

