From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 2/7] mmc: omap: Convert to devm_kzalloc
Date: Wed,  4 Dec 2013 21:14:09 +0000
Message-ID: <1386191654-7686-3-git-send-email-jarkko.nikula@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
 <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48207 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab3LDTOf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Dec 2013 14:14:35 -0500
In-Reply-To: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 42b665d..927ed24 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1345,7 +1345,8 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;
 
-	host = kzalloc(sizeof(struct mmc_omap_host), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
+			    GFP_KERNEL);
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err_free_mem_region;
@@ -1465,7 +1466,6 @@ err_free_iclk:
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:
-	kfree(host);
 err_free_mem_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
@@ -1500,8 +1500,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
 	destroy_workqueue(host->mmc_omap_wq);
 
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.8.4.3

