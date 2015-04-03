From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [V2 PATCH 1/5] mmc: replace sbc to precmd and add postcmd
Date: Fri, 3 Apr 2015 19:25:17 +0800
Message-ID: <20150403112517.GB29880@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13333 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbbDCL1Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Apr 2015 07:27:25 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alex.Lemberg@sandisk.com

right now we use sbc to present CMD23. If we want sbc to present
other cmds, then it is not suitable. So change the name to precmd
which means a cmd that needs to be sent before a cmd. So it can sent
any command without misunderstanding

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/card/block.c      |   27 ++++++++++++++-------------
 drivers/mmc/card/queue.h      |    3 ++-
 drivers/mmc/core/core.c       |   22 +++++++++++-----------
 drivers/mmc/host/dw_mmc.c     |    8 ++++----
 drivers/mmc/host/mmci.c       |   14 +++++++-------
 drivers/mmc/host/omap_hsmmc.c |   18 +++++++++---------
 drivers/mmc/host/sdhci.c      |   20 +++++++++++---------
 include/linux/mmc/core.h      |    3 ++-
 8 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..ed62d6b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -966,8 +966,9 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	}
 
 	/* Check for set block count errors */
-	if (brq->sbc.error)
-		return mmc_blk_cmd_error(req, "SET_BLOCK_COUNT", brq->sbc.error,
+	if (brq->precmd.error)
+		return mmc_blk_cmd_error(req, "SET_BLOCK_COUNT",
+				brq->precmd.error,
 				prev_cmd_status_valid, status);
 
 	/* Check for r/w command errors */
@@ -1195,7 +1196,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	int ecc_err = 0, gen_err = 0;
 
 	/*
-	 * sbc.error indicates a problem with the set block count
+	 * precmd.error indicates a problem with the set block count
 	 * command.  No data will have been transferred.
 	 *
 	 * cmd.error indicates a problem with the r/w command.  No
@@ -1204,7 +1205,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
+	if (brq->precmd.error || brq->cmd.error || brq->stop.error ||
 	    brq->data.error) {
 		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
 		case ERR_RETRY:
@@ -1454,7 +1455,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	 * with Auto-CMD23 enhancements provided by some
 	 * hosts, means that the complexity of dealing
 	 * with this is best left to the host. If CMD23 is
-	 * supported by card and host, we'll fill sbc in and let
+	 * supported by card and host, we'll fill precmd in and let
 	 * the host deal with handling it correctly. This means
 	 * that for hosts that don't expose MMC_CAP_CMD23, no
 	 * change of behavior will be observed.
@@ -1466,12 +1467,12 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
 	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
 	     do_data_tag)) {
-		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
-		brq->sbc.arg = brq->data.blocks |
+		brq->precmd.opcode = MMC_SET_BLOCK_COUNT;
+		brq->precmd.arg = brq->data.blocks |
 			(do_rel_wr ? (1 << 31) : 0) |
 			(do_data_tag ? (1 << 29) : 0);
-		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
-		brq->mrq.sbc = &brq->sbc;
+		brq->precmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		brq->mrq.precmd = &brq->precmd;
 	}
 
 	mmc_set_data_timeout(&brq->data, card);
@@ -1680,12 +1681,12 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 	brq->mrq.cmd = &brq->cmd;
 	brq->mrq.data = &brq->data;
-	brq->mrq.sbc = &brq->sbc;
+	brq->mrq.precmd = &brq->precmd;
 	brq->mrq.stop = &brq->stop;
 
-	brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
-	brq->sbc.arg = MMC_CMD23_ARG_PACKED | (packed->blocks + hdr_blocks);
-	brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	brq->precmd.opcode = MMC_SET_BLOCK_COUNT;
+	brq->precmd.arg = MMC_CMD23_ARG_PACKED | (packed->blocks + hdr_blocks);
+	brq->precmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
 	brq->cmd.opcode = MMC_WRITE_MULTIPLE_BLOCK;
 	brq->cmd.arg = blk_rq_pos(req);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 5752d50..b129ddc 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -8,8 +8,9 @@ struct task_struct;
 
 struct mmc_blk_request {
 	struct mmc_request	mrq;
-	struct mmc_command	sbc;
+	struct mmc_command	precmd;
 	struct mmc_command	cmd;
+	struct mmc_command	postcmd;
 	struct mmc_command	stop;
 	struct mmc_data		data;
 };
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..75c67d9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -150,12 +150,12 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		led_trigger_event(host->led, LED_OFF);
 
-		if (mrq->sbc) {
+		if (mrq->precmd) {
 			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
-				mmc_hostname(host), mrq->sbc->opcode,
-				mrq->sbc->error,
-				mrq->sbc->resp[0], mrq->sbc->resp[1],
-				mrq->sbc->resp[2], mrq->sbc->resp[3]);
+				mmc_hostname(host), mrq->precmd->opcode,
+				mrq->precmd->error,
+				mrq->precmd->resp[0], mrq->precmd->resp[1],
+				mrq->precmd->resp[2], mrq->precmd->resp[3]);
 		}
 
 		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
@@ -195,10 +195,10 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
-	if (mrq->sbc) {
+	if (mrq->precmd) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
-			 mmc_hostname(host), mrq->sbc->opcode,
-			 mrq->sbc->arg, mrq->sbc->flags);
+			 mmc_hostname(host), mrq->precmd->opcode,
+			 mrq->precmd->arg, mrq->precmd->flags);
 	}
 
 	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
@@ -224,9 +224,9 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	mrq->cmd->error = 0;
 	mrq->cmd->mrq = mrq;
-	if (mrq->sbc) {
-		mrq->sbc->error = 0;
-		mrq->sbc->mrq = mrq;
+	if (mrq->precmd) {
+		mrq->precmd->error = 0;
+		mrq->precmd->mrq = mrq;
 	}
 	if (mrq->data) {
 		BUG_ON(mrq->data->blksz > host->max_blk_size);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3883fe6..633b4bb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1042,7 +1042,7 @@ static void dw_mci_start_request(struct dw_mci *host,
 	struct mmc_request *mrq = slot->mrq;
 	struct mmc_command *cmd;
 
-	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
+	cmd = mrq->precmd ? mrq->precmd : mrq->cmd;
 	__dw_mci_start_request(host, slot, cmd);
 }
 
@@ -1551,7 +1551,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			host->cmd = NULL;
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
 			err = dw_mci_command_complete(host, cmd);
-			if (cmd == mrq->sbc && !err) {
+			if (cmd == mrq->precmd && !err) {
 				prev_state = state = STATE_SENDING_CMD;
 				__dw_mci_start_request(host, host->cur_slot,
 						       mrq->cmd);
@@ -1636,8 +1636,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			err = dw_mci_data_complete(host, data);
 
 			if (!err) {
-				if (!data->stop || mrq->sbc) {
-					if (mrq->sbc && data->stop)
+				if (!data->stop || mrq->precmd) {
+					if (mrq->precmd && data->stop)
 						data->stop->error = 0;
 					dw_mci_request_end(host, mrq);
 					goto unlock;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fb26674..c4b210a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -968,7 +968,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop || host->mrq->sbc) {
+		if (!data->stop || host->mrq->precmd) {
 			mmci_request_end(host, data->mrq);
 		} else {
 			mmci_start_command(host, data->stop, 0);
@@ -981,12 +981,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
-	bool sbc, busy_resp;
+	bool precmd, busy_resp;
 
 	if (!cmd)
 		return;
 
-	sbc = (cmd == host->mrq->sbc);
+	precmd = (cmd == host->mrq->precmd);
 	busy_resp = host->variant->busy_detect && (cmd->flags & MMC_RSP_BUSY);
 
 	if (!((status|host->busy_status) & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|
@@ -1027,7 +1027,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
-	if ((!sbc && !cmd->data) || cmd->error) {
+	if ((!precmd && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
 			if (dma_inprogress(host)) {
@@ -1037,7 +1037,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 			mmci_stop_data(host);
 		}
 		mmci_request_end(host, host->mrq);
-	} else if (sbc) {
+	} else if (precmd) {
 		mmci_start_command(host, host->mrq->cmd, 0);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
@@ -1302,8 +1302,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data && mrq->data->flags & MMC_DATA_READ)
 		mmci_start_data(host, mrq->data);
 
-	if (mrq->sbc)
-		mmci_start_command(host, mrq->sbc, 0);
+	if (mrq->precmd)
+		mmci_start_command(host, mrq->precmd, 0);
 	else
 		mmci_start_command(host, mrq->cmd, 0);
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9df2b68..f41b660 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -810,9 +810,9 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
 
 	if ((host->flags & AUTO_CMD23) && mmc_op_multi(cmd->opcode) &&
-	    host->mrq->sbc) {
+	    host->mrq->precmd) {
 		cmdreg |= ACEN_ACMD23;
-		OMAP_HSMMC_WRITE(host->base, SDMASA, host->mrq->sbc->arg);
+		OMAP_HSMMC_WRITE(host->base, SDMASA, host->mrq->precmd->arg);
 	}
 	if (data) {
 		cmdreg |= DP_SELECT | MSBS | BCE;
@@ -893,7 +893,7 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 	else
 		data->bytes_xfered = 0;
 
-	if (data->stop && (data->error || !host->mrq->sbc))
+	if (data->stop && (data->error || !host->mrq->precmd))
 		omap_hsmmc_start_command(host, data->stop, NULL);
 	else
 		omap_hsmmc_request_done(host, data->mrq);
@@ -905,8 +905,8 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 static void
 omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 {
-	if (host->mrq->sbc && (host->cmd == host->mrq->sbc) &&
-	    !host->mrq->sbc->error && !(host->flags & AUTO_CMD23)) {
+	if (host->mrq->precmd && (host->cmd == host->mrq->precmd) &&
+	    !host->mrq->precmd->error && !(host->flags & AUTO_CMD23)) {
 		host->cmd = NULL;
 		omap_hsmmc_start_dma_transfer(host);
 		omap_hsmmc_start_command(host, host->mrq->cmd,
@@ -1070,13 +1070,13 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		if (status & ACE_EN) {
 			u32 ac12;
 			ac12 = OMAP_HSMMC_READ(host->base, AC12);
-			if (!(ac12 & ACNE) && host->mrq->sbc) {
+			if (!(ac12 & ACNE) && host->mrq->precmd) {
 				end_cmd = 1;
 				if (ac12 & ACTO)
 					error =  -ETIMEDOUT;
 				else if (ac12 & (ACCE | ACEB | ACIE))
 					error = -EILSEQ;
-				host->mrq->sbc->error = error;
+				host->mrq->precmd->error = error;
 				hsmmc_command_incomplete(host, error, end_cmd);
 			}
 			dev_dbg(mmc_dev(host->mmc), "AC12 err: 0x%x\n", ac12);
@@ -1547,8 +1547,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		pm_runtime_put_autosuspend(host->dev);
 		return;
 	}
-	if (req->sbc && !(host->flags & AUTO_CMD23)) {
-		omap_hsmmc_start_command(host, req->sbc, NULL);
+	if (req->precmd && !(host->flags & AUTO_CMD23)) {
+		omap_hsmmc_start_command(host, req->precmd, NULL);
 		return;
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..aad89d2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -933,12 +933,14 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+		if (!host->mrq->precmd && (host->flags & SDHCI_AUTO_CMD12) &&
 		    (cmd->opcode != SD_IO_RW_EXTENDED))
 			mode |= SDHCI_TRNS_AUTO_CMD12;
-		else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+		else if (host->mrq->precmd &&
+				(host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-			sdhci_writel(host, host->mrq->sbc->arg, SDHCI_ARGUMENT2);
+			sdhci_writel(host, host->mrq->precmd->arg,
+					SDHCI_ARGUMENT2);
 		}
 	}
 
@@ -990,7 +992,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	 */
 	if (data->stop &&
 	    (data->error ||
-	     !host->mrq->sbc)) {
+	     !host->mrq->precmd)) {
 
 		/*
 		 * The controller needs a reset of internal state machines
@@ -1111,7 +1113,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	host->cmd->error = 0;
 
 	/* Finished CMD23, now send actual command. */
-	if (host->cmd == host->mrq->sbc) {
+	if (host->cmd == host->mrq->precmd) {
 		host->cmd = NULL;
 		sdhci_send_command(host, host->mrq->cmd);
 	} else {
@@ -1374,7 +1376,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
 	 * requests if Auto-CMD12 is enabled.
 	 */
-	if (!mrq->sbc && (host->flags & SDHCI_AUTO_CMD12)) {
+	if (!mrq->precmd && (host->flags & SDHCI_AUTO_CMD12)) {
 		if (mrq->stop) {
 			mrq->data->stop = NULL;
 			mrq->stop = NULL;
@@ -1420,8 +1422,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			}
 		}
 
-		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
-			sdhci_send_command(host, mrq->sbc);
+		if (mrq->precmd && !(host->flags & SDHCI_AUTO_CMD23))
+			sdhci_send_command(host, mrq->precmd);
 		else
 			sdhci_send_command(host, mrq->cmd);
 	}
@@ -2275,7 +2277,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	 */
 	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
 	    ((mrq->cmd && mrq->cmd->error) ||
-	     (mrq->sbc && mrq->sbc->error) ||
+	     (mrq->precmd && mrq->precmd->error) ||
 	     (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
 			    (mrq->data->stop && mrq->data->stop->error))) ||
 	     (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 160448f..8445ecb 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -127,8 +127,9 @@ struct mmc_data {
 
 struct mmc_host;
 struct mmc_request {
-	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
+	struct mmc_command	*precmd;
 	struct mmc_command	*cmd;
+	struct mmc_command	*postcmd;
 	struct mmc_data		*data;
 	struct mmc_command	*stop;
 
-- 
1.7.10.4

