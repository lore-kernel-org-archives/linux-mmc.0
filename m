From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/2] mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers
Date: Tue, 13 Jun 2017 15:07:52 +0300
Message-ID: <1497355672-12980-3-git-send-email-adrian.hunter@intel.com>
References: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32287 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbdFMMN4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Jun 2017 08:13:56 -0400
In-Reply-To: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Enable card detect wake for Intel BYT-related SD card host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index bab7d5650401..b40d10616e3c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -803,7 +803,7 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
 	byt_read_dsm(slot);
 	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
-				 MMC_CAP_AGGRESSIVE_PM;
+				 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
-- 
1.9.1

