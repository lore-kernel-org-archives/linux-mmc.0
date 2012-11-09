From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Fri, 9 Nov 2012 20:11:19 +0530
Message-ID: <1352472079-1512-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33034 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851Ab2KIOlg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Nov 2012 09:41:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereference of
host->cmd as the command complete has previously been handled.
Set end_cmd only in case of Data Timeout/CRC.

While at it restore error handling behaviour as was before the
"commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"

host->cmd->error should not be updated on data error case, only
host->data->error needs to be updated.
end_trans and end_crc should not to be set together, to avoid
mmc_request_done being called twice in case of Command CRC or command
Timeout.
Avoid soft reset of command internal state machine on data errors.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
based on mmc-fixes-for-3.7-rc5 in mmc_next

 drivers/mmc/host/omap_hsmmc.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fedd258..6ea1da3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -968,15 +968,20 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 			__func__);
 }
 
-static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int err)
+static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
+					int err, int end_cmd)
 {
-	omap_hsmmc_reset_controller_fsm(host, SRC);
-	host->cmd->error = err;
+	if (end_cmd) {
+		omap_hsmmc_reset_controller_fsm(host, SRC);
+		if (host->cmd)
+			host->cmd->error = err;
+	}
 
 	if (host->data) {
 		omap_hsmmc_reset_controller_fsm(host, SRD);
 		omap_hsmmc_dma_cleanup(host, err);
-	}
+	} else if (host->mrq && host->mrq->cmd)
+		host->mrq->cmd->error = err;
 
 }
 
@@ -990,14 +995,16 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 
 	if (status & ERR) {
 		omap_hsmmc_dbg_report_irq(host, status);
+
+		if (status & (CMD_TIMEOUT | CMD_CRC))
+			end_cmd = 1;
 		if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
-			hsmmc_command_incomplete(host, -ETIMEDOUT);
+			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
 		else if (status & (CMD_CRC | DATA_CRC))
-			hsmmc_command_incomplete(host, -EILSEQ);
+			hsmmc_command_incomplete(host, -EILSEQ, end_cmd);
 
-		end_cmd = 1;
 		if (host->data || host->response_busy) {
-			end_trans = 1;
+			end_trans = !end_cmd;
 			host->response_busy = 0;
 		}
 	}
-- 
1.7.5.4

