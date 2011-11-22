From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH 1/3] omap_hsmmc: consider MMC_PM_KEEP_POWER on suspend/resume
Date: Tue, 22 Nov 2011 16:02:17 +0200
Message-ID: <1321970539-7104-1-git-send-email-eliad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38189 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab1KVOB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 09:01:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>

When an mmc card has the MMC_PM_KEEP_POWER flag, it shouldn't
be powered off on suspend (and thus doesn't have to be powered-on
on resume)

While on it, change the suspend flow a bit, to make it a bit
easier to follow.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 drivers/mmc/host/omap_hsmmc.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21e4a79..ec7c83c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2174,13 +2174,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 		cancel_work_sync(&host->mmc_carddetect_work);
 		ret = mmc_suspend_host(host->mmc);
 
-		if (ret == 0) {
-			omap_hsmmc_disable_irq(host);
-			OMAP_HSMMC_WRITE(host->base, HCTL,
-				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
-			if (host->got_dbclk)
-				clk_disable(host->dbclk);
-		} else {
+		if (ret) {
 			host->suspended = 0;
 			if (host->pdata->resume) {
 				ret = host->pdata->resume(&pdev->dev,
@@ -2189,9 +2183,20 @@ static int omap_hsmmc_suspend(struct device *dev)
 					dev_dbg(mmc_dev(host->mmc),
 						"Unmask interrupt failed\n");
 			}
+			goto err;
 		}
-		pm_runtime_put_sync(host->dev);
+
+		if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
+			omap_hsmmc_disable_irq(host);
+			OMAP_HSMMC_WRITE(host->base, HCTL,
+				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
+		}
+		if (host->got_dbclk)
+			clk_disable(host->dbclk);
+
 	}
+err:
+	pm_runtime_put_sync(host->dev);
 	return ret;
 }
 
@@ -2211,7 +2216,8 @@ static int omap_hsmmc_resume(struct device *dev)
 		if (host->got_dbclk)
 			clk_enable(host->dbclk);
 
-		omap_hsmmc_conf_bus_power(host);
+		if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
+			omap_hsmmc_conf_bus_power(host);
 
 		if (host->pdata->resume) {
 			ret = host->pdata->resume(&pdev->dev, host->slot_id);
-- 
1.7.6.401.g6a319

