From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] mmc: core: Enable __mmc_switch() to change bus speed timing for the host
Date: Wed, 16 Nov 2016 11:51:16 +0100
Message-ID: <1479293481-20186-5-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34911 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbcKPKvk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:40 -0500
Received: by mail-wm0-f49.google.com with SMTP id a197so230835360wmd.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:39 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

In cases when a speed mode change is requested for mmc cards, a CMD6 is
sent by calling __mmc_switch() during the card initialization. The CMD6
leads to the card entering a busy period. When that is completed, the host
must parse the CMD6 status to find out whether the change of the speed mode
succeeded.

To enable the mmc core to poll the card by using CMD13 to find out when the
busy period is completed, it's reasonable to make sure polling is done by
having the mmc host and the mmc card, being configured to operate at the
same selected bus speed timing.

Therefore, let's extend __mmc_switch() to take yet another parameter, which
allow its callers to update the bus speed timing of the mmc host. In this
way, __mmc_switch() also becomes capable of reading and validating the CMD6
status by sending a CMD13, in cases when that's desired.

If __mmc_switch() encounters a failure, we make sure to restores the old
bus speed timing for the mmc host, before propagating the error code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    |  2 +-
 drivers/mmc/core/mmc.c     | 18 +++++++++---------
 drivers/mmc/core/mmc_ops.c | 20 +++++++++++++++-----
 drivers/mmc/core/mmc_ops.h |  4 ++--
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 50bb9a1..060f767 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -380,7 +380,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	mmc_retune_hold(card->host);
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, timeout,
+			EXT_CSD_BKOPS_START, 1, timeout, 0,
 			use_busy_signal, true, false);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9355366..cb1cf4e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1012,7 +1012,7 @@ static int mmc_select_hs(struct mmc_card *card)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
-			   card->ext_csd.generic_cmd6_time,
+			   card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (!err) {
 		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
@@ -1115,7 +1115,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time,
+			   card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
@@ -1150,7 +1150,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time,
+			   card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
@@ -1193,7 +1193,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
-			   val, card->ext_csd.generic_cmd6_time,
+			   val, card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (err)
 		goto out_err;
@@ -1207,7 +1207,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   true, false, true);
+			   0, true, false, true);
 	if (err)
 		goto out_err;
 
@@ -1221,7 +1221,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
-			   val, card->ext_csd.generic_cmd6_time,
+			   val, card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (err)
 		goto out_err;
@@ -1295,7 +1295,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time,
+			   card->ext_csd.generic_cmd6_time, 0,
 			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
@@ -1377,7 +1377,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
-				   card->ext_csd.generic_cmd6_time,
+				   card->ext_csd.generic_cmd6_time, 0,
 				   true, false, true);
 		if (err)
 			goto err;
@@ -1841,7 +1841,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, true, false, false);
+			notify_type, timeout, 0, true, false, false);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 214e734..ab77fc3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -526,6 +526,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	@value: value to program into EXT_CSD register
  *	@timeout_ms: timeout (ms) for operation performed by register write,
  *                   timeout of zero implies maximum possible timeout
+ *	@timing: new timing to change to
  *	@use_busy_signal: use the busy signal as response type
  *	@send_status: send status cmd to poll for busy
  *	@retry_crc_err: retry when CRC errors when polling with CMD13 for busy
@@ -533,13 +534,14 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
-		bool retry_crc_err)
+		unsigned int timeout_ms, unsigned char timing,
+		bool use_busy_signal, bool send_status,	bool retry_crc_err)
 {
 	struct mmc_host *host = card->host;
 	int err;
 	struct mmc_command cmd = {0};
 	bool use_r1b_resp = use_busy_signal;
+	unsigned char old_timing = host->ios.timing;
 
 	mmc_retune_hold(host);
 
@@ -581,16 +583,24 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!use_busy_signal)
 		goto out;
 
+	/* Switch to new timing before poll and check switch status. */
+	if (timing)
+		mmc_set_timing(host, timing);
+
 	/*If SPI or used HW busy detection above, then we don't need to poll. */
 	if (((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp) ||
 		mmc_host_is_spi(host)) {
 		if (send_status)
 			err = mmc_switch_status(card);
-		goto out;
+		goto out_tim;
 	}
 
 	/* Let's try to poll to find out when the command is completed. */
 	err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
+
+out_tim:
+	if (err && timing)
+		mmc_set_timing(host, old_timing);
 out:
 	mmc_retune_release(host);
 
@@ -600,8 +610,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
-	return __mmc_switch(card, set, index, value, timeout_ms, true, true,
-				false);
+	return __mmc_switch(card, set, index, value, timeout_ms, 0,
+			true, true, false);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9fccddb..761cb69 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -29,8 +29,8 @@
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
-		bool retry_crc_err);
+		unsigned int timeout_ms, unsigned char timing,
+		bool use_busy_signal, bool send_status,	bool retry_crc_err);
 
 #endif
 
-- 
1.9.1

