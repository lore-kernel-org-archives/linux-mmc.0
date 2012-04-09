From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 4/4] mmc: omap_hsmmc: Cleanup use of cpu_is_* for debounce_clock
Date: Mon, 9 Apr 2012 12:08:35 +0530
Message-ID: <1333953515-31925-5-git-send-email-svenkatr@ti.com>
References: <1333953515-31925-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35619 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab2DIGjP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 02:39:15 -0400
In-Reply-To: <1333953515-31925-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

There really does not seem to be a need to use cpu_is_*
check for getting the debounce clock as clkdev is
perfectly capable of handling situations when certain
clocks are only available on select platforms.

Also get rid of the 'got_dbclk' flag and instead use the
dbclk clock pointer to know if a valid debounce clock
exists for the platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8f296d..ea8afcb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -170,7 +170,6 @@ struct omap_hsmmc_host {
 	int			use_dma, dma_ch;
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
-	int			got_dbclk;
 	int			response_busy;
 	int			context_loss;
 	int			vdd;
@@ -1097,7 +1096,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 
 	/* Disable the clocks */
 	pm_runtime_put_sync(host->dev);
-	if (host->got_dbclk)
+	if (host->dbclk)
 		clk_disable(host->dbclk);
 
 	/* Turn the power off */
@@ -1108,7 +1107,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
 					       vdd);
 	pm_runtime_get_sync(host->dev);
-	if (host->got_dbclk)
+	if (host->dbclk)
 		clk_enable(host->dbclk);
 
 	if (ret != 0)
@@ -1902,21 +1901,17 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_context_save(host);
 
-	if (cpu_is_omap2430()) {
-		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
-		/*
-		 * MMC can still work without debounce clock.
-		 */
-		if (IS_ERR(host->dbclk))
-			dev_warn(mmc_dev(host->mmc),
-				"Failed to get debounce clock\n");
-		else
-			host->got_dbclk = 1;
-
-		if (host->got_dbclk)
-			if (clk_enable(host->dbclk) != 0)
-				dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
-							" clk failed\n");
+	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
+	/*
+	 * MMC can still work without debounce clock.
+	 */
+	if (IS_ERR(host->dbclk)) {
+		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clk\n");
+		host->dbclk = NULL;
+	} else if (clk_enable(host->dbclk) != 0) {
+		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
+		clk_put(host->dbclk);
+		host->dbclk = NULL;
 	}
 
 	/* Since we do only SG emulation, we can have as many segs
@@ -2036,7 +2031,7 @@ err_irq:
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
-	if (host->got_dbclk) {
+	if (host->dbclk) {
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
 	}
@@ -2069,7 +2064,7 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
-	if (host->got_dbclk) {
+	if (host->dbclk) {
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
 	}
@@ -2127,7 +2122,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
-	if (host->got_dbclk)
+	if (host->dbclk)
 		clk_disable(host->dbclk);
 err:
 	pm_runtime_put_sync(host->dev);
@@ -2148,7 +2143,7 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	pm_runtime_get_sync(host->dev);
 
-	if (host->got_dbclk)
+	if (host->dbclk)
 		clk_enable(host->dbclk);
 
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
-- 
1.7.10.rc2

