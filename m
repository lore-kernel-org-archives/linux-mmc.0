From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 5/7] mmc: omap: Convert to devm_ioremap_resource
Date: Wed,  4 Dec 2013 21:14:12 +0000
Message-ID: <1386191654-7686-6-git-send-email-jarkko.nikula@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
 <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48179 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab3LDTO3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Dec 2013 14:14:29 -0500
In-Reply-To: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Simplify probe and cleanup code by using devm_ioremap_resource. This also
makes probe code to follow more common allocate private struct followed by
other initialization style.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0d669cf..e4c7a03 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1334,22 +1334,19 @@ static int mmc_omap_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
+			    GFP_KERNEL);
+	if (host == NULL)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (irq < 0)
 		return -ENXIO;
 
-	res = request_mem_region(res->start, resource_size(res),
-				 pdev->name);
-	if (res == NULL)
-		return -EBUSY;
-
-	host = devm_kzalloc(&pdev->dev, sizeof(struct mmc_omap_host),
-			    GFP_KERNEL);
-	if (host == NULL) {
-		ret = -ENOMEM;
-		goto err_free_mem_region;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(host->virt_base))
+		return PTR_ERR(host->virt_base);
 
 	INIT_WORK(&host->slot_release_work, mmc_omap_slot_release_work);
 	INIT_WORK(&host->send_stop_work, mmc_omap_send_stop_work);
@@ -1374,15 +1371,9 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->irq = irq;
 	host->use_dma = 1;
 	host->phys_base = res->start;
-	host->virt_base = ioremap(res->start, resource_size(res));
-	if (!host->virt_base)
-		goto err_ioremap;
-
 	host->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(host->iclk)) {
-		ret = PTR_ERR(host->iclk);
-		goto err_free_mmc_host;
-	}
+	if (IS_ERR(host->iclk))
+		return PTR_ERR(host->iclk);
 	clk_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
@@ -1460,11 +1451,6 @@ err_free_dma:
 err_free_iclk:
 	clk_disable(host->iclk);
 	clk_put(host->iclk);
-err_free_mmc_host:
-	iounmap(host->virt_base);
-err_ioremap:
-err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -1492,9 +1478,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
 
-	iounmap(host->virt_base);
-	release_mem_region(pdev->resource[0].start,
-			   pdev->resource[0].end - pdev->resource[0].start + 1);
 	destroy_workqueue(host->mmc_omap_wq);
 
 	return 0;
-- 
1.8.4.3

