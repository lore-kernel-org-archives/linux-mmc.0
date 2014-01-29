From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/13] mmc: core: Minor simplifications to __mmc_switch
Date: Wed, 29 Jan 2014 23:37:56 +0100
Message-ID: <1391035085-2747-5-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:48650 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaA2WiU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:20 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so1999293lbd.29
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:19 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Instead of using several references to card->host, let's use a local
variable. That means we can remove the BUG_ON verifications for the
same pointers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5e1a2cb..04ecdb9 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -413,14 +413,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
 		bool ignore_crc)
 {
+	struct mmc_host *host = card->host;
 	int err;
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
 	u32 status = 0;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 		  (index << 16) |
@@ -437,7 +435,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
 
-	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
 
@@ -449,7 +447,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * CRC errors shall only be ignored in cases were CMD13 is used to poll
 	 * to detect busy completion.
 	 */
-	if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 		ignore_crc = false;
 
 	/* Must check status to be sure of no errors. */
@@ -460,9 +458,9 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 			if (err)
 				return err;
 		}
-		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 			break;
-		if (mmc_host_is_spi(card->host))
+		if (mmc_host_is_spi(host))
 			break;
 
 		/*
@@ -478,18 +476,18 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		/* Timeout if the device never leaves the program state. */
 		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Card stuck in programming state! %s\n",
-				mmc_hostname(card->host), __func__);
+				mmc_hostname(host), __func__);
 			return -ETIMEDOUT;
 		}
 	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
 
-	if (mmc_host_is_spi(card->host)) {
+	if (mmc_host_is_spi(host)) {
 		if (status & R1_SPI_ILLEGAL_COMMAND)
 			return -EBADMSG;
 	} else {
 		if (status & 0xFDFFA000)
-			pr_warning("%s: unexpected status %#x after "
-			       "switch", mmc_hostname(card->host), status);
+			pr_warn("%s: unexpected status %#x after switch\n",
+				mmc_hostname(host), status);
 		if (status & R1_SWITCH_ERROR)
 			return -EBADMSG;
 	}
-- 
1.7.9.5

