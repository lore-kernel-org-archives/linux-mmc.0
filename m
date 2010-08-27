From: Chris Ball <cjb@laptop.org>
Subject: omap_hsmmc.c: use resource_size()
Date: Fri, 27 Aug 2010 16:48:03 -0400
Message-ID: <m37hjb6av0.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58450 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0H0UsN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:48:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Use resource_size().

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4a8776f..077bbdb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2003,7 +2003,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, res->end - res->start + 1,
+	res = request_mem_region(res->start, resource_size(res),
 							pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -2256,7 +2256,7 @@ err1:
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -2293,7 +2293,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
-		release_mem_region(res->start, res->end - res->start + 1);
+		release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
