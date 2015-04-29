From: <micky_ching@realsil.com.cn>
Subject: [PATCH 04/12] mmc: core: add tlp request handler for SD4.0
Date: Wed, 29 Apr 2015 09:23:36 +0800
Message-ID: <6a08b99dfeb56730519ee78d7f30b3bd1dffa937.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:48861 "EHLO
	rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031266AbbD2Be0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2015 21:34:26 -0400
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn, Micky Ching <micky_ching@realsil.com.cn>

From: Micky Ching <micky_ching@realsil.com.cn>

when card is work in SD4.0 mode, we should send tlp instead of cmd.
add this function to handle tlp request.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/core.c | 111 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..ebb6fea 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -45,6 +45,7 @@
 #include "mmc_ops.h"
 #include "sd_ops.h"
 #include "sdio_ops.h"
+#include "sd.h"
 
 /* If the device is not responding */
 #define MMC_CORE_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
@@ -131,7 +132,42 @@ static inline void mmc_should_fail_request(struct mmc_host *host,
 void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd = mrq->cmd;
-	int err = cmd->error;
+	struct mmc_tlp *tlp = mrq->tlp;
+	int err;
+
+	if (tlp && cmd)
+		pr_debug("%s: cmd and native tlp conflict, done native tlp\n",
+			mmc_hostname(host));
+
+	if (tlp) {
+		err = tlp->error;
+		if (err && tlp->retries && !mmc_card_removed(host->card)) {
+			/*
+			 * Request starter must handle retries - see
+			 * mmc_wait_for_req_done().
+			 */
+			if (mrq->done)
+				mrq->done(mrq);
+		} else {
+			led_trigger_event(host->led, LED_OFF);
+
+			pr_debug("%s: native TLP req done(%d) %04x %04x %08x %08x %08x %08x\n",
+				mmc_hostname(host), err,
+				tlp->tlp_back->header, tlp->tlp_back->argument,
+				tlp->tlp_back->payload[0],
+				tlp->tlp_back->payload[1],
+				tlp->tlp_back->payload[2],
+				tlp->tlp_back->payload[3]);
+
+			if (mrq->done)
+				mrq->done(mrq);
+
+			mmc_host_clk_release(host);
+		}
+		return;
+	}
+
+	err = cmd->error;
 
 	if (err && cmd->retries && mmc_host_is_spi(host)) {
 		if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
@@ -201,9 +237,18 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			 mrq->sbc->arg, mrq->sbc->flags);
 	}
 
-	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
-		 mmc_hostname(host), mrq->cmd->opcode,
-		 mrq->cmd->arg, mrq->cmd->flags);
+	if (mrq->tlp && mrq->cmd)
+		pr_debug("%s: cmd and native tlp conflict, start native tlp\n",
+			mmc_hostname(host));
+
+	if (mrq->tlp)
+		pr_debug("%s: starting native TLP header %04x argument %04x\n",
+			 mmc_hostname(host), mrq->tlp->tlp_send->header,
+			 mrq->tlp->tlp_send->argument);
+	else if (mrq->cmd)
+		pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
+			 mmc_hostname(host), mrq->cmd->opcode,
+			 mrq->cmd->arg, mrq->cmd->flags);
 
 	if (mrq->data) {
 		pr_debug("%s:     blksz %d blocks %d flags %08x "
@@ -221,6 +266,8 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	}
 
 	WARN_ON(!host->claimed);
+	if (!mrq->cmd)
+		goto start;
 
 	mrq->cmd->error = 0;
 	mrq->cmd->mrq = mrq;
@@ -250,6 +297,25 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
+
+	if (mmc_card_uhsii(host->card)) {
+		mrq->cmd->use_tlp = true;
+		if (mrq->data)
+			mmc_sd_tran_pack_dcmd(host->card, mrq->cmd);
+		else
+			mmc_sd_tran_pack_ccmd(host->card, mrq->cmd);
+
+		if (mrq->sbc) {
+			mrq->sbc->use_tlp = true;
+			mmc_sd_tran_pack_ccmd(host->card, mrq->sbc);
+		}
+		if (mrq->stop) {
+			mrq->stop->use_tlp = true;
+			mmc_sd_tran_pack_ccmd(host->card, mrq->stop);
+		}
+	}
+
+start:
 	mmc_host_clk_hold(host);
 	led_trigger_event(host->led, LED_FULL);
 	host->ops->request(host, mrq);
@@ -356,7 +422,7 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	err = mmc_start_request(host, mrq);
 	if (err) {
-		mrq->cmd->error = err;
+		mmc_set_mrq_error_code(mrq, err);
 		mmc_wait_data_done(mrq);
 	}
 
@@ -372,7 +438,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	err = mmc_start_request(host, mrq);
 	if (err) {
-		mrq->cmd->error = err;
+		mmc_set_mrq_error_code(mrq, err);
 		complete(&mrq->completion);
 	}
 
@@ -436,7 +502,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 	return err;
 }
 
-static void mmc_wait_for_req_done(struct mmc_host *host,
+static void mmc_wait_for_cmd_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
@@ -475,6 +541,37 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 	}
 }
 
+static void mmc_wait_for_tlp_req_done(struct mmc_host *host,
+				  struct mmc_request *mrq)
+{
+	struct mmc_tlp *tlp;
+
+	while (1) {
+		wait_for_completion(&mrq->completion);
+
+		tlp = mrq->tlp;
+
+		if (!tlp->error || !tlp->retries ||
+			mmc_card_removed(host->card))
+			break;
+
+		pr_debug("%s: native TLP req failed: %d, retrying...\n",
+			mmc_hostname(host), tlp->error);
+		tlp->retries--;
+		tlp->error = 0;
+		host->ops->request(host, mrq);
+	}
+}
+
+static void mmc_wait_for_req_done(struct mmc_host *host,
+	struct mmc_request *mrq)
+{
+	if (mrq->cmd)
+		mmc_wait_for_cmd_req_done(host, mrq);
+	else
+		mmc_wait_for_tlp_req_done(host, mrq);
+}
+
 /**
  *	mmc_pre_req - Prepare for a new request
  *	@host: MMC host to prepare command
-- 
1.9.1

