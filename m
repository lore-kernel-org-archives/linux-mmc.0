From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/3] mmc: omap: make it behave well as module
Date: Tue, 8 May 2012 17:05:34 +0530
Message-ID: <1336476935-16564-3-git-send-email-svenkatr@ti.com>
References: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624Ab2EHL36 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 May 2012 07:29:58 -0400
In-Reply-To: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Use proper __devinit and __devexit annotation for driver
functions. Instantiate the probe function for driver_ops
instead of a probe in the register function.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 2d7628e..0056bd8 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1395,7 +1395,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 	mmc_free_host(mmc);
 }
 
-static int __init mmc_omap_probe(struct platform_device *pdev)
+static int __devinit mmc_omap_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
@@ -1522,7 +1522,7 @@ err_free_mem_region:
 	return ret;
 }
 
-static int mmc_omap_remove(struct platform_device *pdev)
+static int __devexit mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 	int i;
@@ -1604,7 +1604,8 @@ static int mmc_omap_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver mmc_omap_driver = {
-	.remove		= mmc_omap_remove,
+	.probe		= mmc_omap_probe,
+	.remove		= __devexit_p(mmc_omap_remove),
 	.suspend	= mmc_omap_suspend,
 	.resume		= mmc_omap_resume,
 	.driver		= {
@@ -1615,7 +1616,7 @@ static struct platform_driver mmc_omap_driver = {
 
 static int __init mmc_omap_init(void)
 {
-	return platform_driver_probe(&mmc_omap_driver, mmc_omap_probe);
+	return platform_driver_register(&mmc_omap_driver);
 }
 
 static void __exit mmc_omap_exit(void)
-- 
1.7.5.4

