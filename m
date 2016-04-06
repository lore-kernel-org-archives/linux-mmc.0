From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] mmc: Remove some redundant debug prints
Date: Wed,  6 Apr 2016 19:38:30 +0800
Message-ID: <5cddc2f870eccf8cf50d463c72d2908dad9e1017.1459942344.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34820 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbcDFLjb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 07:39:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id n1so31894711pfn.2
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2016 04:39:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, baolin.wang@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

This patch removes some redundant debug prints, since we have added some
tracepoints to help with performance analysis of MMC subsystem.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/core/core.c |   52 -----------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f80b3ab..3f1362a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -157,33 +157,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		led_trigger_event(host->led, LED_OFF);
 
-		if (mrq->sbc) {
-			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
-				mmc_hostname(host), mrq->sbc->opcode,
-				mrq->sbc->error,
-				mrq->sbc->resp[0], mrq->sbc->resp[1],
-				mrq->sbc->resp[2], mrq->sbc->resp[3]);
-		}
-
-		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
-			mmc_hostname(host), cmd->opcode, err,
-			cmd->resp[0], cmd->resp[1],
-			cmd->resp[2], cmd->resp[3]);
-
-		if (mrq->data) {
-			pr_debug("%s:     %d bytes transferred: %d\n",
-				mmc_hostname(host),
-				mrq->data->bytes_xfered, mrq->data->error);
-		}
-
-		if (mrq->stop) {
-			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
-				mmc_hostname(host), mrq->stop->opcode,
-				mrq->stop->error,
-				mrq->stop->resp[0], mrq->stop->resp[1],
-				mrq->stop->resp[2], mrq->stop->resp[3]);
-		}
-
 		if (mrq->done)
 			mrq->done(mrq);
 	}
@@ -236,31 +209,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
-	if (mrq->sbc) {
-		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
-			 mmc_hostname(host), mrq->sbc->opcode,
-			 mrq->sbc->arg, mrq->sbc->flags);
-	}
-
-	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
-		 mmc_hostname(host), mrq->cmd->opcode,
-		 mrq->cmd->arg, mrq->cmd->flags);
-
-	if (mrq->data) {
-		pr_debug("%s:     blksz %d blocks %d flags %08x "
-			"tsac %d ms nsac %d\n",
-			mmc_hostname(host), mrq->data->blksz,
-			mrq->data->blocks, mrq->data->flags,
-			mrq->data->timeout_ns / 1000000,
-			mrq->data->timeout_clks);
-	}
-
-	if (mrq->stop) {
-		pr_debug("%s:     CMD%u arg %08x flags %08x\n",
-			 mmc_hostname(host), mrq->stop->opcode,
-			 mrq->stop->arg, mrq->stop->flags);
-	}
-
 	WARN_ON(!host->claimed);
 
 	mrq->cmd->error = 0;
-- 
1.7.9.5

