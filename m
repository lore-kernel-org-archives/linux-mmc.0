From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 2/9] s3cmci: update probe to use new platform id list.
Date: Tue, 18 Aug 2009 12:56:06 +0100
Message-ID: <20090818115658.869044208@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55691 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751370AbZHRL45 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:56:57 -0400
Content-Disposition: inline; filename=s3cmci-update-probe.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

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
