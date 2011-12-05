From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 09/14] mmc: mmci: Change from using legacy suspend
Date: Mon, 5 Dec 2011 18:35:55 +0100
Message-ID: <1323106560-5218-10-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:41088 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932574Ab1LERgp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:36:45 -0500
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

This patch switch from using the legacy suspend/resume
to the new way of registering PM callbacks. No functional
change is done.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 62ad649..4560b20 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1455,10 +1455,11 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_SUSPEND
+static int mmci_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
@@ -1472,9 +1473,10 @@ static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 	return ret;
 }
 
-static int mmci_resume(struct amba_device *dev)
+static int mmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
@@ -1487,11 +1489,12 @@ static int mmci_resume(struct amba_device *dev)
 
 	return ret;
 }
-#else
-#define mmci_suspend	NULL
-#define mmci_resume	NULL
 #endif
 
+static const struct dev_pm_ops mmci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+};
+
 static struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
@@ -1535,11 +1538,10 @@ static struct amba_id mmci_ids[] = {
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
+		.pm	= &mmci_dev_pm_ops,
 	},
 	.probe		= mmci_probe,
 	.remove		= __devexit_p(mmci_remove),
-	.suspend	= mmci_suspend,
-	.resume		= mmci_resume,
 	.id_table	= mmci_ids,
 };
 
-- 
1.7.5.4

