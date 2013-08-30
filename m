From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 19/22] mmc: dw_mmc: rework the code related to cmd/data
 completion
Date: Sat, 31 Aug 2013 00:14:17 +0900
Message-ID: <001601cea593$98a68af0$c9f3a0d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38695 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3H3POT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:14:19 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC0048VNNUSZL0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:14:18 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Main change corresponds to dw_mci_command_complete().
And EBE is divided into read and write.
Some minor changes make the code readability

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |  147 ++++++++++++++++++++++++++-------------------
 1 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b724827..334ee04 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -845,7 +845,9 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	host->pending_events = 0;
 	host->completed_events = 0;
+	host->cmd_status = 0;
 	host->data_status = 0;
+	host->dir_status = 0;
 
 	data = cmd->data;
 	if (data) {
@@ -1157,7 +1159,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	spin_lock(&host->lock);
 }
 
-static void dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
+static int dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
 {
 	u32 status = host->cmd_status;
 
@@ -1192,6 +1194,57 @@ static void dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd
 		if (host->quirks & DW_MCI_QUIRK_RETRY_DELAY)
 			mdelay(20);
 	}
+
+	return cmd->error;
+}
+
+static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
+{
+	u32 status = host->data_status, ctrl;
+
+	if (status & DW_MCI_DATA_ERROR_FLAGS) {
+		if (status & SDMMC_INT_DRTO) {
+			data->error = -ETIMEDOUT;
+		} else if (status & SDMMC_INT_DCRC) {
+			data->error = -EILSEQ;
+		} else if (status & SDMMC_INT_EBE) {
+			if (host->dir_status ==
+				DW_MCI_SEND_STATUS) {
+				/*
+				 * No data CRC status was returned.
+				 * The number of bytes transferred
+				 * will be exaggerated in PIO mode.
+				 */
+				data->bytes_xfered = 0;
+				data->error = -ETIMEDOUT;
+			} else if (host->dir_status ==
+					DW_MCI_RECV_STATUS) {
+				data->error = -EIO;
+			}
+		} else {
+			/* SDMMC_INT_SBE is included */
+			data->error = -EIO;
+		}
+
+		dev_err(host->dev, "data error, status 0x%08x\n", status);
+
+		/*
+		 * After an error, there may be data lingering
+		 * in the FIFO, so reset it - doing so
+		 * generates a block interrupt, hence setting
+		 * the scatter-gather pointer to NULL.
+		 */
+		sg_miter_stop(&host->sg_miter);
+		host->sg = NULL;
+		ctrl = mci_readl(host, CTRL);
+		ctrl |= SDMMC_CTRL_FIFO_RESET;
+		mci_writel(host, CTRL, ctrl);
+	} else {
+		data->bytes_xfered = data->blocks * data->blksz;
+		data->error = 0;
+	}
+
+	return data->error;
 }
 
 static void dw_mci_tasklet_func(unsigned long priv)
@@ -1199,14 +1252,17 @@ static void dw_mci_tasklet_func(unsigned long priv)
 	struct dw_mci *host = (struct dw_mci *)priv;
 	struct mmc_data	*data;
 	struct mmc_command *cmd;
+	struct mmc_request *mrq;
 	enum dw_mci_state state;
 	enum dw_mci_state prev_state;
-	u32 status, ctrl;
+	u32 ctrl;
+	unsigned int err;
 
 	spin_lock(&host->lock);
 
 	state = host->state;
 	data = host->data;
