From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 4/9] mmc: omap_hsmmc: use devm_request_mem_region
Date: Fri, 21 Mar 2014 21:47:33 +0530
Message-ID: <1395418658-2375-5-git-send-email-balajitk@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1395418658-2375-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

With devm_request_mem_region conversion release_mem_region can be
removed in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8e35a6e..9952673 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1881,7 +1881,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	res = devm_request_mem_region(&pdev->dev, res->start,
+					resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
 
@@ -2109,16 +2110,12 @@ err1:
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
 static int omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
@@ -2141,10 +2138,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	iounmap(host->base);
 	mmc_free_host(host->mmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-
 	return 0;
 }
 
-- 
1.7.5.4

