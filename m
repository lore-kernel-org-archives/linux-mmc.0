From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] mmc: core: Clarify code which deals with polling in __mmc_switch()
Date: Thu, 20 Oct 2016 10:19:37 +0200
Message-ID: <1476951579-26125-3-git-send-email-ulf.hansson@linaro.org>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35393 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754410AbcJTIT6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 04:19:58 -0400
Received: by mail-lf0-f53.google.com with SMTP id l131so67872909lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 01:19:57 -0700 (PDT)
In-Reply-To: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

The __mmc_switch() deserves a clean-up. In this step, let's move some code
outside of the do-while loop, which deal deals with the card busy polling.

This change simplifies the code in that sense that it becomes easier to follow
what is being executed during card busy polling, but it also gives a better
understanding for when polling isn't done.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f9af1c0..5a77af7 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -535,18 +535,29 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!use_busy_signal)
 		goto out;
 
-	/*
-	 * CRC errors shall only be ignored in cases were CMD13 is used to poll
-	 * to detect busy completion.
-	 */
-	if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
-		ignore_crc = false;
+	/*If SPI or used HW busy detection above, then we don't need to poll. */
+	if (((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp) ||
+		mmc_host_is_spi(host)) {
+		if (send_status)
+			err = mmc_switch_status(card);
+		goto out;
+	}
 
 	/* We have an unspecified cmd timeout, use the fallback value. */
 	if (!timeout_ms)
 		timeout_ms = MMC_OPS_TIMEOUT_MS;
 
-	/* Must check status to be sure of no errors. */
+	/*
+	 * In cases when not allowed to poll by using CMD13 or because we aren't
+	 * capable of polling by using ->card_busy(), then rely on waiting the
+	 * stated timeout to be sufficient.
+	 */
+	if (!send_status && !host->ops->card_busy) {
+		mmc_delay(timeout_ms);
+		goto out;
+	}
+
+	/* Let's poll to find out when the command is completed. */
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		/*
@@ -560,25 +571,11 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 			if (err)
 				goto out;
 		}
-		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
-			break;
 		if (host->ops->card_busy) {
 			if (!host->ops->card_busy(host))
 				break;
 			busy = true;
 		}
-		if (mmc_host_is_spi(host))
-			break;
-
-		/*
-		 * We are not allowed to issue a status command and the host
-		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
-		 * rely on waiting for the stated timeout to be sufficient.
-		 */
-		if (!send_status && !host->ops->card_busy) {
-			mmc_delay(timeout_ms);
-			goto out;
-		}
 
 		/* Timeout if the device never leaves the program state. */
 		if (expired &&
-- 
1.9.1

