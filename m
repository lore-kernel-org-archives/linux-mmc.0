From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci-pci: select HC erase size for Medfield eMMC
Date: Tue,  7 Feb 2012 14:48:53 +0200
Message-ID: <1328618935-25175-3-git-send-email-adrian.hunter@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2BGMs4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 07:48:56 -0500
In-Reply-To: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 6ebdc40..9952535 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -244,7 +244,8 @@ static inline void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
 static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
-	slot->host->mmc->caps2 = MMC_CAP2_BOOTPART_NOACC;
+	slot->host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC |
+				  MMC_CAP2_HC_ERASE_SZ;
 	return 0;
 }
 
-- 
1.7.6.4

