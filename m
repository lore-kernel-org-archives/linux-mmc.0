From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/4] mmc: sdhci: fix vmmc handling
Date: Wed,  2 Nov 2011 08:57:18 +0200
Message-ID: <1320217041-2580-2-git-send-email-adrian.hunter@intel.com>
References: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2615 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab1KBG5g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Nov 2011 02:57:36 -0400
In-Reply-To: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Presently the vmmc regulator is enabled when the host
controller is added and disabled when it is removed.
However, the vmmc regulator should be under the control
of the upper layers via ->set_ios().  Make it so.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..5b01eff 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1160,7 +1160,7 @@ out:
 	host->clock = clock;
 }
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
+static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
 
@@ -1183,13 +1183,13 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	}
 
 	if (host->pwr == pwr)
-		return;
+		return -1;
 
 	host->pwr = pwr;
 
 	if (pwr == 0) {
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
-		return;
+		return 0;
 	}
 
 	/*
@@ -1216,6 +1216,8 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 		mdelay(10);
+
+	return power;
 }
 
 /*****************************************************************************\
@@ -1297,12 +1299,17 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
 	unsigned long flags;
+	int vdd_bit = -1;
 	u8 ctrl;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (host->flags & SDHCI_DEVICE_DEAD)
-		goto out;
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		if (host->vmmc && ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
+		return;
+	}
 
 	/*
 	 * Reset the chip on each power off.
@@ -1316,9 +1323,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	sdhci_set_clock(host, ios->clock);
 
 	if (ios->power_mode == MMC_POWER_OFF)
-		sdhci_set_power(host, -1);
+		vdd_bit = sdhci_set_power(host, -1);
 	else
-		sdhci_set_power(host, ios->vdd);
+		vdd_bit = sdhci_set_power(host, ios->vdd);
+
+	if (host->vmmc && vdd_bit != -1) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd_bit);
+		spin_lock_irqsave(&host->lock, flags);
+	}
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
@@ -1443,7 +1456,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -2347,9 +2359,6 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	free_irq(host->irq, host);
 
-	if (host->vmmc)
-		ret = regulator_disable(host->vmmc);
-
 	return ret;
 }
 
@@ -2359,12 +2368,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 {
 	int ret;
 
-	if (host->vmmc) {
-		int ret = regulator_enable(host->vmmc);
-		if (ret)
-			return ret;
-	}
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
@@ -2926,8 +2929,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (IS_ERR(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
-	} else {
-		regulator_enable(host->vmmc);
 	}
 
 	sdhci_init(host, 0);
@@ -3016,10 +3017,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
-	if (host->vmmc) {
-		regulator_disable(host->vmmc);
+	if (host->vmmc)
 		regulator_put(host->vmmc);
-	}
 
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
-- 
1.7.6.4

