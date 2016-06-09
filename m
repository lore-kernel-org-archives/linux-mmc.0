From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 06/46] mmc: sdhci: Record what command is using the data lines
Date: Thu,  9 Jun 2016 14:52:06 +0300
Message-ID: <1465473166-22532-7-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcFIL5O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:14 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

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
index 5622841458ed..81b0b52ed4dd 100644
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
 
@@ -2218,6 +2223,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
+	host->data_cmd = NULL;
 
 	sdhci_led_deactivate(host);
 
@@ -2359,14 +2365,19 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
@@ -2441,7 +2452,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-			if (host->cmd) {
+			if (host->cmd == host->data_cmd) {
 				/*
 				 * Data managed to finish before the
 				 * command completed. Make sure we do
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 609f87ca536b..5be3c2471f89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -463,6 +463,7 @@ struct sdhci_host {
 
 	struct mmc_request *mrq;	/* Current request */
 	struct mmc_command *cmd;	/* Current command */
+	struct mmc_command *data_cmd;	/* Current data command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
 	unsigned int busy_handle:1;	/* Handling the order of Busy-end */
-- 
1.9.1

