From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] mmc: core: Factor out code related to polling in __mmc_switch()
Date: Thu, 20 Oct 2016 10:19:38 +0200
Message-ID: <1476951579-26125-4-git-send-email-ulf.hansson@linaro.org>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35417 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbcJTIUA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 04:20:00 -0400
Received: by mail-lf0-f47.google.com with SMTP id l131so67873866lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 01:19:59 -0700 (PDT)
In-Reply-To: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

In yet another step of cleaning up __mmc_switch(), let's factor out the
code that deals with card busy polling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 108 +++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5a77af7..a84a880 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -468,6 +468,63 @@ int mmc_switch_status(struct mmc_card *card)
 	return mmc_switch_status_error(card->host, status);
 }
 
+static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			bool send_status, bool ignore_crc)
+{
+	struct mmc_host *host = card->host;
+	int err;
+	unsigned long timeout;
+	u32 status = 0;
+	bool expired = false;
+	bool busy = false;
+
+	/* We have an unspecified cmd timeout, use the fallback value. */
+	if (!timeout_ms)
+		timeout_ms = MMC_OPS_TIMEOUT_MS;
+
+	/*
+	 * In cases when not allowed to poll by using CMD13 or because we aren't
+	 * capable of polling by using ->card_busy(), then rely on waiting the
+	 * stated timeout to be sufficient.
+	 */
+	if (!send_status && !host->ops->card_busy) {
+		mmc_delay(timeout_ms);
+		return 0;
+	}
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
+	do {
+		/*
+		 * Due to the possibility of being preempted after
+		 * sending the status command, check the expiration
+		 * time first.
+		 */
+		expired = time_after(jiffies, timeout);
+		if (send_status) {
+			err = __mmc_send_status(card, &status, ignore_crc);
+			if (err)
+				return err;
+		}
+		if (host->ops->card_busy) {
+			if (!host->ops->card_busy(host))
+				break;
+			busy = true;
+		}
+
+		/* Timeout if the device never leaves the program state. */
+		if (expired &&
+		    (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy)) {
+			pr_err("%s: Card stuck in programming state! %s\n",
+				mmc_hostname(host), __func__);
+			return -ETIMEDOUT;
+		}
+	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
+
+	err = mmc_switch_status_error(host, status);
+
+	return err;
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
@@ -489,11 +546,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	struct mmc_host *host = card->host;
 	int err;
 	struct mmc_command cmd = {0};
-	unsigned long timeout;
-	u32 status = 0;
 	bool use_r1b_resp = use_busy_signal;
-	bool expired = false;
-	bool busy = false;
 
 	mmc_retune_hold(host);
 
@@ -543,51 +596,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		goto out;
 	}
 
-	/* We have an unspecified cmd timeout, use the fallback value. */
-	if (!timeout_ms)
-		timeout_ms = MMC_OPS_TIMEOUT_MS;
-
-	/*
-	 * In cases when not allowed to poll by using CMD13 or because we aren't
-	 * capable of polling by using ->card_busy(), then rely on waiting the
-	 * stated timeout to be sufficient.
-	 */
-	if (!send_status && !host->ops->card_busy) {
-		mmc_delay(timeout_ms);
-		goto out;
-	}
-
-	/* Let's poll to find out when the command is completed. */
-	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
-	do {
-		/*
-		 * Due to the possibility of being preempted after
-		 * sending the status command, check the expiration
-		 * time first.
-		 */
-		expired = time_after(jiffies, timeout);
-		if (send_status) {
-			err = __mmc_send_status(card, &status, ignore_crc);
-			if (err)
-				goto out;
-		}
-		if (host->ops->card_busy) {
-			if (!host->ops->card_busy(host))
-				break;
-			busy = true;
-		}
-
-		/* Timeout if the device never leaves the program state. */
-		if (expired &&
-		    (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy)) {
-			pr_err("%s: Card stuck in programming state! %s\n",
-				mmc_hostname(host), __func__);
-			err = -ETIMEDOUT;
-			goto out;
-		}
-	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
-
-	err = mmc_switch_status_error(host, status);
+	/* Let's try to poll to find out when the command is completed. */
+	err = mmc_poll_for_busy(card, timeout_ms, send_status, ignore_crc);
 out:
 	mmc_retune_release(host);
 
-- 
1.9.1

