From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 2/7] mmc: omap: Convert to devm_kzalloc
Date: Sat, 22 Feb 2014 18:01:38 +0200
Message-ID: <1393084903-7194-3-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 42b665dfaa73..927ed24d0708 100644
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
1.8.5.3

