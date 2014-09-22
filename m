From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/13] mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
Date: Mon, 22 Sep 2014 13:17:43 +0300
Message-ID: <1411381064-1703-13-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33216 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbaIVKTd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:33 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Braswell eMMC host controller specifies an incorrect
timeout clock frequncy in the capabilities registers.
The correct value is 1 MHz.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 39499fb..9e791e9 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -272,6 +272,8 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 	slot->hw_reset = sdhci_pci_int_hw_reset;
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_EMMC)
+		slot->host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 	return 0;
 }
 
-- 
1.8.3.2

