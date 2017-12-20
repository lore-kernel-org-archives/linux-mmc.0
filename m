From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/9] mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
Date: Wed, 20 Dec 2017 10:18:45 +0200
Message-ID: <1513757933-11232-2-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36187 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbdLTITV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:21 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

sdhci_enable_irq_wakeups() is already called by sdhci_suspend_host() so
sdhci-pci should not need to call it. However sdhci_suspend_host() only
calls it if wakeups are enabled, and sdhci-pci does not enable them until
after calling sdhci_suspend_host(). So move the calls to
sdhci_pci_init_wakeup() before calling sdhci_suspend_host(), and
stop calling sdhci_enable_irq_wakeups(). That results in some
simplification because sdhci_pci_suspend_host() and
__sdhci_pci_suspend_host() no longer need to be separate functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 110c634cfb43..2ffc09f088ee 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -39,10 +39,29 @@
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
 #ifdef CONFIG_PM_SLEEP
-static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
+{
+	mmc_pm_flag_t pm_flags = 0;
+	int i;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		struct sdhci_pci_slot *slot = chip->slots[i];
+
+		if (slot)
+			pm_flags |= slot->host->mmc->pm_flags;
+	}
+
+	return device_init_wakeup(&chip->pdev->dev,
+				  (pm_flags & MMC_PM_KEEP_POWER) &&
+				  (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
+}
+
+static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 {
 	int i, ret;
 
+	sdhci_pci_init_wakeup(chip);
+
 	for (i = 0; i < chip->num_slots; i++) {
 		struct sdhci_pci_slot *slot = chip->slots[i];
 		struct sdhci_host *host;
@@ -58,9 +77,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 		ret = sdhci_suspend_host(host);
 		if (ret)
 			goto err_pci_suspend;
-
-		if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(host);
 	}
 
 	return 0;
@@ -71,36 +87,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 	return ret;
 }
 
-static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
-{
-	mmc_pm_flag_t pm_flags = 0;
-	int i;
-
-	for (i = 0; i < chip->num_slots; i++) {
-		struct sdhci_pci_slot *slot = chip->slots[i];
-
-		if (slot)
-			pm_flags |= slot->host->mmc->pm_flags;
-	}
-
-	return device_init_wakeup(&chip->pdev->dev,
-				  (pm_flags & MMC_PM_KEEP_POWER) &&
-				  (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
-}
-
-static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
-{
-	int ret;
-
-	ret = __sdhci_pci_suspend_host(chip);
-	if (ret)
-		return ret;
-
-	sdhci_pci_init_wakeup(chip);
-
-	return 0;
-}
-
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot;
@@ -1108,7 +1094,7 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
 {
 	int i, ret;
 
-	ret = __sdhci_pci_suspend_host(chip);
+	ret = sdhci_pci_suspend_host(chip);
 	if (ret)
 		return ret;
 
@@ -1118,8 +1104,6 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
 			jmicron_enable_mmc(chip->slots[i]->host, 0);
 	}
 
-	sdhci_pci_init_wakeup(chip);
-
 	return 0;
 }
 
-- 
1.9.1

