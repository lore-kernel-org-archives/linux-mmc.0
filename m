From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] mmc: core: Do not poll for busy with status cmd for all switch cmds
Date: Tue, 22 Oct 2013 11:24:04 +0200
Message-ID: <1382433844-10368-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:52349 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3JVJYK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 05:24:10 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so3618821lab.26
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 02:24:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

Some switch operations like poweroff notify, shall according to the
spec not be followed by any other new commands. For these cases and
when the host does'nt support MMC_CAP_WAIT_WHILE_BUSY, we must not
send status commands to poll for busy detection. Instead wait for
the stated timeout from the EXT_CSD before completing the request.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---

Changes in v2:
	Rebase towards latest mmc-next.

---
 drivers/mmc/core/core.c    |    2 +-
 drivers/mmc/core/mmc.c     |    6 +++---
 drivers/mmc/core/mmc_ops.c |   23 ++++++++++++++++++-----
 include/linux/mmc/core.h   |    3 ++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 006ead2..0292ad4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -301,7 +301,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	}
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal);
+			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal, true);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..8f0c516 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1404,9 +1404,9 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	if (notify_type == EXT_CSD_POWER_OFF_LONG)
 		timeout = card->ext_csd.power_off_longtime;
 
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_POWER_OFF_NOTIFICATION,
-			 notify_type, timeout);
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_POWER_OFF_NOTIFICATION,
+			notify_type, timeout, true, false);
 	if (err)
 		pr_err("%s: Power Off Notification timed out, %u\n",
 		       mmc_hostname(card->host), timeout);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 37f7d70..aae8d8b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -404,11 +404,12 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
  *	@timeout_ms: timeout (ms) for operation performed by register write,
  *                   timeout of zero implies maximum possible timeout
  *	@use_busy_signal: use the busy signal as response type
+ *	@send_status: send status cmd to poll for busy
  *
  *	Modifies the EXT_CSD register for selected card.
  */
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-	       unsigned int timeout_ms, bool use_busy_signal)
+		unsigned int timeout_ms, bool use_busy_signal, bool send_status)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -454,14 +455,26 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
 	do {
-		err = __mmc_send_status(card, &status, ignore_crc);
-		if (err)
-			return err;
+		if (send_status) {
+			err = __mmc_send_status(card, &status, ignore_crc);
+			if (err)
+				return err;
+		}
 		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 			break;
 		if (mmc_host_is_spi(card->host))
 			break;
 
+		/*
+		 * We are not allowed to issue a status command and the host
+		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
+		 * rely on waiting for the stated timeout to be sufficient.
+		 */
+		if (!send_status) {
+			mmc_delay(timeout_ms);
+			return 0;
+		}
+
 		/* Timeout if the device never leaves the program state. */
 		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Card stuck in programming state! %s\n",
@@ -488,7 +501,7 @@ EXPORT_SYMBOL_GPL(__mmc_switch);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms)
 {
-	return __mmc_switch(card, set, index, value, timeout_ms, true);
+	return __mmc_switch(card, set, index, value, timeout_ms, true, true);
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a00fc49..87079fc 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -151,7 +151,8 @@ extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
-extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool);
+extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
+			bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 
-- 
1.7.9.5

