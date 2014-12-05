From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 3/4] mmc: sdhci: Simplify use of tuning timer
Date: Fri,  5 Dec 2014 19:25:30 +0200
Message-ID: <1417800331-15248-4-git-send-email-adrian.hunter@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbaLER1Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:27:25 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

The tuning timer is always used if the tuning mode
is 1 and there is a tuning count, irrespective of
whether this is the first call, or any subsequent
call. Consequently the logic to start the timer
can be simplified.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2efa7fe..ff0fe90 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1885,10 +1885,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int tuning_loop_counter = MAX_TUNING_LOOP;
 	int err = 0;
 	unsigned long flags;
+	unsigned int tuning_count = 0;
 
 	sdhci_runtime_pm_get(host);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		tuning_count = host->tuning_count;
+
 	/*
 	 * The Host Controller needs tuning only in case of SDR104 mode
 	 * and for SDR50 mode when Use Tuning for SDR50 is set in the
@@ -2033,22 +2037,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	}
 
 out:
-	/*
-	 * If this is the very first time we are here, we start the retuning
-	 * timer. Since only during the first time, SDHCI_NEEDS_RETUNING
-	 * flag won't be set, we check this condition before actually starting
-	 * the timer.
-	 */
-	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
-	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
+	host->flags &= ~SDHCI_NEEDS_RETUNING;
+
+	if (tuning_count) {
 		host->flags |= SDHCI_USING_RETUNING_TIMER;
-		mod_timer(&host->tuning_timer, jiffies +
-			host->tuning_count * HZ);
-	} else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
-		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		/* Reload the new initial value for timer */
-		mod_timer(&host->tuning_timer, jiffies +
-			  host->tuning_count * HZ);
+		mod_timer(&host->tuning_timer, jiffies + tuning_count * HZ);
 	}
 
 	/*
-- 
1.9.1

