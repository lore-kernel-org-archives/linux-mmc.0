From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 10/14] mmc: dw_mmc: guarantee stop-abort cmd in data errors
Date: Wed, 21 Aug 2013 22:51:03 +0900
Message-ID: <002f01ce9e75$7a1ac4e0$6e504ea0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54871 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3HUNvF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:51:05 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV00FYHVT078H0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:51:04 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

In error cases, DTO interrupt may or may not be generated depending
on remained data. Stop/Abort command ensures DTO generation for that
situation. Currently if 'stop' field of data is empty, there is no
stop/abort command. So, it could hang waiting DTO. This change rein-
forces these cases.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   84 +++++++++++++++++++++++++++++++++----------
 include/linux/mmc/dw_mmc.h |    2 +
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9c3205e..88d5f51 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -29,6 +29,7 @@
 #include <linux/irq.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
@@ -246,10 +247,15 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmdr = cmd->opcode;
 
-	if (cmdr == MMC_STOP_TRANSMISSION)
+	if (cmd->opcode == MMC_STOP_TRANSMISSION ||
+	    cmd->opcode == MMC_GO_IDLE_STATE ||
+	    cmd->opcode == MMC_GO_INACTIVE_STATE ||
+	    (cmd->opcode == SD_IO_RW_DIRECT &&
+	     ((cmd->arg >> 9) & 0x1FFFF) == SDIO_CCCR_ABORT))
 		cmdr |= SDMMC_CMD_STOP;
 	else
-		cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
+		if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
+			cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		/* We expect a response, so set this bit */
@@ -276,6 +282,40 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	return cmdr;
 }
 
+static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
+{
+	struct mmc_command *stop;
+	u32 cmdr;
+
+	if (!cmd->data)
+		return 0;
+
+	stop = &host->stop_abort;
+	cmdr = cmd->opcode;
+	memset(stop, 0, sizeof(struct mmc_command));
+
+	if (cmdr == MMC_READ_SINGLE_BLOCK ||
+	    cmdr == MMC_READ_MULTIPLE_BLOCK ||
+	    cmdr == MMC_WRITE_BLOCK ||
+	    cmdr == MMC_WRITE_MULTIPLE_BLOCK) {
+		stop->opcode = MMC_STOP_TRANSMISSION;
+		stop->arg = 0;
+		stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	} else if (cmdr == SD_IO_RW_EXTENDED) {
+		stop->opcode = SD_IO_RW_DIRECT;
+		stop->arg |= (1 << 31) | (0 << 28) | (SDIO_CCCR_ABORT << 9) |
+			     ((cmd->arg >> 28) & 0x7);
+		stop->flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
+	} else {
+		return 0;
+	}
+
+	cmdr = stop->opcode | SDMMC_CMD_STOP |
+		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
+
+	return cmdr;
+}
+
 static void dw_mci_start_command(struct dw_mci *host,
 				 struct mmc_command *cmd, u32 cmd_flags)
 {
@@ -290,9 +330,10 @@ static void dw_mci_start_command(struct dw_mci *host,
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
 }
 
-static void send_stop_cmd(struct dw_mci *host, struct mmc_data *data)
+static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
 {
-	dw_mci_start_command(host, data->stop, host->stop_cmdr);
+	struct mmc_command *stop = data->stop ? data->stop : &host->stop_abort;
+	dw_mci_start_command(host, stop, host->stop_cmdr);
 }
 
 /* DMA interface functions */
@@ -818,6 +859,8 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	if (mrq->stop)
 		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
+	else
+		host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
 }
 
 static void dw_mci_start_request(struct dw_mci *host,
@@ -1182,13 +1225,9 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			if (cmd->data && cmd->error) {
 				dw_mci_stop_dma(host);
-				if (data->stop) {
-					send_stop_cmd(host, data);
-					state = STATE_SENDING_STOP;
-					break;
-				} else {
-					host->data = NULL;
-				}
+				send_stop_abort(host, data);
+				state = STATE_SENDING_STOP;
+				break;
 			}
 
 			if (!host->mrq->data || cmd->error) {
@@ -1203,8 +1242,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			if (test_and_clear_bit(EVENT_DATA_ERROR,
 					       &host->pending_events)) {
 				dw_mci_stop_dma(host);
-				if (data->stop)
-					send_stop_cmd(host, data);
+				send_stop_abort(host, data);
 				state = STATE_DATA_ERROR;
 				break;
 			}
@@ -1264,7 +1302,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				data->error = 0;
 			}
 
-			if (!data->stop) {
+			if (!data->stop && !data->error) {
 				dw_mci_request_end(host, host->mrq);
 				goto unlock;
 			}
@@ -1276,8 +1314,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			}
 
 			prev_state = state = STATE_SENDING_STOP;
-			if (!data->error)
-				send_stop_cmd(host, data);
+			if (data->stop && !data->error) {
+				/* stop command for open-ended transfer*/
+				send_stop_abort(host, data);
+			}
 			/* fall through */
 
 		case STATE_SENDING_STOP:
@@ -1296,7 +1336,12 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			host->cmd = NULL;
 			host->data = NULL;
-			dw_mci_command_complete(host, host->mrq->stop);
+
+			if (host->mrq->stop)
+				dw_mci_command_complete(host, host->mrq->stop);
+			else
+				host->cmd_status = 0;
+
 			dw_mci_request_end(host, host->mrq);
 			goto unlock;
 
@@ -1881,11 +1926,10 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 					case STATE_DATA_ERROR:
 						if (mrq->data->error == -EINPROGRESS)
 							mrq->data->error = -ENOMEDIUM;
-						if (!mrq->stop)
-							break;
 						/* fall through */
 					case STATE_SENDING_STOP:
-						mrq->stop->error = -ENOMEDIUM;
+						if (mrq->stop)
+							mrq->stop->error = -ENOMEDIUM;
 						break;
 					}
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index a829f7e..6ce7d2c 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -15,6 +15,7 @@
 #define LINUX_MMC_DW_MMC_H
 
 #include <linux/scatterlist.h>
+#include <linux/mmc/core.h>
 
 #define MAX_MCI_SLOTS	2
 
@@ -129,6 +130,7 @@ struct dw_mci {
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
+	struct mmc_command	stop_abort;
 	unsigned int		prev_blksz;
 	unsigned char		timing;
 	struct workqueue_struct	*card_workqueue;
-- 
1.7.4.1


