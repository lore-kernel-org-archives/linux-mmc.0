From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/13] mmc: core: Hold re-tuning during switch commands
Date: Fri,  5 Dec 2014 19:41:05 +0200
Message-ID: <1417801271-15575-8-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60360 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaLERnW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:22 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during switch commands to prevent
it from conflicting with the busy state or the CMD13
verification.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b044c5..772c585 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -444,6 +444,10 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	u32 status = 0;
 	bool use_r1b_resp = use_busy_signal;
 
+	err = mmc_retune_and_hold(host);
+	if (err)
+		return err;
+
 	/*
 	 * If the cmd timeout and the max_busy_timeout of the host are both
 	 * specified, let's validate them. A failure means we need to prevent
@@ -476,11 +480,11 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
-		return err;
+		goto out;
 
 	/* No need to check card status in case of unblocking command */
 	if (!use_busy_signal)
-		return 0;
+		goto out;
 
 	/*
 	 * CRC errors shall only be ignored in cases were CMD13 is used to poll
@@ -499,7 +503,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		if (send_status) {
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
-				return err;
+				goto out;
 		}
 		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 			break;
@@ -513,29 +517,36 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		 */
 		if (!send_status) {
 			mmc_delay(timeout_ms);
-			return 0;
+			goto out;
 		}
 
 		/* Timeout if the device never leaves the program state. */
 		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Card stuck in programming state! %s\n",
 				mmc_hostname(host), __func__);
-			return -ETIMEDOUT;
+			err = -ETIMEDOUT;
+			goto out;
 		}
 	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
 
 	if (mmc_host_is_spi(host)) {
-		if (status & R1_SPI_ILLEGAL_COMMAND)
-			return -EBADMSG;
+		if (status & R1_SPI_ILLEGAL_COMMAND) {
+			err = -EBADMSG;
+			goto out;
+		}
 	} else {
 		if (status & 0xFDFFA000)
 			pr_warn("%s: unexpected status %#x after switch\n",
 				mmc_hostname(host), status);
-		if (status & R1_SWITCH_ERROR)
-			return -EBADMSG;
+		if (status & R1_SWITCH_ERROR) {
+			err = -EBADMSG;
+			goto out;
+		}
 	}
+out:
+	mmc_retune_release(host);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(__mmc_switch);
 
-- 
1.9.1

