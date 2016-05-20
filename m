From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-pci: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
Date: Fri, 20 May 2016 10:33:47 +0300
Message-ID: <1463729628-3517-3-git-send-email-adrian.hunter@intel.com>
References: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbcETHhu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2016 03:37:50 -0400
In-Reply-To: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The CMD19/CMD14 bus width test has been found to be unreliable in
some cases.  It is not essential, so simply remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 97d4eebd6bf5..a4dbf7421edc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -356,7 +356,6 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
-				 MMC_CAP_BUS_WIDTH_TEST |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 	slot->hw_reset = sdhci_pci_int_hw_reset;
@@ -372,15 +371,13 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
-				 MMC_CAP_BUS_WIDTH_TEST |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
 }
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST |
-				 MMC_CAP_WAIT_WHILE_BUSY;
+	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	slot->cd_con_id = NULL;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
-- 
1.9.1

