From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v7 1/3] mmc: core: always check status after reset
Date: Mon, 12 Jan 2015 15:38:04 +0100
Message-ID: <1421073486-10903-2-git-send-email-johanru@axis.com>
References: <1421073486-10903-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:59388 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbbALOiS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Jan 2015 09:38:18 -0500
In-Reply-To: <1421073486-10903-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Always check if the card is alive after a successful reset. This allows
us to remove mmc_hw_reset_check(), leaving mmc_hw_reset() as the only
card reset interface.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/card/mmc_test.c |   18 +++++++-----------
 drivers/mmc/core/core.c     |   24 +++++-------------------
 include/linux/mmc/core.h    |    1 -
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0a7430f..7dac469 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2342,20 +2342,16 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	struct mmc_host *host = card->host;
 	int err;
 
-	err = mmc_hw_reset_check(host);
+	if (!mmc_card_mmc(card) || !mmc_can_reset(card))
+		return RESULT_UNSUP_CARD;
+
+	err = mmc_hw_reset(host);
 	if (!err)
 		return RESULT_OK;
+	else if (err == -EOPNOTSUPP)
+		return RESULT_UNSUP_HOST;
 
-	if (err == -ENOSYS)
-		return RESULT_FAIL;
-
-	if (err != -EOPNOTSUPP)
-		return err;
-
-	if (!mmc_can_reset(card))
-		return RESULT_UNSUP_CARD;
-
-	return RESULT_UNSUP_HOST;
+	return RESULT_FAIL;
 }
 
 static const struct mmc_test_case mmc_test_cases[] = {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d3bfbdf..9959997e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2286,9 +2286,10 @@ int mmc_can_reset(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_reset);
 
-static int mmc_do_hw_reset(struct mmc_host *host, int check)
+static int mmc_hw_reset(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	u32 status;
 
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
 		return -EOPNOTSUPP;
@@ -2305,13 +2306,9 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 	host->ops->hw_reset(host);
 
 	/* If the reset has happened, then a status command will fail */
-	if (check) {
-		u32 status;
-
-		if (!mmc_send_status(card, &status)) {
-			mmc_host_clk_release(host);
-			return -ENOSYS;
-		}
+	if (!mmc_send_status(card, &status)) {
+		mmc_host_clk_release(host);
+		return -ENOSYS;
 	}
 
 	/* Set initial state and call mmc_set_ios */
@@ -2321,19 +2318,8 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 
 	return host->bus_ops->power_restore(host);
 }
-
-int mmc_hw_reset(struct mmc_host *host)
-{
-	return mmc_do_hw_reset(host, 0);
-}
 EXPORT_SYMBOL(mmc_hw_reset);
 
-int mmc_hw_reset_check(struct mmc_host *host)
-{
-	return mmc_do_hw_reset(host, 1);
-}
-EXPORT_SYMBOL(mmc_hw_reset_check);
-
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index cb2b040..160448f 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -182,7 +182,6 @@ extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			      bool is_rel_write);
 extern int mmc_hw_reset(struct mmc_host *host);
-extern int mmc_hw_reset_check(struct mmc_host *host);
 extern int mmc_can_reset(struct mmc_card *card);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
-- 
1.7.2.5

