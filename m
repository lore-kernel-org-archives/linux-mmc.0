From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND] mmc: dw_mmc: Support predefined mutiple block transfers
Date: Fri, 09 Dec 2011 14:56:19 +0900
Message-ID: <00aa01ccb637$45d8e2c0$d18aa840$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46877 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1LIF4V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2011 00:56:21 -0500
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org

This patch adds the support for predefined multiple block read/write.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 366df6b..f8301a7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -588,11 +588,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
-static void dw_mci_start_request(struct dw_mci *host,
-				 struct dw_mci_slot *slot)
+static void __dw_mci_start_request(struct dw_mci *host,
+				   struct dw_mci_slot *slot,
+				   struct mmc_command *cmd)
 {
 	struct mmc_request *mrq;
-	struct mmc_command *cmd;
 	struct mmc_data	*data;
 	u32 cmdflags;
 
@@ -610,14 +610,13 @@ static void dw_mci_start_request(struct dw_mci *host,
 	host->completed_events = 0;
 	host->data_status = 0;
 
-	data = mrq->data;
+	data = cmd->data;
 	if (data) {
 		dw_mci_set_timeout(host);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
 
-	cmd = mrq->cmd;
 	cmdflags = dw_mci_prepare_command(slot->mmc, cmd);
 
 	/* this is the first command, send the initialization clock */
@@ -635,6 +634,16 @@ static void dw_mci_start_request(struct dw_mci *host,
 		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
 }
 
+static void dw_mci_start_request(struct dw_mci *host,
+				 struct dw_mci_slot *slot)
+{
+	struct mmc_request *mrq = slot->mrq;
+	struct mmc_command *cmd;
+
+	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
+	__dw_mci_start_request(host, slot, cmd);
+}
+
 /* must be called with host->lock held */
 static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 				 struct mmc_request *mrq)
@@ -889,7 +898,14 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			cmd = host->cmd;
 			host->cmd = NULL;
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
-			dw_mci_command_complete(host, host->mrq->cmd);
+			dw_mci_command_complete(host, cmd);
+			if ((cmd == host->mrq->sbc) && !cmd->error) {
+				prev_state = state = STATE_SENDING_CMD;
+				__dw_mci_start_request(host, host->cur_slot,
+						       host->mrq->cmd);
+				goto unlock;
+			}
+
 			if (!host->mrq->data || cmd->error) {
 				dw_mci_request_end(host, host->mrq);
 				goto unlock;
@@ -967,6 +983,12 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				goto unlock;
 			}
 
+			if (host->mrq->sbc && !data->error) {
+				data->stop->error = 0;
+				dw_mci_request_end(host, host->mrq);
+				goto unlock;
+			}
+
 			prev_state = state = STATE_SENDING_STOP;
 			if (!data->error)
 				send_stop_cmd(host, data);
-- 
1.7.0.4


