From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 6/8] mmc: host: omap_hsmmc: make it behave well as a module
Date: Fri, 16 Mar 2012 19:09:02 +0530
Message-ID: <1331905144-31655-7-git-send-email-svenkatr@ti.com>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

if we put probe() on __init section, that will never
work for multiple module insertions/removals.

In order to make it work properly, move probe to
__devinit section and use platform_driver_register()
instead of platform_driver_probe().

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c16c552..bcb8c5d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1779,7 +1779,7 @@ static inline struct omap_mmc_platform_data
 }
 #endif
 
-static int __init omap_hsmmc_probe(struct platform_device *pdev)
+static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
@@ -2031,7 +2031,7 @@ err:
 	return ret;
 }
 
-static int omap_hsmmc_remove(struct platform_device *pdev)
+static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 {
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 	struct resource *res;
@@ -2189,7 +2189,8 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 };
 
 static struct platform_driver omap_hsmmc_driver = {
-	.remove		= omap_hsmmc_remove,
+	.probe		= omap_hsmmc_probe,
+	.remove		= __devexit_p(omap_hsmmc_remove),
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
@@ -2201,7 +2202,7 @@ static struct platform_driver omap_hsmmc_driver = {
 static int __init omap_hsmmc_init(void)
 {
 	/* Register the MMC driver */
-	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
+	return platform_driver_register(&omap_hsmmc_driver);
 }
 
 static void __exit omap_hsmmc_cleanup(void)
-- 
1.7.10.rc0.41.gfa678

