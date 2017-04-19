From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers
Date: Wed, 19 Apr 2017 16:09:23 +0300
Message-ID: <1492607363-5346-3-git-send-email-adrian.hunter@intel.com>
References: <1492607363-5346-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763519AbdDSNPI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:08 -0400
In-Reply-To: <1492607363-5346-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Enable card detect wake for Intel BYT-related SD card host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 +++
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 833072b8453e..57d6f50b73dc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -634,6 +634,7 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 				 MMC_CAP_AGGRESSIVE_PM;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
+	slot->cd_wake = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
@@ -1989,6 +1990,8 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		if (ret) {
 			dev_warn(&pdev->dev, "failed to setup card detect gpio\n");
 			slot->cd_idx = -1;
+		} else if (slot->cd_wake) {
+			mmc_gpio_cd_enable_wake(host->mmc);
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 37766d20a600..6029fb314421 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -91,6 +91,7 @@ struct sdhci_pci_slot {
 
 	int			cd_idx;
 	bool			cd_override_level;
+	bool			cd_wake;
 
 	void (*hw_reset)(struct sdhci_host *host);
 	unsigned long		private[0] ____cacheline_aligned;
-- 
1.9.1

