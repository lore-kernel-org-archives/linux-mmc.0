From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Use a default maximum erase timeout
Date: Fri,  2 Sep 2016 13:30:01 +0200
Message-ID: <1472815801-24932-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32809 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbcIBLaJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 07:30:09 -0400
Received: by mail-lf0-f44.google.com with SMTP id b199so81662752lfe.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 Sep 2016 04:30:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Baolin Wang <baolin.wang@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

In cases when the host->max_busy_timeout isn't specified, the calculated
number of maximum discard sectors defaults to UINT_MAX. This may cause a
too long timeout for a discard request.

Avoid this by using a default maximum erase timeout of 60s, used when we
calculate the maximum number of sectors that are allowed to be discarded
per request.

Do note that the minimum number of sectors to be discarded is still at
least one "preferred erase size".

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e55cde6..59b452d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -58,6 +58,9 @@
  */
 #define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
 
+/* The max erase timeout, used when host->max_busy_timeout isn't specified */
+#define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
+
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 
 /*
@@ -2352,6 +2355,8 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	struct mmc_host *host = card->host;
 	unsigned int max_discard, x, y, qty = 0, max_qty, min_qty, timeout;
 	unsigned int last_timeout = 0;
+	unsigned int max_busy_timeout = host->max_busy_timeout ?
+			host->max_busy_timeout : MMC_ERASE_TIMEOUT_MS;
 
 	if (card->erase_shift) {
 		max_qty = UINT_MAX >> card->erase_shift;
@@ -2374,15 +2379,15 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	 * matter what size of 'host->max_busy_timeout', but if the
 	 * 'host->max_busy_timeout' is large enough for more discard sectors,
 	 * then we can continue to increase the max discard sectors until we
-	 * get a balance value.
+	 * get a balance value. In cases when the 'host->max_busy_timeout'
+	 * isn't specified, use the default max erase timeout.
 	 */
 	do {
 		y = 0;
 		for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
 			timeout = mmc_erase_timeout(card, arg, qty + x);
 
-			if (qty + x > min_qty &&
-			    timeout > host->max_busy_timeout)
+			if (qty + x > min_qty && timeout > max_busy_timeout)
 				break;
 
 			if (timeout < last_timeout)
@@ -2427,9 +2432,6 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	unsigned int max_discard, max_trim;
 
-	if (!host->max_busy_timeout)
-		return UINT_MAX;
-
 	/*
 	 * Without erase_group_def set, MMC erase timeout depends on clock
 	 * frequence which can change.  In that case, the best choice is
@@ -2447,7 +2449,8 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 		max_discard = 0;
 	}
 	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
-		 mmc_hostname(host), max_discard, host->max_busy_timeout);
+		mmc_hostname(host), max_discard, host->max_busy_timeout ?
+		host->max_busy_timeout : MMC_ERASE_TIMEOUT_MS);
 	return max_discard;
 }
 EXPORT_SYMBOL(mmc_calc_max_discard);
-- 
1.9.1

