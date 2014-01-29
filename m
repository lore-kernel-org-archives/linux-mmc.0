From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/13] mmc: core: Fixup busy detection for mmc switch operations
Date: Wed, 29 Jan 2014 23:37:57 +0100
Message-ID: <1391035085-2747-6-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:45377 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaA2WiX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:23 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so1973674lab.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:21 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

If the host controller supports busy detection in HW, we expect the
MMC_CAP_WAIT_WHILE_BUSY to be set. Likewise the corresponding
host->max_busy_timeout should reflect the maximum busy detection
timeout supported by the host.

Previously we expected a host that supported MMC_CAP_WAIT_WHILE_BUSY to
cope with any timeout, which just isn't feasible due to HW limitations.

For most switch operations, R1B responses are expected and thus we need
to check for busy detection completion. To cope with cases where the
requested busy detection timeout is greater than what the host are able
to support, we fallback to use a R1 response instead. This will prevent
the host from doing HW busy detection.

In those cases, busy detection completion is handled by polling the for
the card's status using CMD13. This is the same mechanism used when the
host doesn't support MMC_CAP_WAIT_WHILE_BUSY.

Do note, a host->max_busy_timeout set to zero, is interpreted by the
mmc core as it don't know what the host supports. It will then provide
the host with whatever timeout the mmc core finds suitable.

For some cases the mmc core has unfurtunate no clue of what timeout to
use. In these cases we provide the host with a timeout value of zero,
which the host may interpret as use whatever timeout it finds suitable.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 04ecdb9..f51b5ba 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -418,6 +418,17 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
 	u32 status = 0;
+	bool use_r1b_resp = use_busy_signal;
+
+	/*
+	 * If the cmd timeout and the max_busy_timeout of the host are both
+	 * specified, let's validate them. A failure means we need to prevent
+	 * the host from doing hw busy detection, which is done by converting
+	 * to a R1 response instead of a R1B.
+	 */
+	if (timeout_ms && host->max_busy_timeout &&
+		(timeout_ms > host->max_busy_timeout))
+		use_r1b_resp = false;
 
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
@@ -425,13 +436,17 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		  (value << 8) |
 		  set;
 	cmd.flags = MMC_CMD_AC;
-	if (use_busy_signal)
+	if (use_r1b_resp) {
 		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
-	else
+		/*
+		 * A busy_timeout of zero means the host can decide to use
+		 * whatever value it finds suitable.
+		 */
+		cmd.busy_timeout = timeout_ms;
+	} else {
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
+	}
 
-
-	cmd.busy_timeout = timeout_ms;
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
 
@@ -447,18 +462,22 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * CRC errors shall only be ignored in cases were CMD13 is used to poll
 	 * to detect busy completion.
 	 */
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+	if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 		ignore_crc = false;
 
+	/* We have an unspecified cmd timeout, use the fallback value. */
+	if (!timeout_ms)
+		timeout_ms = MMC_OPS_TIMEOUT_MS;
+
 	/* Must check status to be sure of no errors. */
-	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
 		if (send_status) {
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
 				return err;
 		}
-		if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 			break;
 		if (mmc_host_is_spi(host))
 			break;
-- 
1.7.9.5

