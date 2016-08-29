From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] sdhci-pci: refactor intel_mrfld_mmc_probe_slot()
Date: Mon, 29 Aug 2016 12:33:39 +0300
Message-ID: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58114 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756950AbcH2Jdr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Aug 2016 05:33:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Refactor intel_mrfld_mmc_probe_slot() to use switch case. The change allows to
add a support for SD and SDIO interfaces without any pain.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 93bb0ff..40f4fe8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -422,14 +422,19 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 
 static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
-	if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_0) &&
-	    (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_1))
+	unsigned int func = PCI_FUNC(slot->chip->pdev->devfn);
+
+	switch (func) {
+	case INTEL_MRFLD_EMMC_0:
+	case INTEL_MRFLD_EMMC_1:
+		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
+					 MMC_CAP_8_BIT_DATA |
+					 MMC_CAP_1_8V_DDR;
+		break;
+	default:
 		/* SD support is not ready yet */
 		return -ENODEV;
-
-	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
-				 MMC_CAP_1_8V_DDR;
-
+	}
 	return 0;
 }
 
-- 
2.8.1

