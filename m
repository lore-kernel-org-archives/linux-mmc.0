From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 6/8] mmc: host: omap_hsmmc: make it behave well as a module
Date: Thu, 15 Mar 2012 20:03:40 +0530
Message-ID: <1331822022-26714-7-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

if we put probe() on __init section, that will never
work for multiple module insertions/removals.

In order to make it work properly, move probe to
__devinit section and use platform_driver_register()
instead of platform_driver_probe().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6b30782..67cb63e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1780,7 +1780,7 @@ static inline struct omap_mmc_platform_data
 }
 #endif
 
-static int __init omap_hsmmc_probe(struct platform_device *pdev)
+static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
@@ -2032,7 +2032,7 @@ err:
 	return ret;
 }
 
-static int omap_hsmmc_remove(struct platform_device *pdev)
+static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 	struct resource *res;
@@ -2190,7 +2190,8 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 };
 
 static struct platform_driver omap_hsmmc_driver = {
-	.remove		= omap_hsmmc_remove,
+	.probe		= omap_hsmmc_probe,
+	.remove		= __devexit_p(omap_hsmmc_remove),
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
@@ -2202,7 +2203,7 @@ static struct platform_driver omap_hsmmc_driver = {
 static int __init omap_hsmmc_init(void)
 {
 	/* Register the MMC driver */
-	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
+	return platform_driver_register(&omap_hsmmc_driver);
 }
 
 static void __exit omap_hsmmc_cleanup(void)
-- 
1.7.10.rc0.41.gfa678

