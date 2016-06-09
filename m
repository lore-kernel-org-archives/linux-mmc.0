From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 05/46] mmc: sdhci: Simplify sdhci_finish_command() by clearing host->cmd at the start
Date: Thu,  9 Jun 2016 14:52:05 +0300
Message-ID: <1465473166-22532-6-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcFIL5K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:10 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

sdhci_finish_command() is going to set host->cmd to NULL. Simplify the
code by using a local variable to hold host->cmd and set host->cmd to
NULL at the start.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 32d2978c04b9..5622841458ed 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1054,21 +1054,24 @@ EXPORT_SYMBOL_GPL(sdhci_send_command);
 
 static void sdhci_finish_command(struct sdhci_host *host)
 {
+	struct mmc_command *cmd = host->cmd;
 	int i;
 
-	if (host->cmd->flags & MMC_RSP_PRESENT) {
-		if (host->cmd->flags & MMC_RSP_136) {
+	host->cmd = NULL;
+
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
 			/* CRC is stripped so we need to do some shifting. */
 			for (i = 0;i < 4;i++) {
-				host->cmd->resp[i] = sdhci_readl(host,
+				cmd->resp[i] = sdhci_readl(host,
 					SDHCI_RESPONSE + (3-i)*4) << 8;
 				if (i != 3)
-					host->cmd->resp[i] |=
+					cmd->resp[i] |=
 						sdhci_readb(host,
 						SDHCI_RESPONSE + (3-i)*4-1);
 			}
 		} else {
-			host->cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
+			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
 		}
 	}
 
@@ -1082,21 +1085,19 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	 *       feature so there might be some problems with older
 	 *       controllers.
 	 */
-	if (host->cmd->flags & MMC_RSP_BUSY) {
-		if (host->cmd->data) {
+	if (cmd->flags & MMC_RSP_BUSY) {
+		if (cmd->data) {
 			DBG("Cannot wait for busy signal when also doing a data transfer");
 		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
 			   !host->busy_handle) {
 			/* Mark that command complete before busy is ended */
 			host->busy_handle = 1;
-			host->cmd = NULL;
 			return;
 		}
 	}
 
 	/* Finished CMD23, now send actual command. */
-	if (host->cmd == host->mrq->sbc) {
-		host->cmd = NULL;
+	if (cmd == host->mrq->sbc) {
 		sdhci_send_command(host, host->mrq->cmd);
 	} else {
 
@@ -1104,10 +1105,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		if (host->data && host->data_early)
 			sdhci_finish_data(host);
 
-		if (!host->cmd->data)
+		if (!cmd->data)
 			tasklet_schedule(&host->finish_tasklet);
-
-		host->cmd = NULL;
 	}
 }
 
-- 
1.9.1

