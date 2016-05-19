From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/3] mmc: mmc: use ops->card_busy() to check card status in __mmc_switch()
Date: Thu, 19 May 2016 16:47:40 +0800
Message-ID: <1463647662-27426-2-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

some MMC host do not support MMC_CAP_WAIT_WHILE_BUSY but provides
ops->card_busy(), So, add this method to check card status after
switch command.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 62355bd..32de144 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -480,6 +480,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	u32 status = 0;
 	bool use_r1b_resp = use_busy_signal;
 	bool expired = false;
+	bool busy = false;
 
 	mmc_retune_hold(host);
 
@@ -535,19 +536,24 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	/* Must check status to be sure of no errors. */
 	timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
+		/*
+		 * Due to the possibility of being preempted after
+		 * sending the status command, check the expiration
+		 * time first.
+		 */
+		expired = time_after(jiffies, timeout);
 		if (send_status) {
-			/*
-			 * Due to the possibility of being preempted after
-			 * sending the status command, check the expiration
-			 * time first.
-			 */
-			expired = time_after(jiffies, timeout);
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
 				goto out;
 		}
 		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 			break;
+		if (host->ops->card_busy) {
+			if (!host->ops->card_busy(host))
+				break;
+			busy = true;
+		}
 		if (mmc_host_is_spi(host))
 			break;
 
@@ -556,19 +562,20 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
 		 * rely on waiting for the stated timeout to be sufficient.
 		 */
-		if (!send_status) {
+		if (!send_status && !host->ops->card_busy) {
 			mmc_delay(timeout_ms);
 			goto out;
 		}
 
 		/* Timeout if the device never leaves the program state. */
-		if (expired && R1_CURRENT_STATE(status) == R1_STATE_PRG) {
+		if (expired &&
+		    (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy)) {
 			pr_err("%s: Card stuck in programming state! %s\n",
 				mmc_hostname(host), __func__);
 			err = -ETIMEDOUT;
 			goto out;
 		}
-	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
+	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
 
 	err = mmc_switch_status_error(host, status);
 out:
-- 
1.8.1.1.dirty
