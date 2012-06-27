From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] mmc: omap: add clk_prepare and clk_unprepare
Date: Wed, 27 Jun 2012 14:19:54 +0530
Message-ID: <1340786994-29565-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58158 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab2F0IuN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jun 2012 04:50:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the hsmmc clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Balaji T K <balajitk@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>
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

