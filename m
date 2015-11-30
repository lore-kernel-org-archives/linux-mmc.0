From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v4] mmc: core: fix __mmc_switch timeout caused by preempt
Date: Mon, 30 Nov 2015 09:27:30 +0800
Message-ID: <1448846850-14585-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:34226 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751340AbbK3B2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2015 20:28:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Adrian Hunter <adrian.hunter@intel.com>, Minda Chen <Minda.Chen@csr.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com

there is a time window between __mmc_send_status() and time_afer(),
on some eMMC chip, the timeout_ms is only 10ms, if this thread was
scheduled out during this period, then, even card has already changes
to transfer state by the result of CMD13, this part of code also treat
it to timeout error.
So, need calculate timeout first, then call __mmc_send_status(), if
already timeout and card still in programing state, then treat it to
the real timeout error.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1f44426..2c90635 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -489,6 +489,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	unsigned long timeout;
 	u32 status = 0;
 	bool use_r1b_resp = use_busy_signal;
+	bool expired = false;
 
 	mmc_retune_hold(host);
 
@@ -545,6 +546,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
 		if (send_status) {
+			/*
+			 * Due to the possibility of being preempted after
+			 * sending the status command, check the expiration
+			 * time first.
+			 */
+			expired = time_after(jiffies, timeout);
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
 				goto out;
@@ -565,7 +572,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		}
 
 		/* Timeout if the device never leaves the program state. */
-		if (time_after(jiffies, timeout)) {
+		if (expired && R1_CURRENT_STATE(status) == R1_STATE_PRG) {
 			pr_err("%s: Card stuck in programming state! %s\n",
 				mmc_hostname(host), __func__);
 			err = -ETIMEDOUT;
-- 
1.8.1.1.dirty

