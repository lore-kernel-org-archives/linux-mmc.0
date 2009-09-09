From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 28/30] omap_hsmmc: ensure all clock enables and disables are paired
Date: Wed, 09 Sep 2009 15:00:03 +0300
Message-ID: <20090909120003.12833.82537.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25279 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZIIMAV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 08:00:21 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

>From baf6574a1b5e7c4fdc4a66d9e038efeee75ea1a0 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sun, 31 May 2009 19:27:36 +0300
Subject: [PATCH] omap_hsmmc: ensure all clock enables and disables are paired

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 047e656..64780da 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -735,22 +735,24 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	/* Disable the clocks */
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
-	clk_disable(host->dbclk);
+	if (host->dbclk_enabled)
+		clk_disable(host->dbclk);
 
 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
-	if (ret != 0)
-		goto err;
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
-	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
+	if (!ret)
+		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
+					       vdd);
+	clk_enable(host->iclk);
+	if (host->dbclk_enabled)
+		clk_enable(host->dbclk);
+	clk_enable(host->fclk);
+
 	if (ret != 0)
 		goto err;
 
-	clk_enable(host->fclk);
-	clk_enable(host->iclk);
-	clk_enable(host->dbclk);
-
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 		OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
 	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
@@ -1898,7 +1900,8 @@ static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
-			clk_disable(host->dbclk);
+			if (host->dbclk_enabled)
+				clk_disable(host->dbclk);
 		} else {
 			host->suspended = 0;
 			if (host->pdata->resume) {
@@ -1929,9 +1932,8 @@ static int omap_hsmmc_resume(struct platform_device *pdev)
 		if (ret)
 			goto clk_en_err;
 
-		if (clk_enable(host->dbclk) != 0)
-			dev_dbg(mmc_dev(host->mmc),
-					"Enabling debounce clk failed\n");
+		if (host->dbclk_enabled)
+			clk_enable(host->dbclk);
 
 		if (mmc_host_enable(host->mmc) != 0) {
 			clk_disable(host->iclk);
-- 
1.5.6.3

