From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 3/4] mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
Date: Thu,  6 Nov 2014 15:19:05 +0200
Message-ID: <1415279946-5054-4-git-send-email-adrian.hunter@intel.com>
References: <1415279946-5054-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57179 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaKFNUn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Nov 2014 08:20:43 -0500
In-Reply-To: <1415279946-5054-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

1.2V HS200 mode capability is cleared if there is not a voltage
regulator that supports 1.2V.  Do the same for 1.2V HS400 mode.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 13 +++++++------
 include/linux/mmc/host.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c2f4754..5589563 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3115,16 +3115,17 @@ int sdhci_add_host(struct sdhci_host *host)
 		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
 		 * field can be promoted to support HS200.
 		 */
-		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
+		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
 			mmc->caps2 |= MMC_CAP2_HS200;
-			if (IS_ERR(mmc->supply.vqmmc) ||
-					!regulator_is_supported_voltage
-					(mmc->supply.vqmmc, 1100000, 1300000))
-				mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
-		}
 	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
+	if ((mmc->caps2 & MMC_CAP2_HSX00_1_2V) &&
+	    (IS_ERR(mmc->supply.vqmmc) ||
+	     !regulator_is_supported_voltage(mmc->supply.vqmmc, 1100000,
+					     1300000)))
+		mmc->caps2 &= ~MMC_CAP2_HSX00_1_2V;
+
 	if ((caps[1] & SDHCI_SUPPORT_DDR50) &&
 		!(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
 		mmc->caps |= MMC_CAP_UHS_DDR50;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index df0c153..9f32270 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -289,6 +289,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
 #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
 				 MMC_CAP2_HS400_1_2V)
+#define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
-- 
1.9.1

