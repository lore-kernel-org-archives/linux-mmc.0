From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci-pci: Add two host capabilities for BYT
Date: Mon,  1 Dec 2014 15:51:18 +0200
Message-ID: <1417441879-28058-4-git-send-email-adrian.hunter@intel.com>
References: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35203 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbaLANxC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:53:02 -0500
In-Reply-To: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

BYT host controllers are capable of doing the bus
width test and of waiting while busy, so add the
capability flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 632e9d9..95f7300 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -269,7 +269,9 @@ static void sdhci_pci_int_hw_reset(struct sdhci_host *host)
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
-				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR;
+				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
+				 MMC_CAP_BUS_WIDTH_TEST |
+				 MMC_CAP_WAIT_WHILE_BUSY;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 	slot->hw_reset = sdhci_pci_int_hw_reset;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_EMMC)
@@ -279,12 +281,16 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
+				 MMC_CAP_BUS_WIDTH_TEST |
+				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
 }
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
+	slot->host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST |
+				 MMC_CAP_WAIT_WHILE_BUSY;
 	slot->cd_con_id = NULL;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
-- 
1.9.1

