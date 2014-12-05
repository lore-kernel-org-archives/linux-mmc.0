From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 4/4] mmc: sdhci: Disable re-tuning for HS400
Date: Fri,  5 Dec 2014 19:25:31 +0200
Message-ID: <1417800331-15248-5-git-send-email-adrian.hunter@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2924 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbaLER1V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:27:21 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Re-tuning for HS400 mode must be done in HS200
mode. Currently there is no support for that.
That needs to be reflected in the code.
Specifically, if tuning is executed in HS400 mode
then return an error, and do not start the
tuning timer if HS200 tuning is being done prior
to switching to HS400.

Note that periodic re-tuning is not expected
to be needed for HS400 but re-tuning is still
needed after the host controller has lost power.
In the case of suspend/resume that is not necessary
because the card is fully re-initialised. That
just leaves runtime suspend/resume with no support
for HS400 re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 29 +++++++++++++++++++++++++++++
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff0fe90..bfde165 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1878,6 +1878,18 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 	return !(present_state & SDHCI_DATA_LVL_MASK);
 }
 
+static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->flags |= SDHCI_HS400_TUNING;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1886,10 +1898,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int err = 0;
 	unsigned long flags;
 	unsigned int tuning_count = 0;
+	bool hs400_tuning;
 
 	sdhci_runtime_pm_get(host);
 	spin_lock_irqsave(&host->lock, flags);
 
+	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
+	host->flags &= ~SDHCI_HS400_TUNING;
+
 	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
 		tuning_count = host->tuning_count;
 
@@ -1901,8 +1917,20 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * tuning function has to be executed.
 	 */
 	switch (host->timing) {
+	/* HS400 tuning is done in HS200 mode */
 	case MMC_TIMING_MMC_HS400:
+		err = -EINVAL;
+		goto out_unlock;
+
 	case MMC_TIMING_MMC_HS200:
+		/*
+		 * Periodic re-tuning for HS400 is not expected to be needed, so
+		 * disable it here.
+		 */
+		if (hs400_tuning)
+			tuning_count = 0;
+		break;
+
 	case MMC_TIMING_UHS_SDR104:
 		break;
 
@@ -2130,6 +2158,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
+	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 375af80..f767a0d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -137,6 +137,7 @@ struct sdhci_host {
 #define SDHCI_SDR104_NEEDS_TUNING (1<<10)	/* SDR104/HS200 needs tuning */
 #define SDHCI_USING_RETUNING_TIMER (1<<11)	/* Host is using a retuning timer for the card */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
+#define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.9.1

