From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [RFC] mmc : don't disable discard support because max_busy_timeout is too small
Date: Thu, 10 Jul 2014 10:01:53 +0200
Message-ID: <1404979313-8111-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34196 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaGJIBo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 04:01:44 -0400
Received: by mail-wi0-f171.google.com with SMTP id f8so3543878wiw.10
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2014 01:01:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Matthieu CASTET <matthieu.castet@parrot.com>

mmc_calc_max_discard compute a worst case : max(erase, trim).
Without this commit, if the erase time is big (2400ms for example) and
max_busy_timeout is 1300ms (sdhci running with a clock at 100Mhz and
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK), discard support will be disabled.

But trim could be used without exceding max_busy_timeout

Also when using secure trim or erase, the max timeout is much bigger, and it is not checked in mmc_calc_max_discard. So we need to check max_busy_timeout in mmc_do_erase to support all case.

Note I wonder why we don't check status in spi case. Also why can't we use mmc_send_status ?
It that because of the retry ?
But what's weird is that in other case of status poll retry is done (for example card_busy_detect in drivers/mmc/card/block.c)
---
 drivers/mmc/core/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..12e69e2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1952,6 +1952,16 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
+	/*
+	 * Normally we use R1B responses, but in cases where the host
+	 * has specified a max_busy_timeout we need to validate it. A failure
+	 * means we need to prevent the host from doing hw busy detection, which
+	 * is done by converting to a R1 response instead.
+	 */
+	if (cmd.busy_timeout > host->max_busy_timeout) {
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+		cmd.busy_timeout = 0;
+	}
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: erase error %d, status %#x\n",
@@ -2189,6 +2199,9 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
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
2.0.1

