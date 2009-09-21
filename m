From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 02/11] s3cmci: update probe to use new platform id list.
Date: Mon, 21 Sep 2009 14:35:57 +0100
Message-ID: <20090921133721.268888346@smtp.local.simtec.co.uk>
References: <20090921133555.015075699@smtp.local.simtec.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hull.simtec.co.uk ([78.105.113.97]:39676 "EHLO
	preston.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756247AbZIUOV5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2009 10:21:57 -0400
Content-Disposition: inline; filename=simtec/pushed/s3cmci-update-probe.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: ben-linux@fluff.org

Use the platform id list to match the three different versions of the
hardware block that this driver supports.

This will change the prefix of the console messages produced by this
driver to be prefixed by s3c-mci instead of the hardware block name,
such as s3c2440-mci.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/mmc/host/s3cmci.c |   71 +++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 47 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-07-20 14:47:21.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-07-22 14:33:54.000000000 +0100
@@ -1244,11 +1244,14 @@ static inline void s3cmci_cpufreq_deregi
 }
 #endif
 
-static int __devinit s3cmci_probe(struct platform_device *pdev, int is2440)
+static int __devinit s3cmci_probe(struct platform_device *pdev)
 {
 	struct s3cmci_host *host;
 	struct mmc_host	*mmc;
 	int ret;
+	int is2440;
+
+	is2440 = platform_get_device_id(pdev)->driver_data;
 
 	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
 	if (!mmc) {
@@ -1473,20 +1476,22 @@ static int __devexit s3cmci_remove(struc
 	return 0;
 }
 
-static int __devinit s3cmci_2410_probe(struct platform_device *dev)
-{
-	return s3cmci_probe(dev, 0);
-}
+static struct platform_device_id s3cmci_driver_ids[] = {
+	{
+		.name	= "s3c2410-sdi",
+		.driver_data	= 0,
+	}, {
+		.name	= "s3c2412-sdi",
+		.driver_data	= 1,
+	}, {
+		.name	= "s3c2440-sdi",
+		.driver_data	= 1,
+	},
+	{ }
+};
 
-static int __devinit s3cmci_2412_probe(struct platform_device *dev)
-{
-	return s3cmci_probe(dev, 1);
-}
+MODULE_DEVICE_TABLE(platform, s3cmci_driver_ids);
 
-static int __devinit s3cmci_2440_probe(struct platform_device *dev)
-{
-	return s3cmci_probe(dev, 1);
-}
 
 #ifdef CONFIG_PM
 
@@ -1510,50 +1515,25 @@ static int s3cmci_resume(struct platform
 #endif /* CONFIG_PM */
 
 
-static struct platform_driver s3cmci_2410_driver = {
-	.driver.name	= "s3c2410-sdi",
-	.driver.owner	= THIS_MODULE,
-	.probe		= s3cmci_2410_probe,
-	.remove		= __devexit_p(s3cmci_remove),
-	.shutdown	= s3cmci_shutdown,
-	.suspend	= s3cmci_suspend,
-	.resume		= s3cmci_resume,
-};
-
-static struct platform_driver s3cmci_2412_driver = {
-	.driver.name	= "s3c2412-sdi",
-	.driver.owner	= THIS_MODULE,
-	.probe		= s3cmci_2412_probe,
-	.remove		= __devexit_p(s3cmci_remove),
-	.shutdown	= s3cmci_shutdown,
-	.suspend	= s3cmci_suspend,
-	.resume		= s3cmci_resume,
-};
-
-static struct platform_driver s3cmci_2440_driver = {
-	.driver.name	= "s3c2440-sdi",
+static struct platform_driver s3cmci_driver = {
+	.driver.name	= "s3c-sdi",
 	.driver.owner	= THIS_MODULE,
-	.probe		= s3cmci_2440_probe,
+	.id_table	= s3cmci_driver_ids,
+	.probe		= s3cmci_probe,
 	.remove		= __devexit_p(s3cmci_remove),
 	.shutdown	= s3cmci_shutdown,
 	.suspend	= s3cmci_suspend,
 	.resume		= s3cmci_resume,
 };
 
-
 static int __init s3cmci_init(void)
 {
-	platform_driver_register(&s3cmci_2410_driver);
-	platform_driver_register(&s3cmci_2412_driver);
-	platform_driver_register(&s3cmci_2440_driver);
-	return 0;
+	return platform_driver_register(&s3cmci_driver);
 }
 
 static void __exit s3cmci_exit(void)
 {
-	platform_driver_unregister(&s3cmci_2410_driver);
-	platform_driver_unregister(&s3cmci_2412_driver);
-	platform_driver_unregister(&s3cmci_2440_driver);
+	platform_driver_unregister(&s3cmci_driver);
 }
 
 module_init(s3cmci_init);
@@ -1562,6 +1542,3 @@ module_exit(s3cmci_exit);
 MODULE_DESCRIPTION("Samsung S3C MMC/SD Card Interface driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Thomas Kleffel <tk@maintech.de>, Ben Dooks <ben-linux@fluff.org>");
-MODULE_ALIAS("platform:s3c2410-sdi");
-MODULE_ALIAS("platform:s3c2412-sdi");
-MODULE_ALIAS("platform:s3c2440-sdi");

--
