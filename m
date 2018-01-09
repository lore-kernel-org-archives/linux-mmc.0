From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RESEND 2/9] mmc: sdhci-pci: Use device wakeup capability to determine MMC_PM_WAKE_SDIO_IRQ capability
Date: Tue,  9 Jan 2018 09:52:19 +0200
Message-ID: <1515484346-800-3-git-send-email-adrian.hunter@intel.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46300 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754742AbeAIHxE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Jan 2018 02:53:04 -0500
In-Reply-To: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

PCI and ACPI determine if a device is wakeup capable, so use that to
determine the MMC_PM_WAKE_SDIO_IRQ capability correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1711b1815630..baedb2624e36 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -50,9 +50,9 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
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