+	mrq = host->mrq;
 
 	do {
 		prev_state = state;
@@ -1223,23 +1279,23 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			cmd = host->cmd;
 			host->cmd = NULL;
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
-			dw_mci_command_complete(host, cmd);
-			if (cmd == host->mrq->sbc && !cmd->error) {
+			err = dw_mci_command_complete(host, cmd);
+			if (cmd == mrq->sbc && !err) {
 				prev_state = state = STATE_SENDING_CMD;
 				__dw_mci_start_request(host, host->cur_slot,
-						       host->mrq->cmd);
+						       mrq->cmd);
 				goto unlock;
 			}
 
-			if (cmd->data && cmd->error) {
+			if (cmd->data && err) {
 				dw_mci_stop_dma(host);
 				send_stop_abort(host, data);
 				state = STATE_SENDING_STOP;
 				break;
 			}
 
-			if (!host->mrq->data || cmd->error) {
-				dw_mci_request_end(host, host->mrq);
+			if (!cmd->data || err) {
+				dw_mci_request_end(host, mrq);
 				goto unlock;
 			}
 
@@ -1270,62 +1326,27 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			host->data = NULL;
 			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
-			status = host->data_status;
-
-			if (status & DW_MCI_DATA_ERROR_FLAGS) {
-				if (status & SDMMC_INT_DRTO) {
-					data->error = -ETIMEDOUT;
-				} else if (status & SDMMC_INT_DCRC) {
-					data->error = -EILSEQ;
-				} else if (status & SDMMC_INT_EBE &&
-					   host->dir_status ==
-							DW_MCI_SEND_STATUS) {
-					/*
-					 * No data CRC status was returned.
-					 * The number of bytes transferred will
-					 * be exaggerated in PIO mode.
-					 */
-					data->bytes_xfered = 0;
-					data->error = -ETIMEDOUT;
-				} else {
-					dev_err(host->dev,
-						"data FIFO error "
-						"(status=%08x)\n",
-						status);
-					data->error = -EIO;
-				}
-				/*
-				 * After an error, there may be data lingering
-				 * in the FIFO, so reset it - doing so
-				 * generates a block interrupt, hence setting
-				 * the scatter-gather pointer to NULL.
-				 */
-				sg_miter_stop(&host->sg_miter);
-				host->sg = NULL;
-				ctrl = mci_readl(host, CTRL);
-				ctrl |= SDMMC_CTRL_FIFO_RESET;
-				mci_writel(host, CTRL, ctrl);
-			} else {
-				data->bytes_xfered = data->blocks * data->blksz;
-				data->error = 0;
-			}
+			err = dw_mci_data_complete(host, data);
 
-			if (!data->stop && !data->error) {
-				dw_mci_request_end(host, host->mrq);
-				goto unlock;
-			}
+			if (!err) {
+				if (!data->stop || mrq->sbc) {
+					if (mrq->sbc)
+						data->stop->error = 0;
+					dw_mci_request_end(host, mrq);
+					goto unlock;
+				}
 
-			if (host->mrq->sbc && !data->error) {
-				data->stop->error = 0;
-				dw_mci_request_end(host, host->mrq);
-				goto unlock;
+				/* stop command for open-ended transfer*/
+				if (data->stop)
+					send_stop_abort(host, data);
 			}
 
+			/*
+			 * If err has non-zero,
+			 * stop-abort command has been already issued.
+			 */
 			prev_state = state = STATE_SENDING_STOP;
-			if (data->stop && !data->error) {
-				/* stop command for open-ended transfer*/
-				send_stop_abort(host, data);
-			}
+
 			/* fall through */
 
 		case STATE_SENDING_STOP:
@@ -1334,7 +1355,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				break;
 
 			/* CMD error in data command */
-			if (host->mrq->cmd->error && host->mrq->data) {
+			if (mrq->cmd->error && mrq->data) {
 				sg_miter_stop(&host->sg_miter);
 				host->sg = NULL;
 				ctrl = mci_readl(host, CTRL);
@@ -1345,12 +1366,12 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			host->cmd = NULL;
 			host->data = NULL;
 
-			if (host->mrq->stop)
-				dw_mci_command_complete(host, host->mrq->stop);
+			if (mrq->stop)
+				dw_mci_command_complete(host, mrq->stop);
 			else
 				host->cmd_status = 0;
 
-			dw_mci_request_end(host, host->mrq);
+			dw_mci_request_end(host, mrq);
 			goto unlock;
 
 		case STATE_DATA_ERROR:
-- 
1.7.0.4


