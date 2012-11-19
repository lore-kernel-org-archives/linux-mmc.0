From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 5/7] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
Date: Mon, 19 Nov 2012 21:59:59 +0530
Message-ID: <1353342601-15210-5-git-send-email-svenkatr@ti.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50364 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab2KSQat (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Nov 2012 11:30:49 -0500
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Felipe Balbi <balbi@ti.com>

prepare() is supposed to prevent new children from
being registered. On the MMC subsystem, children
(new cards) registration starts with the card
detect IRQ.

Move card detect IRQ disabling to prepare() so that
no new cards will be registered while we're trying
to suspend.

Likewise, move card detect IRQ enabling to complete()
so we only try to register new children after our MMC
IP is back up.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 44 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 18d3f19..fad9250 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2070,6 +2070,25 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
+static int omap_hsmmc_prepare(struct device *dev)
+{
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+
+	if (host->pdata->suspend)
+		return host->pdata->suspend(dev, host->slot_id);
+
+	return 0;
+}
+
+static void omap_hsmmc_complete(struct device *dev)
+{
+	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+
+	if (host->pdata->resume)
+		host->pdata->resume(dev, host->slot_id);
+
+}
+
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
@@ -2083,23 +2102,10 @@ static int omap_hsmmc_suspend(struct device *dev)
 
 	pm_runtime_get_sync(host->dev);
 	host->suspended = 1;
-	if (host->pdata->suspend) {
-		ret = host->pdata->suspend(dev, host->slot_id);
-		if (ret) {
-			dev_dbg(dev, "Unable to handle MMC board"
-					" level suspend\n");
-			host->suspended = 0;
-			return ret;
-		}
-	}
 	ret = mmc_suspend_host(host->mmc);
 
 	if (ret) {
 		host->suspended = 0;
-		if (host->pdata->resume) {
-			if (host->pdata->resume(dev, host->slot_id))
-				dev_dbg(dev, "Unmask interrupt failed\n");
-		}
 		goto err;
 	}
 
@@ -2136,12 +2142,6 @@ static int omap_hsmmc_resume(struct device *dev)
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
 		omap_hsmmc_conf_bus_power(host);
 
-	if (host->pdata->resume) {
-		ret = host->pdata->resume(dev, host->slot_id);
-		if (ret)
-			dev_dbg(dev, "Unmask interrupt failed\n");
-	}
-
 	omap_hsmmc_protect_card(host);
 
 	/* Notify the core to resume the host */
@@ -2157,8 +2157,10 @@ static int omap_hsmmc_resume(struct device *dev)
 }
 
 #else
+#define omap_hsmmc_prepare	NULL
+#define omap_hsmmc_complete	NULL
 #define omap_hsmmc_suspend	NULL
-#define omap_hsmmc_resume		NULL
+#define omap_hsmmc_resume	NULL
 #endif
 
 static int omap_hsmmc_runtime_suspend(struct device *dev)
@@ -2186,6 +2188,8 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
+	.prepare	= omap_hsmmc_prepare,
+	.complete	= omap_hsmmc_complete,
 	.runtime_suspend = omap_hsmmc_runtime_suspend,
 	.runtime_resume = omap_hsmmc_runtime_resume,
 };
-- 
1.8.0

