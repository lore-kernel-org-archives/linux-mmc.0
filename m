From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] mmc: core: Don't use ->card_busy() and CMD13 in combination when polling
Date: Thu, 20 Oct 2016 10:19:39 +0200
Message-ID: <1476951579-26125-5-git-send-email-ulf.hansson@linaro.org>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35439 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbcJTIUB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 04:20:01 -0400
Received: by mail-lf0-f46.google.com with SMTP id l131so67874810lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 01:20:00 -0700 (PDT)
In-Reply-To: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

When polling for busy after sending a MMC_SWITCH command, both the optional
->card_busy() callback and CMD13 are being used in conjunction.

This doesn't make sense. Instead it's more reasonable to rely solely on the
->card_busy() callback when it exists. Let's change that and instead use
the CMD13 as a fall-back. In this way we avoid sending CMD13, unless it's
really needed.

Within this context, let's also take the opportunity to make some
additional clean-ups and clarifications to the related code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index a84a880..481bbdb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -495,34 +495,32 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		/*
-		 * Due to the possibility of being preempted after
-		 * sending the status command, check the expiration
-		 * time first.
+		 * Due to the possibility of being preempted while polling,
+		 * check the expiration time first.
 		 */
 		expired = time_after(jiffies, timeout);
-		if (send_status) {
+
+		if (host->ops->card_busy) {
+			busy = host->ops->card_busy(host);
+		} else {
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
 				return err;
-		}
-		if (host->ops->card_busy) {
-			if (!host->ops->card_busy(host))
-				break;
-			busy = true;
+			busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
 		}
 
-		/* Timeout if the device never leaves the program state. */
-		if (expired &&
-		    (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy)) {
-			pr_err("%s: Card stuck in programming state! %s\n",
+		/* Timeout if the device still remains busy. */
+		if (expired && busy) {
+			pr_err("%s: Card stuck being busy! %s\n",
 				mmc_hostname(host), __func__);
 			return -ETIMEDOUT;
 		}
-	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
+	} while (busy);
 
-	err = mmc_switch_status_error(host, status);
+	if (host->ops->card_busy && send_status)
+		return mmc_switch_status(card);
 
-	return err;
+	return mmc_switch_status_error(host, status);
 }
 
 /**
-- 
1.9.1

