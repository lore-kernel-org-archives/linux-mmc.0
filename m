From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 07/46] mmc: sdhci: Get rid of host->busy_handle
Date: Thu,  9 Jun 2016 14:52:07 +0300
Message-ID: <1465473166-22532-8-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcFIL5S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:18 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Now that there is host->data_cmd to record the command for which a data
interrupt is expected, it is possible to determine whether a command with
busy signaling has completed without an extra flag. So host->busy_handle
is not needed. Remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 ++++++--------
 drivers/mmc/host/sdhci.h |  1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 81b0b52ed4dd..82e8786098b2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1014,7 +1014,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	mod_timer(&host->timer, timeout);
 
 	host->cmd = cmd;
-	host->busy_handle = 0;
 	if (cmd->data || cmd->flags & MMC_RSP_BUSY) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
@@ -1094,9 +1093,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		if (cmd->data) {
 			DBG("Cannot wait for busy signal when also doing a data transfer");
 		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
-			   !host->busy_handle) {
-			/* Mark that command complete before busy is ended */
-			host->busy_handle = 1;
+			   cmd == host->data_cmd) {
+			/* Command complete before busy is ended */
 			return;
 		}
 	}
@@ -2387,10 +2385,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				 * before the command completed, so make
 				 * sure we do things in the proper order.
 				 */
-				if (host->busy_handle)
-					tasklet_schedule(&host->finish_tasklet);
-				else
-					host->busy_handle = 1;
+				if (host->cmd == data_cmd)
+					return;
+
+				tasklet_schedule(&host->finish_tasklet);
 				return;
 			}
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5be3c2471f89..d649dfd2f4d2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -466,7 +466,6 @@ struct sdhci_host {
 	struct mmc_command *data_cmd;	/* Current data command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
-	unsigned int busy_handle:1;	/* Handling the order of Busy-end */
 
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
-- 
1.9.1

