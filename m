From: akpm@linux-foundation.org
Subject: [patch 18/42] s3cmci: use resource_size() instead of local macro
Date: Thu, 01 Oct 2009 15:44:13 -0700
Message-ID: <200910012244.n91MiDfo008708@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43597 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753354AbZJAWoR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 18:44:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben@simtec.co.uk, linux-mmc@vger.kernel.org

From: Ben Dooks <ben@simtec.co.uk>

Replace the local definition RESSIZE() with the standard resource_size()
call for getting the size of a struct resource.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff -puN drivers/mmc/host/s3cmci.c~s3cmci-use-resource_size-instead-of-local-macro drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~s3cmci-use-resource_size-instead-of-local-macro
+++ a/drivers/mmc/host/s3cmci.c
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
_
