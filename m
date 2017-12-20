From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 9/9] mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup
Date: Wed, 20 Dec 2017 10:18:53 +0200
Message-ID: <1513757933-11232-10-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932260AbdLTITe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:34 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
cd_irq") enabled wakeup irrespective of the host controller's PM flags.
However, users also want to control it from sysfs power/wakeup attribute.
That means the driver needs to check the PM flags before enabling it in the
suspend callback. Add support for that in sdhci-pci, which is the only
driver presently using the MMC_CAP_CD_WAKE flag, and remove the enabling in
mmc_gpiod_request_cd_irq().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/slot-gpio.c      |  2 --
 drivers/mmc/host/sdhci-pci-core.c | 18 ++++++++++++++----
 drivers/mmc/host/sdhci.c          |  4 ++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 3a30535c2f31..74dd534905f7 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -149,8 +149,6 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 
 	if (irq < 0)
 		host->caps |= MMC_CAP_NEEDS_POLL;
-	else if ((host->caps & MMC_CAP_CD_WAKE) && !enable_irq_wake(irq))
-		host->slot.cd_wake_enabled = true;
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 96ec4aa7cb27..eeb4bd5797a0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -42,18 +42,25 @@
 static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 {
 	mmc_pm_flag_t pm_flags = 0;
+	bool cap_cd_wake = false;
 	int i;
 
 	for (i = 0; i < chip->num_slots; i++) {
 		struct sdhci_pci_slot *slot = chip->slots[i];
 
-		if (slot)
+		if (slot) {
 			pm_flags |= slot->host->mmc->pm_flags;
+			if (slot->host->mmc->caps & MMC_CAP_CD_WAKE)
+				cap_cd_wake = true;
+		}
 	}
 
-	return device_set_wakeup_enable(&chip->pdev->dev,
-					(pm_flags & MMC_PM_KEEP_POWER) &&
-					(pm_flags & MMC_PM_WAKE_SDIO_IRQ));
+	if ((pm_flags & MMC_PM_KEEP_POWER) && (pm_flags & MMC_PM_WAKE_SDIO_IRQ))
+		return device_wakeup_enable(&chip->pdev->dev);
+	else if (!cap_cd_wake)
+		return device_wakeup_disable(&chip->pdev->dev);
+
+	return 0;
 }
 
 static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
@@ -1687,6 +1694,9 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (device_can_wakeup(&pdev->dev))
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	if (host->mmc->caps & MMC_CAP_CD_WAKE)
+		device_init_wakeup(&pdev->dev, true);
+
 	if (slot->cd_idx >= 0) {
 		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
 					   slot->cd_override_level, 0, NULL);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c82fd16dd14e..883b55077231 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2891,6 +2891,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
 		free_irq(host->irq, host);
 	}
 
+	mmc_gpio_set_cd_wake(host->mmc, true);
+
 	return 0;
 }
 
@@ -2918,6 +2920,8 @@ int sdhci_resume_host(struct sdhci_host *host)
 		mmiowb();
 	}
 
+	mmc_gpio_set_cd_wake(host->mmc, false);
+
 	if (host->irq_wake_enabled) {
 		sdhci_disable_irq_wakeups(host);
 	} else {
-- 
1.9.1

