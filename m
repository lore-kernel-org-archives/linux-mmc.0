From: akpm@linux-foundation.org
Subject: [patch 21/42] s3cmci: change to use dev_pm_ops
Date: Thu, 01 Oct 2009 15:44:15 -0700
Message-ID: <200910012244.n91MiFMf008814@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33225 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753715AbZJAWoR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 18:44:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben@simtec.co.uk, linux-mmc@vger.kernel.org

From: Ben Dooks <ben@simtec.co.uk>

Move to using dev_pm_ops for suspend and resume.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff -puN drivers/mmc/host/s3cmci.c~s3cmci-change-to-use-dev_pm_ops drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~s3cmci-change-to-use-dev_pm_ops
+++ a/drivers/mmc/host/s3cmci.c
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
_
