From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 1/5] mmc: sdhci: Do not call implementations of mmc host ops directly
Date: Tue, 28 Jun 2016 16:23:08 +0300
Message-ID: <1467120192-6479-2-git-send-email-adrian.hunter@intel.com>
References: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52439 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbcF1Na2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2016 09:30:28 -0400
In-Reply-To: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>

Drivers must be able to provide their own implementations for mmc host
operations. Consequently, SDHCI should call those not the default
implementations. Do that by calling indirectly through the mmc host ops
function pointers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 15bdbcb99170..7009c862ca9b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -46,9 +46,7 @@ static unsigned int debug_quirks2;
 static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_finish_command(struct sdhci_host *);
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-static int sdhci_get_cd(struct mmc_host *mmc);
 
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
@@ -193,7 +191,9 @@ EXPORT_SYMBOL_GPL(sdhci_reset);
 static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
-		if (!sdhci_get_cd(host->mmc))
+		struct mmc_host *mmc = host->mmc;
+
+		if (!mmc->ops->get_cd(mmc))
 			return;
 	}
 
@@ -210,10 +210,10 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
+	struct mmc_host *mmc = host->mmc;
+
 	if (soft)
 		sdhci_do_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
@@ -231,7 +231,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	if (soft) {
 		/* force clock reconfiguration */
 		host->clock = 0;
-		sdhci_set_ios(host->mmc, &host->mmc->ios);
+		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
 }
 
@@ -2096,7 +2096,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	if (host->ops->card_event)
 		host->ops->card_event(host);
 
-	present = sdhci_get_cd(host->mmc);
+	present = mmc->ops->get_cd(mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2582,8 +2582,10 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
-		sdhci_card_event(host->mmc);
-		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+		struct mmc_host *mmc = host->mmc;
+
+		mmc->ops->card_event(mmc);
+		mmc_detect_change(mmc, msecs_to_jiffies(200));
 	}
 
 	if (isr & SDHCI_INT_CARD_INT) {
@@ -2667,6 +2669,7 @@ EXPORT_SYMBOL_GPL(sdhci_suspend_host);
 
 int sdhci_resume_host(struct sdhci_host *host)
 {
+	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -2680,7 +2683,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 		sdhci_init(host, 0);
 		host->pwr = 0;
 		host->clock = 0;
-		sdhci_set_ios(host->mmc, &host->mmc->ios);
+		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
 		mmiowb();
@@ -2729,6 +2732,7 @@ EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
 int sdhci_runtime_resume_host(struct sdhci_host *host)
 {
+	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
 	int host_flags = host->flags;
 
@@ -2742,8 +2746,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	/* Force clock and power re-program */
 	host->pwr = 0;
 	host->clock = 0;
-	sdhci_start_signal_voltage_switch(host->mmc, &host->mmc->ios);
-	sdhci_set_ios(host->mmc, &host->mmc->ios);
+	mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
+	mmc->ops->set_ios(mmc, &mmc->ios);
 
 	if ((host_flags & SDHCI_PV_ENABLED) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
-- 
1.9.1

