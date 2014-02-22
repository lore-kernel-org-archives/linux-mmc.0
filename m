From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 5/7] mmc: omap: Convert to devm_ioremap_resource
Date: Sat, 22 Feb 2014 18:01:41 +0200
Message-ID: <1393084903-7194-6-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

Simplify probe and cleanup code by using devm_ioremap_resource. This also
makes probe code to follow more common allocate private struct followed by
other initialization style.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0d669cfa6af6..e4c7a0380a63 100644
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
1.8.5.3

