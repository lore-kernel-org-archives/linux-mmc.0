From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Support predefined multiple block transfers.
Date: Mon, 26 Sep 2011 20:46:59 +0900
Message-ID: <001901cc7c42$00147c10$003d7430$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com, 'Seungwon Jeon' <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the support for predefined multiple block read/write.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0ed1d28..36a5576 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -588,11 +588,10 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }

-static void dw_mci_start_request(struct dw_mci *host,
-				 struct dw_mci_slot *slot)
+static void __dw_mci_start_request(struct dw_mci *host,
+				 struct dw_mci_slot *slot, struct mmc_command *cmd)
 {
 	struct mmc_request *mrq;
-	struct mmc_command *cmd;
 	struct mmc_data	*data;
 	u32 cmdflags;

@@ -610,14 +609,13 @@ static void dw_mci_start_request(struct dw_mci *host,
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
@@ -635,6 +633,16 @@ static void dw_mci_start_request(struct dw_mci *host,
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
@@ -889,7 +897,13 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			cmd = host->cmd;
 			host->cmd = NULL;
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
-			dw_mci_command_complete(host, host->mrq->cmd);
+			dw_mci_command_complete(host, cmd);
+			if ((cmd == host->mrq->sbc) && !cmd->error) {
+				prev_state = state = STATE_SENDING_CMD;
+				__dw_mci_start_request(host, host->cur_slot, host->mrq->cmd);
+				goto unlock;
+			}
+
 			if (!host->mrq->data || cmd->error) {
 				dw_mci_request_end(host, host->mrq);
 				goto unlock;
@@ -967,6 +981,12 @@ static void dw_mci_tasklet_func(unsigned long priv)
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
