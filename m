From: akpm@linux-foundation.org
Subject: [patch 148/177] drivers/mmc/host/omap.c: use resource_size()
Date: Tue, 22 Mar 2011 16:34:41 -0700
Message-ID: <201103222334.p2MNYfMe002438@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40260 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753809Ab1CVXoC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 19:44:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, tony@atomide.com

From: Chris Ball <cjb@laptop.org>

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/host/omap.c~drivers-mmc-host-omapc-use-resource_size drivers/mmc/host/omap.c
--- a/drivers/mmc/host/omap.c~drivers-mmc-host-omapc-use-resource_size
+++ a/drivers/mmc/host/omap.c
@@ -1417,7 +1417,7 @@ static int __init mmc_omap_probe(struct 
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, res->end - res->start + 1,
+	res = request_mem_region(res->start, resource_size(res),
 				 pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1457,7 +1457,7 @@ static int __init mmc_omap_probe(struct 
 
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
-	host->virt_base = ioremap(res->start, res->end - res->start + 1);
+	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
 		goto err_ioremap;
 
@@ -1514,7 +1514,7 @@ err_free_mmc_host:
 err_ioremap:
 	kfree(host);
 err_free_mem_region:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
_
