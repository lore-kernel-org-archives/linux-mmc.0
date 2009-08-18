From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 1/9] s3cmci: Use resource_size() instead of local macro
Date: Tue, 18 Aug 2009 12:56:05 +0100
Message-ID: <20090818115658.717272622@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55695 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758739AbZHRL5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:57:00 -0400
Content-Disposition: inline; filename=s3cmci-fix-resource-size.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Replace the local definition RESSIZE() with the standard resource_size()
call for getting the size of a struct resource.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/mmc/host/s3cmci.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-07-20 14:35:52.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-07-22 14:34:10.000000000 +0100
@@ -58,8 +58,6 @@ static const int dbgmap_debug = dbg_err 
 		dev_dbg(&host->pdev->dev, args);  \
 	} while (0)
 
-#define RESSIZE(ressource) (((ressource)->end - (ressource)->start)+1)
-
 static struct s3c2410_dma_client s3cmci_dma_client = {
 	.name		= "s3c-mci",
 };
@@ -1298,7 +1296,7 @@ static int __devinit s3cmci_probe(struct
 	}
 
 	host->mem = request_mem_region(host->mem->start,
-				       RESSIZE(host->mem), pdev->name);
+				       resource_size(host->mem), pdev->name);
 
 	if (!host->mem) {
 		dev_err(&pdev->dev, "failed to request io memory region.\n");
@@ -1306,7 +1304,7 @@ static int __devinit s3cmci_probe(struct
 		goto probe_free_host;
 	}
 
-	host->base = ioremap(host->mem->start, RESSIZE(host->mem));
+	host->base = ioremap(host->mem->start, resource_size(host->mem));
 	if (!host->base) {
 		dev_err(&pdev->dev, "failed to ioremap() io memory region.\n");
 		ret = -EINVAL;
@@ -1433,7 +1431,7 @@ static int __devinit s3cmci_probe(struct
 	iounmap(host->base);
 
  probe_free_mem_region:
-	release_mem_region(host->mem->start, RESSIZE(host->mem));
+	release_mem_region(host->mem->start, resource_size(host->mem));
 
  probe_free_host:
 	mmc_free_host(mmc);
@@ -1469,7 +1467,7 @@ static int __devexit s3cmci_remove(struc
 	free_irq(host->irq, host);
 
 	iounmap(host->base);
-	release_mem_region(host->mem->start, RESSIZE(host->mem));
+	release_mem_region(host->mem->start, resource_size(host->mem));
 
 	mmc_free_host(mmc);
 	return 0;

-- 
