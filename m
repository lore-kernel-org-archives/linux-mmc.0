From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 05/29] mmc: omap_hsmmc: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 14 Jun 2012 18:16:54 +0530
Message-ID: <1339678038-23082-6-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

As we move to Common clk framework use clk_prepare_enable()
instead of clk_enable() and similarly clk_disable_unprepare()
instead of clk_disable()

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Balaji T K <balajitk@ti.com>
Cc: <linux-mmc@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9a7a60a..07f5945 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1097,7 +1097,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	/* Disable the clocks */
 	pm_runtime_put_sync(host->dev);
 	if (host->dbclk)
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -1108,7 +1108,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 					       vdd);
 	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
-		clk_enable(host->dbclk);
+		clk_prepare_enable(host->dbclk);
 
 	if (ret != 0)
 		goto err;
@@ -1908,7 +1908,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(host->dbclk)) {
 		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clk\n");
 		host->dbclk = NULL;
-	} else if (clk_enable(host->dbclk) != 0) {
+	} else if (clk_prepare_enable(host->dbclk) != 0) {
 		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
 		clk_put(host->dbclk);
 		host->dbclk = NULL;
@@ -2032,7 +2032,7 @@ err_irq:
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->dbclk) {
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 		clk_put(host->dbclk);
 	}
 err1:
@@ -2067,7 +2067,7 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->dbclk) {
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 		clk_put(host->dbclk);
 	}
 
@@ -2125,7 +2125,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 	}
 
 	if (host->dbclk)
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 err:
 	pm_runtime_put_sync(host->dev);
 	return ret;
@@ -2146,7 +2146,7 @@ static int omap_hsmmc_resume(struct device *dev)
 	pm_runtime_get_sync(host->dev);
 
 	if (host->dbclk)
-		clk_enable(host->dbclk);
+		clk_prepare_enable(host->dbclk);
 
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
 		omap_hsmmc_conf_bus_power(host);
-- 
1.7.1

