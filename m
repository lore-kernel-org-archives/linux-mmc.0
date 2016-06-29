From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 18/54] mmc: sdhci: Ensure all requests get errored out
Date: Wed, 29 Jun 2016 16:24:31 +0300
Message-ID: <1467206707-30185-19-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbcF2Nab (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:31 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. That means
ensuring that all requests get errored out in the cases of card or driver
removal.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dce31b798180..6e3b4d0e5b67 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2137,6 +2137,24 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
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
@@ -2151,8 +2169,8 @@ static void sdhci_card_event(struct mmc_host *mmc)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	/* Check host->mrq first in case we are runtime suspended */
-	if (host->mrq && !present) {
+	/* Check sdhci_has_requests() first in case we are runtime suspended */
+	if (sdhci_has_requests(host) && !present) {
 		pr_err("%s: Card removed during transfer!\n",
 			mmc_hostname(host->mmc));
 		pr_err("%s: Resetting controller.\n",
@@ -2161,8 +2179,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-		host->mrq->cmd->error = -ENOMEDIUM;
-		sdhci_finish_mrq(host, host->mrq);
+		sdhci_error_out_mrqs(host, -ENOMEDIUM);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -3496,12 +3513,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
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

