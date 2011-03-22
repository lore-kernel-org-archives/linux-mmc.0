From: akpm@linux-foundation.org
Subject: [patch 149/177] drivers/mmc/host/omap_hsmmc.c: use resource_size()
Date: Tue, 22 Mar 2011 16:34:42 -0700
Message-ID: <201103222334.p2MNYhll002442@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45812 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753809Ab1CVXnt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 19:43:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Chris Ball <cjb@laptop.org>

Use resource_size().

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~drivers-mmc-host-omap_hsmmcc-use-resource_size drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~drivers-mmc-host-omap_hsmmcc-use-resource_size
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -2047,8 +2047,7 @@ static int __init omap_hsmmc_probe(struc
 
 	res->start += pdata->reg_offset;
 	res->end += pdata->reg_offset;
-	res = request_mem_region(res->start, res->end - res->start + 1,
-							pdev->name);
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
 
@@ -2287,7 +2286,7 @@ err1:
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
 err:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -2324,7 +2323,7 @@ static int omap_hsmmc_remove(struct plat
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
-		release_mem_region(res->start, res->end - res->start + 1);
+		release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
_
