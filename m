From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 5/6] mmc: tmio: add CMD23 support
Date: Mon,  1 May 2017 11:03:45 +0200
Message-ID: <20170501090346.10801-6-wsa+renesas@sang-engineering.com>
References: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b3ecb2e2e344c3..a81b86ca735845 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -332,11 +332,11 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 			c |= TRANSFER_MULTI;
 
 			/*
-			 * Disable auto CMD12 at IO_RW_EXTENDED when
-			 * multiple block transfer
+			 * Disable auto CMD12 at IO_RW_EXTENDED and SET_BLOCK_COUNT
+			 * when doing multiple block transfer
 			 */
 			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
-			    (cmd->opcode == SD_IO_RW_EXTENDED))
+			    (cmd->opcode == SD_IO_RW_EXTENDED || host->mrq->sbc))
 				c |= NO_CMD12_ISSUE;
 		}
 		if (data->flags & MMC_DATA_READ)
@@ -513,7 +513,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 			host->mrq);
 	}
 
-	if (stop) {
+	if (stop && !host->mrq->sbc) {
 		if (stop->opcode != MMC_STOP_TRANSMISSION || stop->arg)
 			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
 				stop->opcode, stop->arg);
@@ -820,15 +820,21 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 static void tmio_process_mrq(struct tmio_mmc_host *host, struct mmc_request *mrq)
 {
+	struct mmc_command *cmd;
 	int ret;
 
-	if (mrq->data) {
-		ret = tmio_mmc_start_data(host, mrq->data);
-		if (ret)
-			goto fail;
+	if (mrq->sbc && host->cmd != mrq->sbc) {
+		cmd = mrq->sbc;
+	} else {
+		cmd = mrq->cmd;
+		if (mrq->data) {
+			ret = tmio_mmc_start_data(host, mrq->data);
+			if (ret)
+				goto fail;
+		}
 	}
 
-	ret = tmio_mmc_start_command(host, mrq->cmd);
+	ret = tmio_mmc_start_command(host, cmd);
 	if (ret)
 		goto fail;
 
@@ -883,13 +889,16 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		return;
 	}
 
-	host->cmd = NULL;
-	host->data = NULL;
-	host->force_pio = false;
+	/* If not SET_BLOCK_COUNT, clear old data */
+	if (host->cmd != mrq->sbc) {
+		host->cmd = NULL;
+		host->data = NULL;
+		host->force_pio = false;
+		host->mrq = NULL;
+	}
 
 	cancel_delayed_work(&host->delayed_reset_work);
 
-	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
@@ -898,6 +907,12 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (host->check_scc_error)
 		host->check_scc_error(host);
 
+	/* If SET_BLOCK_COUNT, continue with main command */
+	if (host->mrq) {
+		tmio_process_mrq(host, mrq);
+		return;
+	}
+
 	mmc_request_done(host->mmc, mrq);
 }
 
-- 
2.11.0
