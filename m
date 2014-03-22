From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 2/2] mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS
Date: Sat, 22 Mar 2014 12:52:46 +0400
Message-ID: <1395478366-6276-2-git-send-email-shc_work@mail.ru>
References: <1395478366-6276-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.mail.ru ([94.100.176.129]:46219 "EHLO smtp1.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbaCVIxE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Mar 2014 04:53:04 -0400
In-Reply-To: <1395478366-6276-1-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Anatolij Gustschin <agust@denx.de>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mmc/host/mxcmmc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 84d630e..86401c0 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1220,8 +1220,7 @@ static int mxcmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mxcmci_suspend(struct device *dev)
+static int __maybe_unused mxcmci_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct mxcmci_host *host = mmc_priv(mmc);
@@ -1231,7 +1230,7 @@ static int mxcmci_suspend(struct device *dev)
 	return 0;
 }
 
-static int mxcmci_resume(struct device *dev)
+static int __maybe_unused mxcmci_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct mxcmci_host *host = mmc_priv(mmc);
@@ -1241,11 +1240,7 @@ static int mxcmci_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops mxcmci_pm_ops = {
-	.suspend	= mxcmci_suspend,
-	.resume		= mxcmci_resume,
-};
-#endif
+static SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
@@ -1254,9 +1249,7 @@ static struct platform_driver mxcmci_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.owner		= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &mxcmci_pm_ops,
-#endif
 		.of_match_table	= mxcmci_of_match,
 	}
 };
-- 
1.8.3.2

