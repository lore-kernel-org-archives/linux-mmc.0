From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] sdhci-pxav3: Fix runtime PM initialization
Date: Mon, 10 Jun 2013 16:16:18 -0400 (EDT)
Message-ID: <20130610201618.C08C3FAACC@dev.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.laptop.org ([18.85.2.166]:49535 "EHLO swan.laptop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab3FJUYJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jun 2013 16:24:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, kliu5@marvell.com, jlfu@marvell.com

Commit bb691ae464b77d30e74c66480e98d74e88d6b194 breaks boot on OLPC XO-4,
it hangs somewhere inside sdhci_add_host.

When pm_runtime_set_autosuspend_delay() was being called, the device's usage
counter was 0, causing the PM layer to runtime-suspend the device. We then
went on to call sdhci_add_host() on a suspended device, which hung.

Fix this by making the driver consistent with the omap_hsmmc driver, both
in terms of runtime PM initialization and error handling. Now the device
is not runtime-suspended until we exit the probe routine.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a0cdbc5..86d8ac8 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -300,18 +300,15 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_suspend_ignore_children(&pdev->dev, 1);
-	pm_runtime_get_noresume(&pdev->dev);
 
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-		pm_runtime_forbid(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
 		goto err_add_host;
 	}
 
@@ -324,11 +321,14 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 0);
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
 err_add_host:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 err_cd_req:
-- 
1.8.1.4

