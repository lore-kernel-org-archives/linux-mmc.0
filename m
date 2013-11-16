From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 2/8] mmc: omap: Convert to devm_kzalloc
Date: Sat, 16 Nov 2013 17:53:08 +0200
Message-ID: <1384617194-22126-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
 <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47023 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab3KPPxk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Nov 2013 10:53:40 -0500
In-Reply-To: <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index df2d10f..4ea13e3 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1355,7 +1355,8 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;
 
-	host = kzalloc(sizeof(struct mmc_omap_host), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
+			    GFP_KERNEL);
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err_free_mem_region;
@@ -1474,7 +1475,6 @@ err_free_iclk:
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:
-	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
@@ -1509,8 +1509,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 	destroy_workqueue(host->mmc_omap_wq);
 
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.8.4.2

