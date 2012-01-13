From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC/RFT 3/3] omap : hsmmc : remove pm_runtime_get_sync/put sync from suspend/resume
Date: Fri, 13 Jan 2012 14:13:14 +0530
Message-ID: <1326444194-13414-4-git-send-email-shubhrajyoti@ti.com>
References: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258Ab2AMInY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Jan 2012 03:43:24 -0500
In-Reply-To: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>

The pm_runtime_get_sync/put_sync may not be needed in the latest
code as it is taken care in the framework.

Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e99487a..03e7447 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2070,7 +2070,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 		return 0;
 
 	if (host) {
-		pm_runtime_get_sync(host->dev);
 		host->suspended = 1;
 		if (host->pdata->suspend) {
 			ret = host->pdata->suspend(&pdev->dev,
@@ -2108,7 +2107,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 
 	}
 err:
-	pm_runtime_put_sync(host->dev);
 	return ret;
 }
 
@@ -2123,7 +2121,6 @@ static int omap_hsmmc_resume(struct device *dev)
 		return 0;
 
 	if (host) {
-		pm_runtime_get_sync(host->dev);
 
 		if (host->got_dbclk)
 			clk_enable(host->dbclk);
@@ -2145,8 +2142,6 @@ static int omap_hsmmc_resume(struct device *dev)
 		if (ret == 0)
 			host->suspended = 0;
 
-		pm_runtime_mark_last_busy(host->dev);
-		pm_runtime_put_autosuspend(host->dev);
 	}
 
 	return ret;
-- 
1.7.1

