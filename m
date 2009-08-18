From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 4/9] s3cmci: Change to use dev_pm_ops
Date: Tue, 18 Aug 2009 12:56:08 +0100
Message-ID: <20090818115659.191590035@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55697 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758720AbZHRL47 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:56:59 -0400
Content-Disposition: inline; filename=s3cmci-use-pmops.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Move to using dev_pm_ops for suspend and resume.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/mmc/host/s3cmci.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-08-04 12:14:05.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-08-04 12:23:03.000000000 +0100
@@ -1546,35 +1546,42 @@ MODULE_DEVICE_TABLE(platform, s3cmci_dri
 
 #ifdef CONFIG_PM
 
-static int s3cmci_suspend(struct platform_device *dev, pm_message_t state)
+static int s3cmci_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
+	struct pm_message event = { PM_EVENT_SUSPEND };
 
-	return  mmc_suspend_host(mmc, state);
+	return mmc_suspend_host(mmc, event);
 }
 
-static int s3cmci_resume(struct platform_device *dev)
+static int s3cmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
 
 	return mmc_resume_host(mmc);
 }
 
+static struct dev_pm_ops s3cmci_pm = {
+	.suspend	= s3cmci_suspend,
+	.resume		= s3cmci_resume,
+};
+
+#define s3cmci_pm_ops &s3cmci_pm
 #else /* CONFIG_PM */
-#define s3cmci_suspend NULL
-#define s3cmci_resume NULL
+#define s3cmci_pm_ops NULL
 #endif /* CONFIG_PM */
 
 
 static struct platform_driver s3cmci_driver = {
-	.driver.name	= "s3c-sdi",
-	.driver.owner	= THIS_MODULE,
+	.driver	= {
+		.name	= "s3c-sdi",
+		.owner	= THIS_MODULE,
+		.pm	= s3cmci_pm_ops,
+	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
 	.remove		= __devexit_p(s3cmci_remove),
 	.shutdown	= s3cmci_shutdown,
-	.suspend	= s3cmci_suspend,
-	.resume		= s3cmci_resume,
 };
 
 static int __init s3cmci_init(void)

-- 
