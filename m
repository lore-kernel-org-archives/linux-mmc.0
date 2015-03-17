From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH 5/5] mmc: sdhci: add SW CMDQ support for CHT SDHCI host
Date: Tue, 17 Mar 2015 19:11:49 +0800
Message-ID: <20150317111149.GF17141@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63170 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbbCQLNr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Mar 2015 07:13:47 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Add the CMDQ support to SDHCI host interface and CHT SDHCI
host interface

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |  121 ++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aad89d2..3f4bfeb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -742,14 +742,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	struct mmc_data *data = cmd->data;
 	int ret;
 
-	WARN_ON(host->data);
-
 	if (data || (cmd->flags & MMC_RSP_BUSY))
 		sdhci_set_timeout(host, cmd);
 
 	if (!data)
 		return;
 
+	WARN_ON(host->data);
+
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
 	BUG_ON(data->blksz > host->mmc->max_blk_size);
@@ -927,7 +927,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
 		mode = SDHCI_TRNS_BLK_CNT_EN;
 
-	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
+	if (mmc_op_cmdq_execute_task(cmd->opcode) && (data->blocks > 1))
+		mode |= SDHCI_TRNS_MULTI;
+	else if (mmc_op_multi(cmd->opcode) || (data->blocks > 1)) {
 		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
 		/*
 		 * If we are sending CMD23, CMD12 never gets sent
@@ -1004,8 +1006,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		}
 
 		sdhci_send_command(host, data->stop);
-	} else
-		tasklet_schedule(&host->finish_tasklet);
+	} else {
+		if (host->mmc->context_info.is_cmdq_busy)
+			tasklet_schedule(&host->finish_async_data_tasklet);
+		else
+			tasklet_schedule(&host->finish_tasklet);
+	}
 }
 
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
@@ -1084,6 +1090,12 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
+	/* CMD46/47 doesn't wait for data */
+	if (mmc_op_cmdq_execute_task(cmd->opcode)) {
+		cmd->data = NULL;
+		host->mrq->data = NULL;
+	}
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -1116,6 +1128,9 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	if (host->cmd == host->mrq->precmd) {
 		host->cmd = NULL;
 		sdhci_send_command(host, host->mrq->cmd);
+	} else if ((host->cmd == host->mrq->cmd) && host->mrq->cmd2) {
+		host->cmd = NULL;
+		sdhci_send_command(host, host->mrq->cmd2);
 	} else {
 
 		/* Processed actual command. */
@@ -1401,6 +1416,9 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ)) &&
 		    (present_state & SDHCI_DATA_0_LVL_MASK)) {
 			if (mmc->card) {
+				/* don't do tuning when cmdq is not empty */
+				if (mmc->context_info.is_cmdq_busy)
+					goto end_tuning;
 				/* eMMC uses cmd21 but sd and sdio use cmd19 */
 				tuning_opcode =
 					mmc->card->type == MMC_TYPE_MMC ?
@@ -1422,9 +1440,16 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			}
 		}
 
-		if (mrq->precmd && !(host->flags & SDHCI_AUTO_CMD23))
-			sdhci_send_command(host, mrq->precmd);
-		else
+end_tuning:
+		if (mrq->precmd) {
+			if (mrq->precmd->opcode == 23) {
+				if (!(host->flags & SDHCI_AUTO_CMD23))
+					sdhci_send_command(host, mrq->precmd);
+				else
+					sdhci_send_command(host, mrq->cmd);
+			} else
+				sdhci_send_command(host, mrq->precmd);
+		} else
 			sdhci_send_command(host, mrq->cmd);
 	}
 
@@ -2248,7 +2273,7 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_tasklet_finish(unsigned long param)
+static void sdhci_tasklet_finish_async_data(unsigned long param)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -2262,14 +2287,71 @@ static void sdhci_tasklet_finish(unsigned long param)
          * If this tasklet gets rescheduled while running, it will
          * be run again afterwards but without any active request.
          */
-	if (!host->mrq) {
+	if (!host->mmc->areq || !host->mmc->areq->mrq->data) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
 
 	del_timer(&host->timer);
 
+	mrq = host->mmc->areq->mrq;
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
+	    ((mrq->data && mrq->data->error) ||
+	     (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
+
+		/* Some controllers need this kick or reset won't work here */
+		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
+			/* This is to force an update */
+			host->ops->set_clock(host, host->clock);
+
+		sdhci_reset(host, SDHCI_RESET_DATA);
+	}
+
+	host->data = NULL;
+
+#ifndef SDHCI_USE_LEDS_CLASS
+	sdhci_deactivate_led(host);
+#endif
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mmc_request_done(host->mmc, mrq);
+
+	sdhci_runtime_pm_put(host);
+}
+
+static void sdhci_tasklet_finish(unsigned long param)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+	struct mmc_request *mrq;
+	int opcode;
+
+	host = (struct sdhci_host *)param;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	/*
+	 * If this tasklet gets rescheduled while running, it will
+	 * be run again afterwards but without any active request.
+	 */
+	if (!host->mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
 	mrq = host->mrq;
+	BUG_ON(!mrq->cmd);
+	opcode = mrq->cmd->opcode;
+
+	/* for CMD46/47, doesn't delete timer */
+	if (!mmc_op_cmdq_execute_task(opcode))
+		del_timer(&host->timer);
 
 	/*
 	 * The controller needs a reset of internal state machines
@@ -2291,21 +2373,29 @@ static void sdhci_tasklet_finish(unsigned long param)
 		   controllers do not like that. */
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		host->data = NULL;
 	}
 
 	host->mrq = NULL;
 	host->cmd = NULL;
-	host->data = NULL;
 
+	/* CMD46/47 sill have pending data */
+	if (!mmc_op_cmdq_execute_task(opcode)) {
 #ifndef SDHCI_USE_LEDS_CLASS
-	sdhci_deactivate_led(host);
+		sdhci_deactivate_led(host);
 #endif
+	}
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
-	sdhci_runtime_pm_put(host);
+	/*
+	 * host will be put in D0i3 when pending data is done
+	 * for CMD46/47
+	 */
+	if (!mmc_op_cmdq_execute_task(opcode))
+		sdhci_runtime_pm_put(host);
 }
 
 static void sdhci_timeout_timer(unsigned long data)
@@ -2548,7 +2638,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-			if (host->cmd) {
+			if (!host->mmc->context_info.is_cmdq_busy &&
+					host->cmd) {
 				/*
 				 * Data managed to finish before the
 				 * command completed. Make sure we do
@@ -3405,6 +3496,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
+	tasklet_init(&host->finish_async_data_tasklet,
+		sdhci_tasklet_finish_async_data, (unsigned long)host);
 
 	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e639b7f..7cfac3e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -480,6 +480,7 @@ struct sdhci_host {
 	unsigned int align_mask;	/* ADMA alignment mask */
 
 	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
+	struct tasklet_struct finish_async_data_tasklet;
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-- 
1.7.10.4

