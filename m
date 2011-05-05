From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 10/22] mmc: omap_hsmmc: reduce a bit the error handlers in probe()
Date: Thu,  5 May 2011 14:51:10 +0300
Message-ID: <1304596282-4095-11-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62761 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1EELwW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:22 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a727bf8..7a153af 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2204,18 +2204,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
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
@@ -2382,7 +2375,9 @@ err_irq:
 				host->dma_ctrl_buf,
 				host->dma_ctrl_buf_phy);
 	mmc_host_disable(host->mmc);
+err3:
 	clk_disable(host->iclk);
+err2:
 	clk_put(host->fclk);
 	clk_put(host->iclk);
 	if (host->got_dbclk) {
-- 
1.7.0.4

