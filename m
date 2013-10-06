From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH FIX+RESEND 2/7] mmc: omap: Convert to devm_kzalloc
Date: Sun,  6 Oct 2013 20:36:13 +0300
Message-ID: <1381080978-29127-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46791 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab3JFRii (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Oct 2013 13:38:38 -0400
In-Reply-To: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, aaro.koskinen@iki.fi, Jarkko Nikula <jarkko.nikula@bitmer.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 31f33ac..1d0d21f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1356,7 +1356,8 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;
 
-	host = kzalloc(sizeof(struct mmc_omap_host), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
+			    GFP_KERNEL);
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err_free_mem_region;
@@ -1475,7 +1476,6 @@ err_free_iclk:
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:
-	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
@@ -1510,8 +1510,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 	destroy_workqueue(host->mmc_omap_wq);
 
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.8.4.rc3

