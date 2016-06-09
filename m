From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 08/46] mmc: sdhci: Reduce the use of host->mrq
Date: Thu,  9 Jun 2016 14:52:08 +0300
Message-ID: <1465473166-22532-9-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56076 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcFIL5v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:51 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. That means
host->mrq will not be able to be used.

In several places, host->mrq is used when instead the mrq can be determined
from the cmd or data pointers. Reduce the use of host->mrq by doing that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 82e8786098b2..02a8522dc74e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -906,12 +906,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+		if (!cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
 		    (cmd->opcode != SD_IO_RW_EXTENDED))
 			mode |= SDHCI_TRNS_AUTO_CMD12;
-		else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-			sdhci_writel(host, host->mrq->sbc->arg, SDHCI_ARGUMENT2);
+			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
 		}
 	}
 
@@ -954,7 +954,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	 */
 	if (data->stop &&
 	    (data->error ||
-	     !host->mrq->sbc)) {
+	     !data->mrq->sbc)) {
 
 		/*
 		 * The controller needs a reset of internal state machines
@@ -990,7 +990,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	/* We shouldn't wait for data inihibit for stop commands, even
 	   though they might use busy signaling */
-	if (host->mrq->data && (cmd == host->mrq->data->stop))
+	if (cmd->mrq->data && (cmd == cmd->mrq->data->stop))
 		mask &= ~SDHCI_DATA_INHIBIT;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
@@ -1100,8 +1100,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	}
 
 	/* Finished CMD23, now send actual command. */
-	if (cmd == host->mrq->sbc) {
-		sdhci_send_command(host, host->mrq->cmd);
+	if (cmd == cmd->mrq->sbc) {
+		sdhci_send_command(host, cmd->mrq->cmd);
 	} else {
 
 		/* Processed actual command. */
@@ -1408,7 +1408,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
-		host->mrq->cmd->error = -ENOMEDIUM;
+		mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
 	} else {
 		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
-- 
1.9.1

