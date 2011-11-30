From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: use the dev_pm_ops for dw_mmccontroller
Date: Wed, 30 Nov 2011 13:58:05 +0900
Message-ID: <4ED5B7DD.1060609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20459 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab1K3E6K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 23:58:10 -0500
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVG00CNEJ4WCBL0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 13:58:09 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVG00EHNJ4WLW40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 13:58:08 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Dw_mmc controller didn't use dev_pm_ops.
This patch modified to use the dev_mp_ops for dw_mmc controller

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3aaeb08..fc9beea 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2066,10 +2066,10 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
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
@@ -2128,17 +2128,23 @@ static int dw_mci_resume(struct platform_device *pdev)
 
 	return 0;
 }
+
+static const struct dev_pm_ops dw_mci_pmops = {
+	.suspend	= dw_mci_suspend,
+	.resume		= dw_mci_resume,
+};
+
+#define DW_MCI_PMOPS	(&dw_mci_pmops)
+
 #else
-#define dw_mci_suspend	NULL
-#define dw_mci_resume	NULL
+#define DW_MCI_PMOPS	NULL
 #endif /* CONFIG_PM */
 
 static struct platform_driver dw_mci_driver = {
 	.remove		= __exit_p(dw_mci_remove),
-	.suspend	= dw_mci_suspend,
-	.resume		= dw_mci_resume,
 	.driver		= {
 		.name		= "dw_mmc",
+		.pm		= DW_MCI_PMOPS,
 	},
 };
 
