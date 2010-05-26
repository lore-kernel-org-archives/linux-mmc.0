From: akpm@linux-foundation.org
Subject: [patch 018/203] mmc: OMAP HS-MMC: convert to dev_pm_ops
Date: Wed, 26 May 2010 14:42:07 -0700
Message-ID: <201005262142.o4QLg736015375@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41994 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217Ab0EZWPZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:15:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, khilman@deeprootsystems.com, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, tony@atomide.com

From: Kevin Hilman <khilman@deeprootsystems.com>

Convert PM operations to use dev_pm_ops.  This will facilitate the runtime
PM coversion which will add to dev_pm_ops hooks.

Note that dev_pm_ops version of the suspend hook no longer takes a 'state'
argument.  However, the MMC core function mmc_suspend_host() still takes a
'state' argument, but it is unused, so a dummy state variable was created
to pass to the MMC core.

In the future, the MMC core should be converted to drop this state
argument and the rest of the MMC drivers could be easily converted to
dev_pm_ops as well.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~mmc-omap-hs-mmc-convert-to-dev_pm_ops drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~mmc-omap-hs-mmc-convert-to-dev_pm_ops
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -2267,10 +2267,12 @@ static int omap_hsmmc_remove(struct plat
 }
 
 #ifdef CONFIG_PM
-static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
+	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
@@ -2316,9 +2318,10 @@ static int omap_hsmmc_suspend(struct pla
 }
 
 /* Routine to resume the MMC device */
-static int omap_hsmmc_resume(struct platform_device *pdev)
+static int omap_hsmmc_resume(struct device *dev)
 {
 	int ret = 0;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 
 	if (host && !host->suspended)
@@ -2369,13 +2372,17 @@ clk_en_err:
 #define omap_hsmmc_resume		NULL
 #endif
 
-static struct platform_driver omap_hsmmc_driver = {
-	.remove		= omap_hsmmc_remove,
+static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
+};
+
+static struct platform_driver omap_hsmmc_driver = {
+	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm = &omap_hsmmc_dev_pm_ops,
 	},
 };
 
_
