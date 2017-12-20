From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/9] mmc: sdhci-pci: Use device wakeup capability to determine MMC_PM_WAKE_SDIO_IRQ capability
Date: Wed, 20 Dec 2017 10:18:46 +0200
Message-ID: <1513757933-11232-3-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36183 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754104AbdLTITX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:23 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

PCI and ACPI determine if a device is wakeup capable, so use that to
determine the MMC_PM_WAKE_SDIO_IRQ capability correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 2ffc09f088ee..96ec4aa7cb27 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -51,9 +51,9 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 			pm_flags |= slot->host->mmc->pm_flags;
 	}
 
-	return device_init_wakeup(&chip->pdev->dev,
-				  (pm_flags & MMC_PM_KEEP_POWER) &&
-				  (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
+	return device_set_wakeup_enable(&chip->pdev->dev,
+					(pm_flags & MMC_PM_KEEP_POWER) &&
+					(pm_flags & MMC_PM_WAKE_SDIO_IRQ));
 }
 
 static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
@@ -1680,10 +1680,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		}
 	}
 
-	host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
+	host->mmc->pm_caps = MMC_PM_KEEP_POWER;
 	host->mmc->slotno = slotno;
 	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
 
+	if (device_can_wakeup(&pdev->dev))
+		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
 	if (slot->cd_idx >= 0) {
 		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
 					   slot->cd_override_level, 0, NULL);
-- 
1.9.1

