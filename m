From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/11] mmc: sdhci-pci-core: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
Date: Wed, 27 Jul 2016 13:31:57 +0200
Message-ID: <1469619127-29283-2-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35861 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbcG0LcO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:14 -0400
Received: by mail-lf0-f45.google.com with SMTP id g62so25072506lfe.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:13 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Convert to define the system PM callbacks to be build for CONFIG_PM_SLEEP
and use the SET_SYSTEM_SLEEP_PM_OPS. In this way the code becomes cleaner.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index bdda3d0..897cfd2 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1413,8 +1413,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1496,7 +1495,9 @@ static int sdhci_pci_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
+#ifdef CONFIG_PM
 static int sdhci_pci_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1562,17 +1563,10 @@ static int sdhci_pci_runtime_resume(struct device *dev)
 
 	return 0;
 }
-
-#else /* CONFIG_PM */
-
-#define sdhci_pci_suspend NULL
-#define sdhci_pci_resume NULL
-
-#endif /* CONFIG_PM */
+#endif
 
 static const struct dev_pm_ops sdhci_pci_pm_ops = {
-	.suspend = sdhci_pci_suspend,
-	.resume = sdhci_pci_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pci_suspend, sdhci_pci_resume)
 	SET_RUNTIME_PM_OPS(sdhci_pci_runtime_suspend,
 			sdhci_pci_runtime_resume, NULL)
 };
-- 
1.9.1

