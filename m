From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 18/46] mmc: sdhci: Factor out sdhci_auto_cmd12()
Date: Thu,  9 Jun 2016 14:52:18 +0300
Message-ID: <1465473166-22532-19-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbcFIL6B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:01 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Factor out sdhci_auto_cmd12() so that there is a single place that controls
whether auto-CMD12 is used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fa527a89ee4c..690bffa24e93 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -881,6 +881,12 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
+static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	return !mrq->sbc && (host->flags & SDHCI_AUTO_CMD12);
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -911,7 +917,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+		if (sdhci_auto_cmd12(host, cmd->mrq) &&
 		    (cmd->opcode != SD_IO_RW_EXTENDED))
 			mode |= SDHCI_TRNS_AUTO_CMD12;
 		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
@@ -1469,7 +1475,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
 	 * requests if Auto-CMD12 is enabled.
 	 */
-	if (!mrq->sbc && (host->flags & SDHCI_AUTO_CMD12)) {
+	if (sdhci_auto_cmd12(host, mrq)) {
 		if (mrq->stop) {
 			mrq->data->stop = NULL;
 			mrq->stop = NULL;
-- 
1.9.1

