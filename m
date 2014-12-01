From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci: Disable re-tuning for HS400
Date: Mon,  1 Dec 2014 15:16:06 +0200
Message-ID: <1417439766-5063-4-git-send-email-adrian.hunter@intel.com>
References: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61571 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbaLANUZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:20:25 -0500
In-Reply-To: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Re-tuning for HS400 mode must be done in HS200
mode. Currently there is no support for that.
That needs to be reflected in the code.
Specifically, if tuning is executed in HS400 mode
then return an error, and if the re-tuning timer
is running when switching to HS400 mode, then
disable the timer.

Note that periodic re-tuning is not expected
to be needed for HS400 but re-tuning is still
needed after the host controller has lost power.
In the case of suspend/resume that is not necessary
because the card is fully re-initialised. That
just leaves runtime suspend/resume with no support
for HS400 re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2efa7fe..a7c9e67 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1476,8 +1476,18 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	else if ((timing == MMC_TIMING_UHS_DDR50) ||
 		 (timing == MMC_TIMING_MMC_DDR52))
 		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
-	else if (timing == MMC_TIMING_MMC_HS400)
+	else if (timing == MMC_TIMING_MMC_HS400) {
 		ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
+		/*
+		 * Periodic re-tuning for HS400 is not expected to be needed, so
+		 * disable it here.
+		 */
+		if (host->flags & SDHCI_USING_RETUNING_TIMER) {
+			host->flags &= ~SDHCI_USING_RETUNING_TIMER;
+			del_timer_sync(&host->tuning_timer);
+			host->flags &= ~SDHCI_NEEDS_RETUNING;
+		}
+	}
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
@@ -1897,7 +1907,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * tuning function has to be executed.
 	 */
 	switch (host->timing) {
+	/* HS400 tuning is done in HS200 mode */
 	case MMC_TIMING_MMC_HS400:
+		err = -EINVAL;
+		goto out_unlock;
+
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_UHS_SDR104:
 		break;
-- 
1.9.1

