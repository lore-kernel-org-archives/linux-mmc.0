From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 2/5] mmc: msm_sdcc: Add prog done interrupt support
Date: Wed,  8 Dec 2010 15:03:04 +0530
Message-ID: <1291800787-24757-2-git-send-email-stummala@codeaurora.org>
References: <1291800787-24757-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2055 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0LHJeD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 04:34:03 -0500
In-Reply-To: <1291800787-24757-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, dwalker@codeaurora.org, linux-mmc@vger.kernel.org
Cc: san@google.com, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>

Enable prog done interrupt for stop command(CMD12) that is sent
after a multi-block write(CMD25). The PROG_DONE bit is set when
the card has finished its programming and is ready for next data.

After every write request the card will be polled for ready status
using CMD13. For a multi-block write(CMD25) before sending CMD13,
stop command (CMD12) will be sent.  If we enable prog done interrupt
for CMD12, then CMD13 polling can be avoided. The prog done interrupt
means that the card is done with its programming and is ready for
next request.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   28 +++++++++++++++++++++++++---
 drivers/mmc/host/msm_sdcc.h |    4 +++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index b147971..67f536c 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -438,6 +438,11 @@ msmsdcc_start_command_deferred(struct msmsdcc_host *host,
 	      (cmd->opcode == 53))
 		*c |= MCI_CSPM_DATCMD;
 
+	if (host->prog_scan && (cmd->opcode == 12)) {
+		*c |= MCI_CPSM_PROGENA;
+		host->prog_enable = true;
+	}
+
 	if (cmd == cmd->mrq->stop)
 		*c |= MCI_CSPM_MCIABORT;
 
@@ -508,6 +513,8 @@ msmsdcc_start_data(struct msmsdcc_host *host, struct mmc_data *data,
 			host->cmd_c = c;
 		}
 		msm_dmov_enqueue_cmd(host->dma.channel, &host->dma.hdr);
+		if (data->flags & MMC_DATA_WRITE)
+			host->prog_scan = true;
 	} else {
 		msmsdcc_writel(host, timeout, MMCIDATATIMER);
 
@@ -718,8 +725,23 @@ static void msmsdcc_do_cmdirq(struct msmsdcc_host *host, uint32_t status)
 		else if (host->curr.data) { /* Non DMA */
 			msmsdcc_stop_data(host);
 			msmsdcc_request_end(host, cmd->mrq);
-		} else /* host->data == NULL */
-			msmsdcc_request_end(host, cmd->mrq);
+		} else { /* host->data == NULL */
+			if (!cmd->error && host->prog_enable) {
+				if (status & MCI_PROGDONE) {
+					host->prog_scan = false;
+					host->prog_enable = false;
+					msmsdcc_request_end(host, cmd->mrq);
+				} else {
+					host->curr.cmd = cmd;
+				}
+			} else {
+				if (host->prog_enable) {
+					host->prog_scan = false;
+					host->prog_enable = false;
+				}
+				msmsdcc_request_end(host, cmd->mrq);
+			}
+		}
 	} else if (cmd->data)
 		if (!(cmd->data->flags & MMC_DATA_READ))
 			msmsdcc_start_data(host, cmd->data,
@@ -733,7 +755,7 @@ msmsdcc_handle_irq_data(struct msmsdcc_host *host, u32 status,
 	struct mmc_data *data = host->curr.data;
 
 	if (status & (MCI_CMDSENT | MCI_CMDRESPEND | MCI_CMDCRCFAIL |
-	              MCI_CMDTIMEOUT) && host->curr.cmd) {
+			MCI_CMDTIMEOUT | MCI_PROGDONE) && host->curr.cmd) {
 		msmsdcc_do_cmdirq(host, status);
 	}
 
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index 996990d..e0579a1 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -138,7 +138,7 @@
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK)
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|MCI_PROGDONEMASK)
 
 /*
  * The size of the FIFO in bytes.
@@ -245,6 +245,8 @@ struct msmsdcc_host {
 	struct mmc_command	*cmd_cmd;
 	u32			cmd_c;
 
+	bool prog_scan;
+	bool prog_enable;
 };
 
 #endif
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
