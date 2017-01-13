From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] mmc: core: retry polling busy when response timeout occurs
Date: Fri, 13 Jan 2017 11:24:55 +0800
Message-ID: <1484277895-94393-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:37015 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdAMD0g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 22:26:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It always assumed that if the card was not ready after finishing
switching the mode, we should got a CRC, namely -EILSEQ, from the
hosts. But the fact is if the host is in higher speed mode but the
eMMC havn't finished the switch, so the host could fail to sample
the resp of CMD13 due to the mismatch timing in between. Could it is
possible that response timeout was generated instaed of -EILSEQ? It's
quite IP specificed. So I don't think we should take the risk of
relying on that. In another word, we don't expect to bail out early
for timeout errors bounced from hosts when polling the status, no
just for explicit CRC.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/mmc_ops.c | 14 +++++++++-----
 drivers/mmc/core/mmc_ops.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index db2969f..a352dea 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -451,7 +451,7 @@ int mmc_switch_status(struct mmc_card *card)
 }
 
 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			bool send_status, bool retry_crc_err)
+			bool send_status, bool retry_crc_and_tmo_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -486,7 +486,8 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			busy = host->ops->card_busy(host);
 		} else {
 			err = mmc_send_status(card, &status);
-			if (retry_crc_err && err == -EILSEQ) {
+			if (retry_crc_and_tmo_err &&
+			    (err == -EILSEQ || err == -ETIMEDOUT)) {
 				busy = true;
 			} else if (err) {
 				return err;
@@ -523,13 +524,15 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@timing: new timing to change to
  *	@use_busy_signal: use the busy signal as response type
  *	@send_status: send status cmd to poll for busy
- *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
+ *	@retry_crc_and_tmo_err: retry when CRC errors or response timeout errors
+ *				when polling with CMD13 for busy
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool use_busy_signal, bool send_status,	bool retry_crc_err)
+		bool use_busy_signal, bool send_status,
+		bool retry_crc_and_tmo_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -590,7 +593,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	}
 
 	/* Let's try to poll to find out when the command is completed. */
-	err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
+	err = mmc_poll_for_busy(card, timeout_ms, send_status,
+				retry_crc_and_tmo_err);
 
 out_tim:
 	if (err && timing)
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index abd525e..fad9963 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -31,7 +31,8 @@
 int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
-		bool use_busy_signal, bool send_status,	bool retry_crc_err);
+		bool use_busy_signal, bool send_status,
+		bool retry_crc_and_tmo_err);
 
 #endif
 
-- 
1.9.1


