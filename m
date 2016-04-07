From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] mmc: sdhci: Remove redundant runtime PM calls
Date: Thu,  7 Apr 2016 10:56:39 +0200
Message-ID: <1460019399-922-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33350 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbcDGI4z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2016 04:56:55 -0400
Received: by mail-lb0-f180.google.com with SMTP id u8so45588324lbk.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2016 01:56:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Moreover as SDHCI have its own wrapper functions for runtime PM these
becomes superfluous, so let's remove them as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Remove also redundant runtime PM calls when enabling/disabling the
	SDIO IRQ.
	- Remove the Cc to Adrian as a part of the change log.

---
 drivers/mmc/host/sdhci.c | 55 ++++--------------------------------------------
 1 file changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6bd3d17..8e74e75 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -56,19 +56,9 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 static int sdhci_do_get_cd(struct sdhci_host *host);
 
 #ifdef CONFIG_PM
-static int sdhci_runtime_pm_get(struct sdhci_host *host);
-static int sdhci_runtime_pm_put(struct sdhci_host *host);
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 static void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
 #else
-static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
-{
-	return 0;
-}
-static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
-{
-	return 0;
-}
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
 }
@@ -1319,8 +1309,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host = mmc_priv(mmc);
 
-	sdhci_runtime_pm_get(host);
-
 	/* Firstly check card presence */
 	present = mmc->ops->get_cd(mmc);
 
@@ -1567,9 +1555,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
-	sdhci_runtime_pm_get(host);
 	sdhci_do_set_ios(host, ios);
-	sdhci_runtime_pm_put(host);
 }
 
 static int sdhci_do_get_cd(struct sdhci_host *host)
@@ -1601,12 +1587,8 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
 static int sdhci_get_cd(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	int ret;
 
-	sdhci_runtime_pm_get(host);
-	ret = sdhci_do_get_cd(host);
-	sdhci_runtime_pm_put(host);
-	return ret;
+	return sdhci_do_get_cd(host);
 }
 
 static int sdhci_check_ro(struct sdhci_host *host)
@@ -1662,12 +1644,8 @@ static void sdhci_hw_reset(struct mmc_host *mmc)
 static int sdhci_get_ro(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	int ret;
 
-	sdhci_runtime_pm_get(host);
-	ret = sdhci_do_get_ro(host);
-	sdhci_runtime_pm_put(host);
-	return ret;
+	return sdhci_do_get_ro(host);
 }
 
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
@@ -1689,8 +1667,6 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	sdhci_runtime_pm_get(host);
-
 	spin_lock_irqsave(&host->lock, flags);
 	if (enable)
 		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
@@ -1699,8 +1675,6 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
-
-	sdhci_runtime_pm_put(host);
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
@@ -1798,14 +1772,11 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	int err;
 
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
-	sdhci_runtime_pm_get(host);
-	err = sdhci_do_start_signal_voltage_switch(host, ios);
-	sdhci_runtime_pm_put(host);
-	return err;
+
+	return sdhci_do_start_signal_voltage_switch(host, ios);
 }
 
 static int sdhci_card_busy(struct mmc_host *mmc)
@@ -1813,10 +1784,8 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 	u32 present_state;
 
-	sdhci_runtime_pm_get(host);
 	/* Check whether DAT[3:0] is 0000 */
 	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	sdhci_runtime_pm_put(host);
 
 	return !(present_state & SDHCI_DATA_LVL_MASK);
 }
@@ -1843,7 +1812,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	unsigned int tuning_count = 0;
 	bool hs400_tuning;
 
-	sdhci_runtime_pm_get(host);
 	spin_lock_irqsave(&host->lock, flags);
 
 	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
@@ -1891,7 +1859,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->ops->platform_execute_tuning) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		err = host->ops->platform_execute_tuning(host, opcode);
-		sdhci_runtime_pm_put(host);
 		return err;
 	}
 
@@ -2023,8 +1990,6 @@ out:
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 out_unlock:
 	spin_unlock_irqrestore(&host->lock, flags);
-	sdhci_runtime_pm_put(host);
-
 	return err;
 }
 
@@ -2222,7 +2187,6 @@ static void sdhci_tasklet_finish(unsigned long param)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
-	sdhci_runtime_pm_put(host);
 }
 
 static void sdhci_timeout_timer(unsigned long data)
@@ -2703,17 +2667,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
-static int sdhci_runtime_pm_get(struct sdhci_host *host)
-{
-	return pm_runtime_get_sync(host->mmc->parent);
-}
-
-static int sdhci_runtime_pm_put(struct sdhci_host *host)
-{
-	pm_runtime_mark_last_busy(host->mmc->parent);
-	return pm_runtime_put_autosuspend(host->mmc->parent);
-}
-
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 {
 	if (host->bus_on)
-- 
1.9.1

