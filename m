From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] sdhci-pci: enable SDIO interface on Intel Merrifield
Date: Mon, 29 Aug 2016 12:33:40 +0300
Message-ID: <1472463221-11948-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25757 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756953AbcH2Jdq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Aug 2016 05:33:46 -0400
In-Reply-To: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Intel Merrifield is known to have an SDIO interface and on Intel Edison board a
WiFi card is wired to it.

Enable the interface here to allow WiFi card enumeration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 40f4fe8..d38d701 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -419,6 +419,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 /* Define Host controllers for Intel Merrifield platform */
 #define INTEL_MRFLD_EMMC_0	0
 #define INTEL_MRFLD_EMMC_1	1
+#define INTEL_MRFLD_SDIO	3
 
 static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
@@ -431,6 +432,10 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 					 MMC_CAP_8_BIT_DATA |
 					 MMC_CAP_1_8V_DDR;
 		break;
+	case INTEL_MRFLD_SDIO:
+		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
+					 MMC_CAP_POWER_OFF_CARD;
+		break;
 	default:
 		/* SD support is not ready yet */
 		return -ENODEV;
-- 
2.8.1

