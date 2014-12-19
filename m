From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-pci: Remove redundant runtime PM idle callback
Date: Fri, 19 Dec 2014 10:52:56 +0100
Message-ID: <1418982776-8176-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:49029 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaLSJxB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 04:53:01 -0500
Received: by mail-la0-f41.google.com with SMTP id hv19so521685lab.14
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 01:53:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0342775..2842066 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1342,11 +1342,6 @@ static int sdhci_pci_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sdhci_pci_runtime_idle(struct device *dev)
-{
-	return 0;
-}
-
 #else /* CONFIG_PM */
 
 #define sdhci_pci_suspend NULL
@@ -1358,7 +1353,7 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
 	.suspend = sdhci_pci_suspend,
 	.resume = sdhci_pci_resume,
 	SET_RUNTIME_PM_OPS(sdhci_pci_runtime_suspend,
-			sdhci_pci_runtime_resume, sdhci_pci_runtime_idle)
+			sdhci_pci_runtime_resume, NULL)
 };
 
 /*****************************************************************************\
-- 
1.9.1

