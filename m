From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 08/10] mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ
Date: Sat, 18 Aug 2012 00:22:28 +0530
Message-ID: <1345229550-8672-9-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482Ab2HQSyE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:54:04 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

Consolidate the duplicated code around the handling of CMD_TIMEOUT,
CMD_CRC, DATA_TIMEOUT, DATA_CRC and CARD_ERR handling into a
single function.
This generally shrinks code bloat, but is also required for implementing
software based guard timers.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 63 +++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 20453c8..9afdd20 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -964,6 +964,18 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 			__func__);
 }
 
+static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int err)
+{
+	omap_hsmmc_reset_controller_fsm(host, SRC);
+	host->cmd->error = err;
+
+	if (host->data) {
+		omap_hsmmc_reset_controller_fsm(host, SRD);
+		omap_hsmmc_dma_cleanup(host, err);
+	}
+
+}
+
 static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 {
 	struct mmc_data *data;
@@ -974,48 +986,15 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 
 	if (status & ERR) {
 		omap_hsmmc_dbg_report_irq(host, status);
-		if ((status & CMD_TIMEOUT) ||
-			(status & CMD_CRC)) {
-			if (host->cmd) {
-				if (status & CMD_TIMEOUT) {
-					omap_hsmmc_reset_controller_fsm(host,
-									SRC);
-					host->cmd->error = -ETIMEDOUT;
-				} else {
-					host->cmd->error = -EILSEQ;
-				}
-				end_cmd = 1;
-			}
-			if (host->data || host->response_busy) {
-				if (host->data)
-					omap_hsmmc_dma_cleanup(host,
-								-ETIMEDOUT);
-				host->response_busy = 0;
-				omap_hsmmc_reset_controller_fsm(host, SRD);
-			}
-		}
-		if ((status & DATA_TIMEOUT) ||
-			(status & DATA_CRC)) {
-			if (host->data || host->response_busy) {
-				int err = (status & DATA_TIMEOUT) ?
-						-ETIMEDOUT : -EILSEQ;
-
-				if (host->data)
-					omap_hsmmc_dma_cleanup(host, err);
-				else
-					host->mrq->cmd->error = err;
-				host->response_busy = 0;
-				omap_hsmmc_reset_controller_fsm(host, SRD);
-				end_trans = 1;
-			}
-		}
-		if (status & CARD_ERR) {
-			dev_dbg(mmc_dev(host->mmc),
-				"Ignoring card err CMD%d\n", host->cmd->opcode);
-			if (host->cmd)
-				end_cmd = 1;
-			if (host->data)
-				end_trans = 1;
+		if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
+			hsmmc_command_incomplete(host, -ETIMEDOUT);
+		else if (status & (CMD_CRC | DATA_CRC))
+			hsmmc_command_incomplete(host, -EILSEQ);
+
+		end_cmd = 1;
+		if (host->data || host->response_busy) {
+			end_trans = 1;
+			host->response_busy = 0;
 		}
 	}
 
-- 
1.7.11.1.25.g0e18bef

