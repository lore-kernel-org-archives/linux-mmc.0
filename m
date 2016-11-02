From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: sdhci: Fix CMD line reset interfering with ongoing data transfer
Date: Wed,  2 Nov 2016 15:49:08 +0200
Message-ID: <1478094551-24819-2-git-send-email-adrian.hunter@intel.com>
References: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbcKBNyH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:07 -0400
In-Reply-To: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

CMD line reset during an ongoing data transfer can cause the data transfer
to hang.  Fix by delaying the reset until the data transfer is finished.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.8+
---
 drivers/mmc/host/sdhci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1e25b01600e1..ad135d4449e6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2283,10 +2283,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
 		mrq = host->mrqs_done[i];
-		if (mrq) {
-			host->mrqs_done[i] = NULL;
+		if (mrq)
 			break;
-		}
 	}
 
 	if (!mrq) {
@@ -2317,6 +2315,17 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	 * upon error conditions.
 	 */
 	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
@@ -2324,10 +2333,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-		if (!host->cmd)
-			sdhci_do_reset(host, SDHCI_RESET_CMD);
-		if (!host->data_cmd)
-			sdhci_do_reset(host, SDHCI_RESET_DATA);
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->pending_reset = false;
 	}
@@ -2335,6 +2342,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	if (!sdhci_has_requests(host))
 		sdhci_led_deactivate(host);
 
+	host->mrqs_done[i] = NULL;
+
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
-- 
1.9.1

