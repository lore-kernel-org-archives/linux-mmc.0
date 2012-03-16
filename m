From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 5/8] mmc: host: omap_hsmmc: trivial cleanups
Date: Fri, 16 Mar 2012 19:09:01 +0530
Message-ID: <1331905144-31655-6-git-send-email-svenkatr@ti.com>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

a bunch of non-functional cleanups to the omap_hsmmc
driver.

It basically decreases indentation level, drop unneded
dereferences and drop unneded accesses to the platform_device
structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  147 ++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 77 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2822442..c16c552 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2036,30 +2036,28 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	if (host) {
-		pm_runtime_get_sync(host->dev);
-		mmc_remove_host(host->mmc);
-		if (host->use_reg)
-			omap_hsmmc_reg_put(host);
-		if (host->pdata->cleanup)
-			host->pdata->cleanup(&pdev->dev);
-		free_irq(host->irq, host);
-		if (mmc_slot(host).card_detect_irq)
-			free_irq(mmc_slot(host).card_detect_irq, host);
-
-		pm_runtime_put_sync(host->dev);
-		pm_runtime_disable(host->dev);
-		clk_put(host->fclk);
-		if (host->got_dbclk) {
-			clk_disable(host->dbclk);
-			clk_put(host->dbclk);
-		}
+	pm_runtime_get_sync(host->dev);
+	mmc_remove_host(host->mmc);
+	if (host->use_reg)
+		omap_hsmmc_reg_put(host);
+	if (host->pdata->cleanup)
+		host->pdata->cleanup(&pdev->dev);
+	free_irq(host->irq, host);
+	if (mmc_slot(host).card_detect_irq)
+		free_irq(mmc_slot(host).card_detect_irq, host);
 
-		mmc_free_host(host->mmc);
-		iounmap(host->base);
-		omap_hsmmc_gpio_free(pdev->dev.platform_data);
+	pm_runtime_put_sync(host->dev);
+	pm_runtime_disable(host->dev);
+	clk_put(host->fclk);
+	if (host->got_dbclk) {
+		clk_disable(host->dbclk);
+		clk_put(host->dbclk);
 	}
 
+	mmc_free_host(host->mmc);
+	iounmap(host->base);
+	omap_hsmmc_gpio_free(pdev->dev.platform_data);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
@@ -2072,49 +2070,45 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
-	if (host && host->suspended)
+	if (!host)
 		return 0;
 
-	if (host) {
-		pm_runtime_get_sync(host->dev);
-		host->suspended = 1;
-		if (host->pdata->suspend) {
-			ret = host->pdata->suspend(&pdev->dev,
-							host->slot_id);
-			if (ret) {
-				dev_dbg(mmc_dev(host->mmc),
-					"Unable to handle MMC board"
-					" level suspend\n");
-				host->suspended = 0;
-				return ret;
-			}
-		}
-		ret = mmc_suspend_host(host->mmc);
+	if (host && host->suspended)
+		return 0;
 
+	pm_runtime_get_sync(host->dev);
+	host->suspended = 1;
+	if (host->pdata->suspend) {
+		ret = host->pdata->suspend(dev, host->slot_id);
 		if (ret) {
+			dev_dbg(dev, "Unable to handle MMC board"
+					" level suspend\n");
 			host->suspended = 0;
-			if (host->pdata->resume) {
-				ret = host->pdata->resume(&pdev->dev,
-							  host->slot_id);
-				if (ret)
-					dev_dbg(mmc_dev(host->mmc),
-						"Unmask interrupt failed\n");
-			}
-			goto err;
+			return ret;
 		}
+	}
+	ret = mmc_suspend_host(host->mmc);
 
-		if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
-			omap_hsmmc_disable_irq(host);
-			OMAP_HSMMC_WRITE(host->base, HCTL,
-				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
+	if (ret) {
+		host->suspended = 0;
+		if (host->pdata->resume) {
+			ret = host->pdata->resume(dev, host->slot_id);
+			if (ret)
+				dev_dbg(dev, "Unmask interrupt failed\n");
 		}
-		if (host->got_dbclk)
-			clk_disable(host->dbclk);
+		goto err;
+	}
 
+	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
+		omap_hsmmc_disable_irq(host);
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
+
+	if (host->got_dbclk)
+		clk_disable(host->dbclk);
 err:
 	pm_runtime_put_sync(host->dev);
 	return ret;
@@ -2124,38 +2118,37 @@ err:
 static int omap_hsmmc_resume(struct device *dev)
 {
 	int ret = 0;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+
+	if (!host)
+		return 0;
 
 	if (host && !host->suspended)
 		return 0;
 
-	if (host) {
-		pm_runtime_get_sync(host->dev);
+	pm_runtime_get_sync(host->dev);
 
-		if (host->got_dbclk)
-			clk_enable(host->dbclk);
+	if (host->got_dbclk)
+		clk_enable(host->dbclk);
 
-		if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
-			omap_hsmmc_conf_bus_power(host);
+	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
+		omap_hsmmc_conf_bus_power(host);
 
-		if (host->pdata->resume) {
-			ret = host->pdata->resume(&pdev->dev, host->slot_id);
-			if (ret)
-				dev_dbg(mmc_dev(host->mmc),
-					"Unmask interrupt failed\n");
-		}
+	if (host->pdata->resume) {
+		ret = host->pdata->resume(dev, host->slot_id);
+		if (ret)
+			dev_dbg(dev, "Unmask interrupt failed\n");
+	}
 
-		omap_hsmmc_protect_card(host);
+	omap_hsmmc_protect_card(host);
 
-		/* Notify the core to resume the host */
-		ret = mmc_resume_host(host->mmc);
-		if (ret == 0)
-			host->suspended = 0;
+	/* Notify the core to resume the host */
+	ret = mmc_resume_host(host->mmc);
+	if (ret == 0)
+		host->suspended = 0;
 
-		pm_runtime_mark_last_busy(host->dev);
-		pm_runtime_put_autosuspend(host->dev);
-	}
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 
 	return ret;
 
@@ -2172,7 +2165,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
-	dev_dbg(mmc_dev(host->mmc), "disabled\n");
+	dev_dbg(dev, "disabled\n");
 
 	return 0;
 }
@@ -2183,7 +2176,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
-	dev_dbg(mmc_dev(host->mmc), "enabled\n");
+	dev_dbg(dev, "enabled\n");
 
 	return 0;
 }
-- 
1.7.10.rc0.41.gfa678

