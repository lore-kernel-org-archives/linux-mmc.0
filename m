From: Azhar Shaikh <azhar.shaikh@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel controllers
Date: Tue, 28 Mar 2017 11:08:30 -0700
Message-ID: <1490724510-105153-2-git-send-email-azhar.shaikh@intel.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34436 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753247AbdC1SId (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Mar 2017 14:08:33 -0400
In-Reply-To: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, azhar.shaikh@intel.com

Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
controllers.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 86560d5..4a58a80 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -423,16 +423,15 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
+				 MMC_CAP_AGGRESSIVE_PM;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
-	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD) {
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD)
 		slot->host->mmc_host_ops.get_cd = bxt_get_cd;
-		slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
-	}
 
 	return 0;
 }
-- 
1.9.1

