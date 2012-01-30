From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci: always reset all during resume
Date: Mon, 30 Jan 2012 14:27:19 +0200
Message-ID: <1327926439-23603-3-git-send-email-adrian.hunter@intel.com>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31965 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab2A3M12 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 07:27:28 -0500
In-Reply-To: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>

During suspend the host controller may or may not be powered off.
In order to get the same result either way, always perform a
software "reset all" when resuming.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Rakity <prakity@marvell.com>
Cc: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..ef2434c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -219,31 +219,20 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-
-static void sdhci_init(struct sdhci_host *host, int soft)
+static void sdhci_init(struct sdhci_host *host)
 {
-	if (soft)
-		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
-	else
-		sdhci_reset(host, SDHCI_RESET_ALL);
+	sdhci_reset(host, SDHCI_RESET_ALL);
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
 		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
 		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
-
-	if (soft) {
-		/* force clock reconfiguration */
-		host->clock = 0;
-		sdhci_set_ios(host->mmc, &host->mmc->ios);
-	}
 }
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
-	sdhci_init(host, 0);
+	sdhci_init(host);
 	sdhci_enable_card_detection(host);
 }
 
@@ -2423,8 +2412,12 @@ int sdhci_resume_host(struct sdhci_host *host)
 	if (ret)
 		return ret;
 
-	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
-	mmiowb();
+	sdhci_init(host);
+
+	/* Force clock and power re-program */
+	host->pwr = 0;
+	host->clock = 0;
+	sdhci_do_set_ios(host, &host->mmc->ios);
 
 	ret = mmc_resume_host(host->mmc);
 	sdhci_enable_card_detection(host);
@@ -2500,7 +2493,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	sdhci_init(host, 0);
+	sdhci_init(host);
 
 	/* Force clock and power re-program */
 	host->pwr = 0;
@@ -2980,7 +2973,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->vmmc = NULL;
 	}
 
-	sdhci_init(host, 0);
+	sdhci_init(host);
 
 #ifdef CONFIG_MMC_DEBUG
 	sdhci_dumpregs(host);
-- 
1.7.6.4

