From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH] mmc : don't disable discard support because max_busy_timeout is too small
Date: Mon,  4 May 2015 17:41:57 +0200
Message-ID: <1430754117-5314-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33975 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbEDPmL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 11:42:11 -0400
Received: by wgso17 with SMTP id o17so154530618wgs.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 08:42:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Matthieu CASTET <matthieu.castet@parrot.com>

If max_busy_timeout is too small we use R1 response and poll status (the
same quirk is already done in __mmc_switch, send_stop).

Without this commit, if the erase time is big (2400ms for example) and
max_busy_timeout is 1300ms (sdhci running with a clock at 100Mhz and
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK), discard support will be disabled.

Also when using secure trim or erase, the max timeout is much bigger, and
it is not checked in mmc_calc_max_discard. So we need to check max_busy_timeout
in mmc_do_erase to support all case.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mmc/core/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..ee90ebb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2034,6 +2034,16 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
+	/*
+	 * Normally we use R1B responses, but in cases where the host
+	 * has specified a max_busy_timeout we need to validate it. A failure
+	 * means we need to prevent the host from doing hw busy detection, which
+	 * is done by converting to a R1 response instead.
+	 */
+	if (card->host->max_busy_timeout && cmd.busy_timeout > card->host->max_busy_timeout) {
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+		cmd.busy_timeout = 0;
+	}
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: erase error %d, status %#x\n",
@@ -2272,6 +2282,9 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	} else if (max_discard < card->erase_size) {
 		max_discard = 0;
 	}
+	/* if max_busy_timeout is too small, we can poll */
+	if (!max_discard)
+		max_discard = card->pref_erase;
 	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
 		 mmc_hostname(host), max_discard, host->max_busy_timeout);
 	return max_discard;
-- 
2.1.4

