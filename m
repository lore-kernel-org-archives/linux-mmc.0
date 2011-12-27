From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 1/7] mmc: sdhci: fix vmmc handling
Date: Tue, 27 Dec 2011 15:48:41 +0200
Message-ID: <1324993727-7508-2-git-send-email-adrian.hunter@intel.com>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab1L0NtF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 08:49:05 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Presently the vmmc regulator is enabled when the host
controller is added and disabled when it is removed.
However, the vmmc regulator should be under the control
of the upper layers via ->set_ios().  Make it so.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..6a35d03 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1170,7 +1170,7 @@ out:
 	host->clock = clock;
 }
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
+static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
 
@@ -1193,13 +1193,13 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
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
@@ -1226,6 +1226,8 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 		mdelay(10);
+
+	return power;
 }
 
 /*****************************************************************************\
@@ -1307,12 +1309,17 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -1326,9 +1333,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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
@@ -1453,7 +1466,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -2357,9 +2369,6 @@ int sdhci_suspend_host(struct sdhci_host *host)
 
 	free_irq(host->irq, host);
 
-	if (host->vmmc)
-		ret = regulator_disable(host->vmmc);
-
 	return ret;
 }
 
@@ -2369,12 +2378,6 @@ int sdhci_resume_host(struct sdhci_host *host)
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
@@ -2936,8 +2939,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (IS_ERR(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
-	} else {
-		regulator_enable(host->vmmc);
 	}
 
 	sdhci_init(host, 0);
@@ -3026,10 +3027,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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

