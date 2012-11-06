From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
Date: Tue, 6 Nov 2012 18:34:09 +0200
Message-ID: <1352219649-4460-1-git-send-email-balbi@ti.com>
References: <CAOyx1Lr1g=5RrOZdUiUcgWU0wjoNnpzH6Hr5JfqK8s0n5uoShw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48802 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131Ab2KFQkT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Nov 2012 11:40:19 -0500
In-Reply-To: <CAOyx1Lr1g=5RrOZdUiUcgWU0wjoNnpzH6Hr5JfqK8s0n5uoShw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "\\\"Venkatraman S.\\\"" <svenkatr@ti.com>
Cc: Balaji T K <balajitk@ti.com>, cjb@laptop.org, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

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
---

Fixed ->complete() prototype.

 drivers/mmc/host/omap_hsmmc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 54bfd0c..d2d6a56 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2022,6 +2022,24 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
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
+}
+
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
@@ -2035,23 +2053,10 @@ static int omap_hsmmc_suspend(struct device *dev)
 
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
 
@@ -2088,12 +2093,6 @@ static int omap_hsmmc_resume(struct device *dev)
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
@@ -2109,8 +2108,10 @@ static int omap_hsmmc_resume(struct device *dev)
 }
 
 #else
+#define omap_hsmmc_prepare	NULL
+#define omap_hsmmc_complete	NULL
 #define omap_hsmmc_suspend	NULL
-#define omap_hsmmc_resume		NULL
+#define omap_hsmmc_resume	NULL
 #endif
 
 static int omap_hsmmc_runtime_suspend(struct device *dev)
@@ -2138,6 +2139,8 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
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

