From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 12/46] mmc: sdhci: Track whether a reset is pending
Date: Thu,  9 Jun 2016 14:52:12 +0300
Message-ID: <1465473166-22532-13-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbcFIL5y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:54 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

SDHCI recovers from errors by resetting the cmd and data circuits. Until
that is done, there very well might be more interrupts, so ignore them in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 20 ++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f75c226de7ff..a1afcd9dd228 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -935,6 +935,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
+	if (sdhci_needs_reset(host, mrq))
+		host->pending_reset = true;
+
 	tasklet_schedule(&host->finish_tasklet);
 }
 
@@ -2226,6 +2229,8 @@ static void sdhci_tasklet_finish(unsigned long param)
 		   controllers do not like that. */
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+		host->pending_reset = false;
 	}
 
 	host->mrq = NULL;
@@ -2281,6 +2286,13 @@ static void sdhci_timeout_timer(unsigned long data)
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 {
 	if (!host->cmd) {
+		/*
+		 * SDHCI recovers from errors by resetting the cmd and data
+		 * circuits.  Until that is done, there very well might be more
+		 * interrupts, so ignore them in that case.
+		 */
+		if (host->pending_reset)
+			return;
 		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_dumpregs(host);
@@ -2403,6 +2415,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			}
 		}
 
+		/*
+		 * SDHCI recovers from errors by resetting the cmd and data
+		 * circuits. Until that is done, there very well might be more
+		 * interrupts, so ignore them in that case.
+		 */
+		if (host->pending_reset)
+			return;
+
 		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_dumpregs(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d649dfd2f4d2..331a72b417ef 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -460,6 +460,7 @@ struct sdhci_host {
 	bool runtime_suspended;	/* Host is runtime suspended */
 	bool bus_on;		/* Bus power prevents runtime suspend */
 	bool preset_enabled;	/* Preset is enabled */
+	bool pending_reset;	/* Cmd/data reset is pending */
 
 	struct mmc_request *mrq;	/* Current request */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.9.1

