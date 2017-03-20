From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 23/25] mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
Date: Mon, 20 Mar 2017 19:50:51 +0200
Message-ID: <1490032253-6030-24-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11877 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756121AbdCTR6t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:49 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

The suspend / resume callbacks lack the flexibility to allow a device to
specify a different function entirely. Change them around so that device
functions are called directly and they in turn can call the default
implementations if needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c    | 170 ++++++++++++++++++++---------------
 drivers/mmc/host/sdhci-pci-o2micro.c |   2 +-
 drivers/mmc/host/sdhci-pci.h         |   4 +
 3 files changed, 104 insertions(+), 72 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 47a3965dff4d..5ed8369704fd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -37,6 +37,88 @@
 static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
+#ifdef CONFIG_PM_SLEEP
+static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+{
+	int i, ret;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		struct sdhci_pci_slot *slot = chip->slots[i];
+		struct sdhci_host *host;
+
+		if (!slot)
+			continue;
+
+		host = slot->host;
+
+		if (chip->pm_retune && host->tuning_mode != SDHCI_TUNING_MODE_3)
+			mmc_retune_needed(host->mmc);
+
+		ret = sdhci_suspend_host(host);
+		if (ret)
+			goto err_pci_suspend;
+
+		if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+			sdhci_enable_irq_wakeups(host);
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
@@ -74,7 +156,7 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 	/* Otherwise it becomes confused if card state changed
 		during suspend */
 	msleep(500);
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
 
@@ -758,7 +840,11 @@ static void jmicron_remove_slot(struct sdhci_pci_slot *slot, int dead)
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
@@ -766,6 +852,8 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
 			jmicron_enable_mmc(chip->slots[i]->host, 0);
 	}
 
+	sdhci_pci_init_wakeup(chip);
+
 	return 0;
 }
 
@@ -785,7 +873,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 		return ret;
 	}
 
-	return 0;
+	return sdhci_pci_resume_host(chip);
 }
 #endif
 
@@ -1678,89 +1766,29 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 static int sdhci_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip;
-	struct sdhci_pci_slot *slot;
-	struct sdhci_host *host;
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
-		host = slot->host;
-
-		if (chip->pm_retune && host->tuning_mode != SDHCI_TUNING_MODE_3)
-			mmc_retune_needed(host->mmc);
-
-		ret = sdhci_suspend_host(host);
-
-		if (ret)
-			goto err_pci_suspend;
-
-		slot_pm_flags = host->mmc->pm_flags;
-		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(host);
+	if (chip->fixes && chip->fixes->suspend)
+		return chip->fixes->suspend(chip);
 
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
-
-		ret = sdhci_resume_host(slot->host);
-		if (ret)
-			return ret;
-	}
+	if (chip->fixes && chip->fixes->resume)
+		return chip->fixes->resume(chip);
 
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
index e70a27058e0b..ec8f91c403d6 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -111,4 +111,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
+#endif
+
 #endif /* __SDHCI_PCI_H */
-- 
1.9.1

