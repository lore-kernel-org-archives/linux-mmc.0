From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3] mmc: dw_mmc: use the dev_pm_ops for dw_mmc controller
Date: Thu, 08 Dec 2011 19:23:03 +0900
Message-ID: <4EE09007.6030800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39216 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab1LHKXF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 05:23:05 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVV00M6IRIA1ZI0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Dec 2011 19:23:04 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVV005Y4RIFJK30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Dec 2011 19:23:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.com>, Will Newton <will.newton@imgtec.com>

Dw_mmc controller didn't use dev_pm_ops.
This patch modified to use the dev_pm_ops for dw_mmc controller

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v3:
	- Change CONFIG_PM_SLEEP instead of CONFIG_PM
	- using static for SIMPLE_DEV_PM_OPS
Changelog v2:
	- Use the Macro for dev_pm_ops

 drivers/mmc/host/dw_mmc.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3aaeb08..44bc11e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2062,14 +2062,14 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
  */
-static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int dw_mci_suspend(struct device *dev)
 {
 	int i, ret;
-	struct dw_mci *host = platform_get_drvdata(pdev);
+	struct dw_mci *host = dev_get_drvdata(dev);
 
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
@@ -2092,10 +2092,10 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
-static int dw_mci_resume(struct platform_device *pdev)
+static int dw_mci_resume(struct device *dev)
 {
 	int i, ret;
-	struct dw_mci *host = platform_get_drvdata(pdev);
+	struct dw_mci *host = dev_get_drvdata(dev);
 
 	if (host->vmmc)
 		regulator_enable(host->vmmc);
@@ -2103,7 +2103,7 @@ static int dw_mci_resume(struct platform_device *pdev)
 	if (host->dma_ops->init)
 		host->dma_ops->init(host);
 
-	if (!mci_wait_reset(&pdev->dev, host)) {
+	if (!mci_wait_reset(dev, host)) {
 		ret = -ENODEV;
 		return ret;
 	}
@@ -2131,14 +2131,15 @@ static int dw_mci_resume(struct platform_device *pdev)
 #else
 #define dw_mci_suspend	NULL
 #define dw_mci_resume	NULL
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(dw_mci_pmops, dw_mci_suspend, dw_mci_resume);
 
 static struct platform_driver dw_mci_driver = {
 	.remove		= __exit_p(dw_mci_remove),
-	.suspend	= dw_mci_suspend,
-	.resume		= dw_mci_resume,
 	.driver		= {
 		.name		= "dw_mmc",
+		.pm		= &dw_mci_pmops,
 	},
 };

 -- 
1.7.4.1
