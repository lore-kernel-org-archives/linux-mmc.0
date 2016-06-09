From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 14/46] mmc: sdhci: Ensure all requests get errored out
Date: Thu,  9 Jun 2016 14:52:14 +0300
Message-ID: <1465473166-22532-15-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcFIL56 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:58 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. That means
ensuring that all requests get errored out in the cases of card or driver
removal.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4361c3829106..e124dc632cac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2131,6 +2131,24 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
+static inline bool sdhci_has_requests(struct sdhci_host *host)
+{
+	return host->cmd || host->data_cmd;
+}
+
+static void sdhci_error_out_mrqs(struct sdhci_host *host, int err)
+{
+	if (host->data_cmd) {
+		host->data_cmd->error = err;
+		sdhci_finish_mrq(host, host->data_cmd->mrq);
+	}
+
+	if (host->cmd) {
+		host->cmd->error = err;
+		sdhci_finish_mrq(host, host->cmd->mrq);
+	}
+}
+
 static void sdhci_card_event(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -2145,8 +2163,8 @@ static void sdhci_card_event(struct mmc_host *mmc)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	/* Check host->mrq first in case we are runtime suspended */
-	if (host->mrq && !present) {
+	/* Check sdhci_has_requests() first in case we are runtime suspended */
+	if (sdhci_has_requests(host) && !present) {
 		pr_err("%s: Card removed during transfer!\n",
 			mmc_hostname(host->mmc));
 		pr_err("%s: Resetting controller.\n",
@@ -2155,8 +2173,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-		host->mrq->cmd->error = -ENOMEDIUM;
-		sdhci_finish_mrq(host, host->mrq);
+		sdhci_error_out_mrqs(host, -ENOMEDIUM);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -3425,12 +3442,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 		host->flags |= SDHCI_DEVICE_DEAD;
 
-		if (host->mrq) {
+		if (sdhci_has_requests(host)) {
 			pr_err("%s: Controller removed during "
 				" transfer!\n", mmc_hostname(mmc));
-
-			host->mrq->cmd->error = -ENOMEDIUM;
-			sdhci_finish_mrq(host, host->mrq);
+			sdhci_error_out_mrqs(host, -ENOMEDIUM);
 		}
 
 		spin_unlock_irqrestore(&host->lock, flags);
-- 
1.9.1

