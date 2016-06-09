From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 13/46] mmc: sdhci: Clear pointers when a request finishes
Date: Thu,  9 Jun 2016 14:52:13 +0300
Message-ID: <1465473166-22532-14-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFIL55 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:57 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Several pointers are used to identify when interrupts are expected. Namely,
host->cmd, host->data_cmd and host->data. Ensure those are cleared when
a request finishes. That tidies the case when a request is errored out
before normal processing has completed, ensuring any interrupts that occur
subsequently are not acted upon.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a1afcd9dd228..4361c3829106 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -935,6 +935,15 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
+	if (host->cmd && host->cmd->mrq == mrq)
+		host->cmd = NULL;
+
+	if (host->data_cmd && host->data_cmd->mrq == mrq)
+		host->data_cmd = NULL;
+
+	if (host->data && host->data->mrq == mrq)
+		host->data = NULL;
+
 	if (sdhci_needs_reset(host, mrq))
 		host->pending_reset = true;
 
@@ -2234,9 +2243,6 @@ static void sdhci_tasklet_finish(unsigned long param)
 	}
 
 	host->mrq = NULL;
-	host->cmd = NULL;
-	host->data = NULL;
-	host->data_cmd = NULL;
 
 	sdhci_led_deactivate(host);
 
-- 
1.9.1

