From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/5] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
Date: Tue, 6 Nov 2012 22:22:14 +0530
Message-ID: <1352220737-14071-4-git-send-email-svenkatr@ti.com>
References: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

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
index c277da4..e91e85a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2065,6 +2065,25 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
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
@@ -2078,23 +2097,10 @@ static int omap_hsmmc_suspend(struct device *dev)
 
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
 
@@ -2131,12 +2137,6 @@ static int omap_hsmmc_resume(struct device *dev)
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
@@ -2152,8 +2152,10 @@ static int omap_hsmmc_resume(struct device *dev)
 }
 
 #else
+#define omap_hsmmc_prepare	NULL
+#define omap_hsmmc_complete	NULL
 #define omap_hsmmc_suspend	NULL
-#define omap_hsmmc_resume		NULL
+#define omap_hsmmc_resume	NULL
 #endif
 
 static int omap_hsmmc_runtime_suspend(struct device *dev)
@@ -2181,6 +2183,8 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
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

