From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 03/46] mmc: sdhci: Move busy signal handling into sdhci_finish_cmd()
Date: Thu,  9 Jun 2016 14:52:03 +0300
Message-ID: <1465473166-22532-4-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbcFIL5J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:09 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, command and data
handling needs to be untangled.

That means sdhci_finish_cmd() must not be called from the data IRQ
handler. It is being called because of busy signal handling, which
is treating the command as not finished until the busy signal is
released.

Instead, move busy signal handling from sdhci_cmd_irq() into
sdhci_finish_cmd(). Then the data IRQ handler does not need to call
sdhci_finish_cmd() and can instead finish the request.

What this means in practice for a command with busy signaling, is that
the command response is read from the host controller when the command
complete interrupt is received, thus freeing up the command circuit for
other commands.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 54 +++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 040af1b6b412..fc4301f68a93 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -45,7 +45,6 @@ static unsigned int debug_quirks2;
 
 static void sdhci_finish_data(struct sdhci_host *);
 
-static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 static int sdhci_get_cd(struct mmc_host *mmc);
@@ -1079,6 +1078,28 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
+	/*
+	 * The host can send and interrupt when the busy state has
+	 * ended, allowing us to wait without wasting CPU cycles.
+	 * The busy signal uses DAT0 so this is similar to waiting
+	 * for data to complete.
+	 *
+	 * Note: The 1.0 specification is a bit ambiguous about this
+	 *       feature so there might be some problems with older
+	 *       controllers.
+	 */
+	if (host->cmd->flags & MMC_RSP_BUSY) {
+		if (host->cmd->data) {
+			DBG("Cannot wait for busy signal when also doing a data transfer");
+		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+			   !host->busy_handle) {
+			/* Mark that command complete before busy is ended */
+			host->busy_handle = 1;
+			host->cmd = NULL;
+			return;
+		}
+	}
+
 	/* Finished CMD23, now send actual command. */
 	if (host->cmd == host->mrq->sbc) {
 		host->cmd = NULL;
@@ -2289,33 +2310,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		return;
 	}
 
-	/*
-	 * The host can send and interrupt when the busy state has
-	 * ended, allowing us to wait without wasting CPU cycles.
-	 * Unfortunately this is overloaded on the "data complete"
-	 * interrupt, so we need to take some care when handling
-	 * it.
-	 *
-	 * Note: The 1.0 specification is a bit ambiguous about this
-	 *       feature so there might be some problems with older
-	 *       controllers.
-	 */
-	if (host->cmd->flags & MMC_RSP_BUSY) {
-		if (host->cmd->data)
-			DBG("Cannot wait for busy signal when also doing a data transfer");
-		else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ)
-				&& !host->busy_handle) {
-			/* Mark that command complete before busy is ended */
-			host->busy_handle = 1;
-			return;
-		}
-
-		/* The controller does not support the end-of-busy IRQ,
-		 * fall through and take the SDHCI_INT_RESPONSE */
-	} else if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
-		   host->cmd->opcode == MMC_STOP_TRANSMISSION && !host->data) {
+	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
+	    !(host->cmd->flags & MMC_RSP_BUSY) && !host->data &&
+	    host->cmd->opcode == MMC_STOP_TRANSMISSION)
 		*mask &= ~SDHCI_INT_DATA_END;
-	}
 
 	if (intmask & SDHCI_INT_RESPONSE)
 		sdhci_finish_command(host);
@@ -2389,7 +2387,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				 * sure we do things in the proper order.
 				 */
 				if (host->busy_handle)
-					sdhci_finish_command(host);
+					tasklet_schedule(&host->finish_tasklet);
 				else
 					host->busy_handle = 1;
 				return;
-- 
1.9.1

