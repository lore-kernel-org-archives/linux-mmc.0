From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 1/6] mmc: omap: Convert to devm_kzalloc
Date: Wed, 11 Sep 2013 21:01:52 +0300
Message-ID: <1378922517-3968-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:45645 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab3IKS3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Sep 2013 14:29:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b94f38e..03179da 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1354,7 +1354,8 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;
 
-	host = kzalloc(sizeof(struct mmc_omap_host), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
+			    GFP_KERNEL);
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err_free_mem_region;
@@ -1473,7 +1474,6 @@ err_free_iclk:
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:
-	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
@@ -1508,8 +1508,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 	destroy_workqueue(host->mmc_omap_wq);
 
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.8.4.rc3

