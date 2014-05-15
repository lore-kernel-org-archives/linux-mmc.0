From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: use IS_ERR macro for error checking
Date: Thu, 15 May 2014 18:53:49 +0530
Message-ID: <1400160229-2578-1-git-send-email-balajitk@ti.com>
References: <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Debounce clock is optional, use IS_ERR macro instead of NULL pointer check.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6b7b755..521eec3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1155,7 +1155,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 
 	/* Disable the clocks */
 	pm_runtime_put_sync(host->dev);
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
@@ -1166,7 +1166,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
 					       vdd);
 	pm_runtime_get_sync(host->dev);
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_prepare_enable(host->dbclk);
 
 	if (ret != 0)
@@ -1947,12 +1947,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	/*
 	 * MMC can still work without debounce clock.
 	 */
-	if (IS_ERR(host->dbclk)) {
-		host->dbclk = NULL;
-	} else if (clk_prepare_enable(host->dbclk) != 0) {
+	if (!IS_ERR(host->dbclk) && clk_prepare_enable(host->dbclk))
 		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
-		host->dbclk = NULL;
-	}
 
 	/* Since we do only SG emulation, we can have as many segs
 	 * as we want. */
@@ -2103,7 +2099,7 @@ err_irq:
 		dma_release_channel(host->rx_chan);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_disable_unprepare(host->dbclk);
 err1:
 	mmc_free_host(mmc);
@@ -2131,7 +2127,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_disable_unprepare(host->dbclk);
 
 	omap_hsmmc_gpio_free(host->pdata);
@@ -2175,7 +2171,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_disable_unprepare(host->dbclk);
 
 	pm_runtime_put_sync(host->dev);
@@ -2192,7 +2188,7 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	pm_runtime_get_sync(host->dev);
 
-	if (host->dbclk)
+	if (!IS_ERR(host->dbclk))
 		clk_prepare_enable(host->dbclk);
 
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
-- 
1.7.5.4

