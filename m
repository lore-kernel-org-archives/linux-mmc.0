From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 1/3] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Fri, 9 Nov 2012 21:36:14 +0530
Message-ID: <1352477176-6673-2-git-send-email-balajitk@ti.com>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
 <1352477176-6673-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54500 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab2KIQGX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 11:06:23 -0500
In-Reply-To: <1352477176-6673-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

"commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"
sets both end_cmd and end_trans to 1.

Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereference of
host->cmd as the command complete has previously been handled.
Set end_cmd only in case of command Timeout/CRC.

Moreover host->cmd->error should not be updated on data error case, only
host->data->error needs to be updated.

Avoid soft reset of command internal state machine on data errors.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
based on mmc-fixes-for-3.7-rc5 in mmc_next
Since v1: split into 3 patches

 drivers/mmc/host/omap_hsmmc.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fedd258..245d7b5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -968,10 +968,14 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 			__func__);
 }
 
-static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int err)
+static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
+					int err, int end_cmd)
 {
 	omap_hsmmc_reset_controller_fsm(host, SRC);
-	host->cmd->error = err;
+	if (end_cmd) {
+		if (host->cmd)
+			host->cmd->error = err;
+	}
 
 	if (host->data) {
 		omap_hsmmc_reset_controller_fsm(host, SRD);
@@ -990,14 +994,16 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 
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

