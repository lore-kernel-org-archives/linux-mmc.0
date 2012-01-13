From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC/RFT 1/3] mmc: omap_hsmmc : Make the suspend/resume functions depend on CONFIG_PM_SLEEP
Date: Fri, 13 Jan 2012 14:13:12 +0530
Message-ID: <1326444194-13414-2-git-send-email-shubhrajyoti@ti.com>
References: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45864 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258Ab2AMInW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 03:43:22 -0500
In-Reply-To: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently the suspend/resume functions depend on CONFIG_PM however
the callers have no such dependency.

This patch tries to fix the same by using SET_SYSTEM_SLEEP_PM_OPS
and making the functions depend on CONFIG_PM_SLEEP.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d1fb561..e6f9aea 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2154,7 +2154,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
@@ -2247,10 +2247,6 @@ static int omap_hsmmc_resume(struct device *dev)
 	return ret;
 
 }
-
-#else
-#define omap_hsmmc_suspend	NULL
-#define omap_hsmmc_resume		NULL
 #endif
 
 static int omap_hsmmc_runtime_suspend(struct device *dev)
@@ -2276,8 +2272,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
-	.suspend	= omap_hsmmc_suspend,
-	.resume		= omap_hsmmc_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
 	.runtime_suspend = omap_hsmmc_runtime_suspend,
 	.runtime_resume = omap_hsmmc_runtime_resume,
 };
-- 
1.7.1

