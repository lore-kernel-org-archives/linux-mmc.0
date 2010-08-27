From: Chris Ball <cjb@laptop.org>
Subject: omap.c: use resource_size()
Date: Fri, 27 Aug 2010 16:46:48 -0400
Message-ID: <m3bp8n6ax3.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58432 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab0H0UrA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:47:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Use resource_size().

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index d98ddcf..23ce2f1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1416,7 +1416,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, res->end - res->start + 1,
+	res = request_mem_region(res->start, resource_size(res),
 				 pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1456,7 +1456,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
-	host->virt_base = ioremap(res->start, res->end - res->start + 1);
+	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
 		goto err_ioremap;
 
@@ -1513,7 +1513,7 @@ err_free_mmc_host:
 err_ioremap:
 	kfree(host);
 err_free_mem_region:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
