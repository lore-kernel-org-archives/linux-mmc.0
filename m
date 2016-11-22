From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/7] mmc: core: Rename ignore_crc to retry_crc_err to reflect its purpose
Date: Tue, 22 Nov 2016 21:56:09 +0100
Message-ID: <1479848173-20881-4-git-send-email-ulf.hansson@linaro.org>
References: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35804 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756805AbcKVU4y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 15:56:54 -0500
Received: by mail-wm0-f54.google.com with SMTP id a197so46218303wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 12:56:26 -0800 (PST)
In-Reply-To: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

The ignore_crc parameter/variable name is used at a couple of places in the
mmc core. Let's rename it to retry_crc_err to reflect its new purpose.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 10 +++++-----
 drivers/mmc/core/mmc_ops.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0515748..214e734 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -461,7 +461,7 @@ int mmc_switch_status(struct mmc_card *card)
 }
 
 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool ignore_crc)
+			bool send_status, bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -496,7 +496,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			busy = host->ops->card_busy(host);
 		} else {
 			err = mmc_send_status(card, &status);
-			if (ignore_crc && err == -EILSEQ)
+			if (retry_crc_err && err == -EILSEQ)
 				busy = true;
 			else if (err)
 				return err;
@@ -528,13 +528,13 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *                   timeout of zero implies maximum possible timeout
  *	@use_busy_signal: use the busy signal as response type
  *	@send_status: send status cmd to poll for busy
- *	@ignore_crc: ignore CRC errors when sending status cmd to poll for busy
+ *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
-		bool ignore_crc)
+		bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -590,7 +590,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	}
 
 	/* Let's try to poll to find out when the command is completed. */
-	err = mmc_poll_for_busy(card, timeout_ms, send_status, ignore_crc);
+	err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
 out:
 	mmc_retune_release(host);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 7f6c0e9..9fccddb 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -30,7 +30,7 @@
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
-		bool ignore_crc);
+		bool retry_crc_err);
 
 #endif
 
-- 
1.9.1

