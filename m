From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 15/46] mmc: sdhci: Factor out sdhci_data_line_cmd()
Date: Thu,  9 Jun 2016 14:52:15 +0300
Message-ID: <1465473166-22532-16-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFIL56 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:58 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Factor out sdhci_data_line_cmd() to improve readability and because it is
used in multiple places.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e124dc632cac..90180d0d752c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -111,6 +111,11 @@ static void sdhci_dumpregs(struct sdhci_host *host)
  *                                                                           *
 \*****************************************************************************/
 
+static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+{
+	return cmd->data || cmd->flags & MMC_RSP_BUSY;
+}
+
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
@@ -744,7 +749,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 
-	if (data || (cmd->flags & MMC_RSP_BUSY))
+	if (sdhci_data_line_cmd(cmd))
 		sdhci_set_timeout(host, cmd);
 
 	if (!data)
@@ -1013,7 +1018,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	timeout = 10;
 
 	mask = SDHCI_CMD_INHIBIT;
-	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
+	if (sdhci_data_line_cmd(cmd))
 		mask |= SDHCI_DATA_INHIBIT;
 
 	/* We shouldn't wait for data inihibit for stop commands, even
@@ -1042,7 +1047,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	mod_timer(&host->timer, timeout);
 
 	host->cmd = cmd;
-	if (cmd->data || cmd->flags & MMC_RSP_BUSY) {
+	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
 	}
-- 
1.9.1

