From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 23/54] mmc: sdhci: Do not reset cmd or data circuits that are in use
Date: Wed, 29 Jun 2016 16:24:36 +0300
Message-ID: <1467206707-30185-24-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbcF2Nau (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:50 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In order to support commands during data transfer, it will be possible to
need to reset the command circuit while the data circuit is in use, and
vice versa. It is now easy to determine whether the command or data circuit
is in use, and so just skip the corresponding reset if it is.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 229b467a409a..614d77694f17 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,9 +986,9 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 
 static void sdhci_finish_data(struct sdhci_host *host)
 {
-	struct mmc_data *data;
+	struct mmc_command *data_cmd = host->data_cmd;
+	struct mmc_data *data = host->data;
 
-	data = host->data;
 	host->data = NULL;
 	host->data_cmd = NULL;
 
@@ -1022,7 +1022,8 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		 * upon error conditions.
 		 */
 		if (data->error) {
-			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			if (!host->cmd || host->cmd == data_cmd)
+				sdhci_do_reset(host, SDHCI_RESET_CMD);
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 		}
 
@@ -2305,8 +2306,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		if (!host->cmd)
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+		if (!host->data_cmd)
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->pending_reset = false;
 	}
-- 
1.9.1

