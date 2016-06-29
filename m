From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 16/54] mmc: sdhci: Track whether a reset is pending
Date: Wed, 29 Jun 2016 16:24:29 +0300
Message-ID: <1467206707-30185-17-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbcF2NaX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:23 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

SDHCI recovers from errors by resetting the cmd and data circuits. Until
that is done, there very well might be more interrupts, so ignore them in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 20 ++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b0a320004e0d..320c294b9d73 100644
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
 
@@ -2232,6 +2235,8 @@ static void sdhci_tasklet_finish(unsigned long param)
 		   controllers do not like that. */
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+		host->pending_reset = false;
 	}
 
 	host->mrq = NULL;
@@ -2287,6 +2292,13 @@ static void sdhci_timeout_timer(unsigned long data)
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
@@ -2409,6 +2421,14 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
index 13e0bd6cff5d..7301c90f8500 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -463,6 +463,7 @@ struct sdhci_host {
 	bool runtime_suspended;	/* Host is runtime suspended */
 	bool bus_on;		/* Bus power prevents runtime suspend */
 	bool preset_enabled;	/* Preset is enabled */
+	bool pending_reset;	/* Cmd/data reset is pending */
 
 	struct mmc_request *mrq;	/* Current request */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.9.1

