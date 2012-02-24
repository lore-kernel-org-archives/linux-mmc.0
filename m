From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/6] mmc: omap_hsmmc: Make the driver support hotpluggable devices
Date: Fri, 24 Feb 2012 15:28:53 +0530
Message-ID: <1330077537-19618-3-git-send-email-rnayak@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Make the hsmmc driver register the driver using platform_driver_register()
so it can support hotpluggable devices.

This is needed, for instance, in case of OMAP3, wherein some of the mmc
devices might get added and removed dynamically based on dependent modules
like twl4030-gpio.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fd0c661..21b8afa 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1847,7 +1847,7 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 
 #endif
 
-static int __init omap_hsmmc_probe(struct platform_device *pdev)
+static int omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
@@ -2264,6 +2264,7 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 };
 
 static struct platform_driver omap_hsmmc_driver = {
+	.probe		= omap_hsmmc_probe,
 	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
@@ -2275,7 +2276,7 @@ static struct platform_driver omap_hsmmc_driver = {
 static int __init omap_hsmmc_init(void)
 {
 	/* Register the MMC driver */
-	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
+	return platform_driver_register(&omap_hsmmc_driver);
 }
 
 static void __exit omap_hsmmc_cleanup(void)
-- 
1.7.1

