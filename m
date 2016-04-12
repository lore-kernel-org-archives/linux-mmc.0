From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/5] mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
Date: Tue, 12 Apr 2016 14:25:05 +0300
Message-ID: <1460460309-13619-2-git-send-email-adrian.hunter@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9541 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbcDLL3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:29:08 -0400
In-Reply-To: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Set MMC_CAP_AGGRESSIVE_PM for Broxton host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index e5c6a4917682..97d4eebd6bf5 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -386,8 +386,10 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
-	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD)
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD) {
 		slot->host->mmc_host_ops.get_cd = bxt_get_cd;
+		slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
+	}
 
 	return 0;
 }
-- 
1.9.1

