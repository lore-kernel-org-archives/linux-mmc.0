From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 11/46] mmc: sdhci: Factor out sdhci_needs_reset()
Date: Thu,  9 Jun 2016 14:52:11 +0300
Message-ID: <1465473166-22532-12-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcFIL5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:53 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Factor out sdhci_needs_reset() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e6eec10b46de..f75c226de7ff 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -923,6 +923,16 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
+static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
+		((mrq->cmd && mrq->cmd->error) ||
+		 (mrq->sbc && mrq->sbc->error) ||
+		 (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
+				(mrq->data->stop && mrq->data->stop->error))) ||
+		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
+}
+
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	tasklet_schedule(&host->finish_tasklet);
@@ -2206,13 +2216,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	 * The controller needs a reset of internal state machines
 	 * upon error conditions.
 	 */
-	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
-	    ((mrq->cmd && mrq->cmd->error) ||
-	     (mrq->sbc && mrq->sbc->error) ||
-	     (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
-			    (mrq->data->stop && mrq->data->stop->error))) ||
-	     (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
-
+	if (sdhci_needs_reset(host, mrq)) {
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
-- 
1.9.1

