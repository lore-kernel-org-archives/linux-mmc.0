From: Azhar Shaikh <azhar.shaikh@intel.com>
Subject: [PATCH v2 2/2] mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel controllers
Date: Wed, 29 Mar 2017 11:16:33 -0700
Message-ID: <1490811393-109654-2-git-send-email-azhar.shaikh@intel.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
 <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14328 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932650AbdC2SQh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Mar 2017 14:16:37 -0400
In-Reply-To: <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, azhar.shaikh@intel.com

Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
controllers.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
Changes in v2:
  - Rebased the patch on top of 'next' branch.
  - No code change.

 drivers/mmc/host/sdhci-pci-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 6c0440e..833072b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -630,16 +630,15 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
 	byt_read_dsm(slot);
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

