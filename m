From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 36/39] mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
Date: Fri, 10 Feb 2017 14:55:49 +0200
Message-ID: <1486731352-8018-37-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdBJNYQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:24:16 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

The suspend / resume callbacks lack the flexibility to allow a device to
specify a different function entirely. Change them around so that device
functions are called directly and they in turn can call the default
implementations if needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c    | 158 +++++++++++++++++++++--------------
 drivers/mmc/host/sdhci-pci-o2micro.c |   2 +-
 drivers/mmc/host/sdhci-pci.h         |   4 +
 3 files changed, 98 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 6ea6a5bce7ac..7c3c63a03dfc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -41,6 +41,82 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
 					   unsigned int max_dtr, int host_drv,
 					   int card_drv, int *drv_type);
 
+#ifdef CONFIG_PM_SLEEP
+static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+{
+	int i, ret;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		struct sdhci_pci_slot *slot = chip->slots[i];
+
+		if (!slot)
+			continue;
+
+		ret = sdhci_suspend_host(slot->host);
+		if (ret)
+			goto err_pci_suspend;
+
+		if (slot->host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+			sdhci_enable_irq_wakeups(slot->host);
+	}
+
+	return 0;
+
+err_pci_suspend:
+	while (--i >= 0)
+		sdhci_resume_host(chip->slots[i]->host);
+	return ret;
+}
+
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
+{
+	int ret;
+
+	ret = __sdhci_pci_suspend_host(chip);
+	if (ret)
+		return ret;
+
+	sdhci_pci_init_wakeup(chip);
+
+	return 0;
+}
+
+int sdhci_pci_resume_host(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot;
+	int i, ret;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		slot = chip->slots[i];
+		if (!slot)
+			continue;
+
+		ret = sdhci_resume_host(slot->host);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -78,7 +154,7 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 	/* Otherwise it becomes confused if card state changed
 		during suspend */
 	msleep(500);
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
 
@@ -722,7 +798,11 @@ static void jmicron_remove_slot(struct sdhci_pci_slot *slot, int dead)
 #ifdef CONFIG_PM_SLEEP
 static int jmicron_suspend(struct sdhci_pci_chip *chip)
 {
-	int i;
+	int i, ret;
+
+	ret = __sdhci_pci_suspend_host(chip);
+	if (ret)
+		return ret;
 
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB38X_MMC ||
 	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD) {
@@ -730,6 +810,8 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
 			jmicron_enable_mmc(chip->slots[i]->host, 0);
 	}
 
+	sdhci_pci_init_wakeup(chip);
+
 	return 0;
 }
 
@@ -749,7 +831,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 		return ret;
 	}
 
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
 
@@ -1657,83 +1739,29 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
 static int sdhci_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip;
-	struct sdhci_pci_slot *slot;
-	mmc_pm_flag_t slot_pm_flags;
-	mmc_pm_flag_t pm_flags = 0;
-	int i, ret;
+	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
 
-	chip = pci_get_drvdata(pdev);
 	if (!chip)
 		return 0;
 
-	for (i = 0; i < chip->num_slots; i++) {
-		slot = chip->slots[i];
-		if (!slot)
-			continue;
-
-		ret = sdhci_suspend_host(slot->host);
+	if (chip->fixes && chip->fixes->suspend)
+		return chip->fixes->suspend(chip);
 
-		if (ret)
-			goto err_pci_suspend;
-
-		slot_pm_flags = slot->host->mmc->pm_flags;
-		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(slot->host);
-
-		pm_flags |= slot_pm_flags;
-	}
-
-	if (chip->fixes && chip->fixes->suspend) {
-		ret = chip->fixes->suspend(chip);
-		if (ret)
-			goto err_pci_suspend;
-	}
-
-	if (pm_flags & MMC_PM_KEEP_POWER) {
-		if (pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			device_init_wakeup(dev, true);
-		else
-			device_init_wakeup(dev, false);
-	} else
-		device_init_wakeup(dev, false);
-
-	return 0;
-
-err_pci_suspend:
-	while (--i >= 0)
-		sdhci_resume_host(chip->slots[i]->host);
-	return ret;
+	return sdhci_pci_suspend_host(chip);
 }
 
 static int sdhci_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip;
-	struct sdhci_pci_slot *slot;
-	int i, ret;
+	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
 
-	chip = pci_get_drvdata(pdev);
 	if (!chip)
 		return 0;
 
-	if (chip->fixes && chip->fixes->resume) {
-		ret = chip->fixes->resume(chip);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < chip->num_slots; i++) {
-		slot = chip->slots[i];
-		if (!slot)
-			continue;
+	if (chip->fixes && chip->fixes->resume)
+		return chip->fixes->resume(chip);
 
-		ret = sdhci_resume_host(slot->host);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 0ea34e2c7cba..14273ca00641 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -388,6 +388,6 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 {
 	sdhci_pci_o2_probe(chip);
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 47869bc20c59..182c95894768 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -106,4 +106,8 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };
 
+#ifdef CONFIG_PM_SLEEP
+int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
+#endif
+
 #endif /* __SDHCI_PCI_H */
-- 
1.9.1

