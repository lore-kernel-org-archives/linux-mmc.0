From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Subject: [PATCHv2.1] mmc: omap_hsmmc: reduce a bit the error handlers in probe()
Date: Tue, 10 May 2011 15:46:17 +0300
Message-ID: <062f4c5e2c7007b40780fb38d48e27917f63afb4.1305030674.git.ext-andriy.shevchenko@nokia.com>
References: <BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

The code contains the similarities in the error path of probe function. Let's
combine them at one place.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index aeaf0cf..b9200ef 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2118,18 +2118,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	/* we start off in DISABLED state */
 	host->dpm_state = DISABLED;
 
-	if (clk_enable(host->iclk) != 0) {
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
+	if (clk_enable(host->iclk) != 0)
+		goto err2;
 
-	if (mmc_host_enable(host->mmc) != 0) {
-		clk_disable(host->iclk);
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
+	if (mmc_host_enable(host->mmc) != 0)
+		goto err3;
 
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
@@ -2274,7 +2267,9 @@ err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
 	mmc_host_disable(host->mmc);
+err3:
 	clk_disable(host->iclk);
+err2:
 	clk_put(host->fclk);
 	clk_put(host->iclk);
 	if (host->got_dbclk) {
-- 
1.6.3.3

