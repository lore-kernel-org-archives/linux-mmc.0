From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/10] mmc: core: Add ignore_crc flag to __mmc_switch
Date: Wed, 22 Jan 2014 16:00:17 +0100
Message-ID: <1390402824-9850-4-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:49074 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaAVPAf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:35 -0500
Received: by mail-wi0-f182.google.com with SMTP id ex4so677726wid.9
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:34 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Instead of handle specific adaptations, releated to certain switch
operations, inside __mmc_switch, push this to be handled by the caller
instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    |    3 ++-
 drivers/mmc/core/mmc.c     |   13 +++++++------
 drivers/mmc/core/mmc_ops.c |   19 ++++++++++---------
 include/linux/mmc/core.h   |    2 +-
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 90de094..75ce01d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -302,7 +302,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	}
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal, true);
+			EXT_CSD_BKOPS_START, 1, timeout,
+			use_busy_signal, true, false);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 98e9eb0..ae3489a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -856,8 +856,8 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	/* switch to HS200 mode if bus width set successfully */
 	if (!err)
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_HS_TIMING, 2, 0);
+		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_HS_TIMING, 2, 0, true, true, true);
 err:
 	return err;
 }
@@ -1074,9 +1074,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		    host->caps2 & MMC_CAP2_HS200)
 			err = mmc_select_hs200(card);
 		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
-			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					 EXT_CSD_HS_TIMING, 1,
-					 card->ext_csd.generic_cmd6_time);
+			err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					EXT_CSD_HS_TIMING, 1,
+					card->ext_csd.generic_cmd6_time,
+					true, true, true);
 
 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -1404,7 +1405,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, true, false);
+			notify_type, timeout, true, false, false);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3377bbf..5e1a2cb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -405,17 +405,18 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
  *                   timeout of zero implies maximum possible timeout
  *	@use_busy_signal: use the busy signal as response type
  *	@send_status: send status cmd to poll for busy
+ *	@ignore_crc: ignore CRC errors when sending status cmd to poll for busy
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-		unsigned int timeout_ms, bool use_busy_signal, bool send_status)
+		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
+		bool ignore_crc)
 {
 	int err;
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
 	u32 status = 0;
-	bool ignore_crc = false;
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
@@ -445,14 +446,13 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		return 0;
 
 	/*
-	 * Must check status to be sure of no errors
-	 * If CMD13 is to check the busy completion of the timing change,
-	 * disable the check of CRC error.
+	 * CRC errors shall only be ignored in cases were CMD13 is used to poll
+	 * to detect busy completion.
 	 */
-	if (index == EXT_CSD_HS_TIMING &&
-	    !(card->host->caps & MMC_CAP_WAIT_WHILE_BUSY))
-		ignore_crc = true;
+	if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		ignore_crc = false;
 
+	/* Must check status to be sure of no errors. */
 	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
 	do {
 		if (send_status) {
@@ -501,7 +501,8 @@ EXPORT_SYMBOL_GPL(__mmc_switch);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
-	return __mmc_switch(card, set, index, value, timeout_ms, true, true);
+	return __mmc_switch(card, set, index, value, timeout_ms, true, true,
+				false);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b276996..f206e29 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -152,7 +152,7 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
-			bool);
+			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 
-- 
1.7.9.5

