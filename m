From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 2/2] mmc: sdhci-pxav3: use runtime_pm enabled pltfm suspend/resume
Date: Thu, 21 May 2015 09:15:04 +0200
Message-ID: <1432192504-3601-2-git-send-email-stefan@agner.ch>
References: <1432192504-3601-1-git-send-email-stefan@agner.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:49659 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbEUHPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2015 03:15:10 -0400
In-Reply-To: <1432192504-3601-1-git-send-email-stefan@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: gregory.clement@free-electrons.com, zhangfei.gao@marvell.com, jszhang@marvell.com, chris@printf.net, anton@enomsg.org, b29396@freescale.com, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch

Use the runtime_pm enabled platform suspend/resume functions.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-pxav3.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index b5103a2..5ac4030 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -501,34 +501,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pxav3_suspend(struct device *dev)
-{
-	int ret;
-	struct sdhci_host *host = dev_get_drvdata(dev);
-
-	pm_runtime_get_sync(dev);
-	ret = sdhci_suspend_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
-	return ret;
-}
-
-static int sdhci_pxav3_resume(struct device *dev)
-{
-	int ret;
-	struct sdhci_host *host = dev_get_drvdata(dev);
-
-	pm_runtime_get_sync(dev);
-	ret = sdhci_resume_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_PM
 static int sdhci_pxav3_runtime_suspend(struct device *dev)
 {
@@ -564,7 +536,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_pxav3_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_rpm_suspend, sdhci_pltfm_rpm_resume)
 	SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
 		sdhci_pxav3_runtime_resume, NULL)
 };
-- 
2.4.1

