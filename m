From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 10/54] mmc: sdhci: Record what command is using the data lines
Date: Wed, 29 Jun 2016 16:24:23 +0300
Message-ID: <1467206707-30185-11-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073AbcF2N35 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:57 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In order to support commands during data transfer, there must be a
distinction between the command that is using the command line (and
for which a command interrupt is expected) and the command that is
using the data lines (for which a data interrupt is expected).

There is host->cmd for the command line, but there is only host->data
for the data lines, which is a different structure, does not represent
the command in use, and is anyway NULL in the case of commands that use
the data lines for busy signalling instead of data transfer.

Introduce host->data_cmd to record what command is using the data lines,
and use that instead of host->cmd when referring to the data command.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 17 ++++++++++++++---
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a00cdd7fa651..c9456bd603a9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -929,6 +929,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 
 	data = host->data;
 	host->data = NULL;
+	host->data_cmd = NULL;
 
 	if ((host->flags & (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA)) ==
 	    (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA))
@@ -1014,6 +1015,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 	host->busy_handle = 0;
+	if (cmd->data || cmd->flags & MMC_RSP_BUSY) {
+		WARN_ON(host->data_cmd);
+		host->data_cmd = cmd;
+	}
 
 	sdhci_prepare_data(host, cmd);
 
@@ -2224,6 +2229,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
+	host->data_cmd = NULL;
 
 	sdhci_led_deactivate(host);
 
@@ -2365,14 +2371,19 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	}
 
 	if (!host->data) {
+		struct mmc_command *data_cmd = host->data_cmd;
+
+		if (data_cmd)
+			host->data_cmd = NULL;
+
 		/*
 		 * The "data complete" interrupt is also used to
 		 * indicate that a busy state has ended. See comment
 		 * above in sdhci_cmd_irq().
 		 */
-		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
+		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
-				host->cmd->error = -ETIMEDOUT;
+				data_cmd->error = -ETIMEDOUT;
 				tasklet_schedule(&host->finish_tasklet);
 				return;
 			}
@@ -2447,7 +2458,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-			if (host->cmd) {
+			if (host->cmd == host->data_cmd) {
 				/*
 				 * Data managed to finish before the
 				 * command completed. Make sure we do
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e332e4a40823..6e971709c9df 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -466,6 +466,7 @@ struct sdhci_host {
 
 	struct mmc_request *mrq;	/* Current request */
 	struct mmc_command *cmd;	/* Current command */
+	struct mmc_command *data_cmd;	/* Current data command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
 	unsigned int busy_handle:1;	/* Handling the order of Busy-end */
-- 
1.9.1

