From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/5] mmc:core: Add restrictions for data transfer and card ease
Date: Tue, 24 Sep 2013 16:12:15 +0800
Message-ID: <1380010339-25446-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:7123 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab3IXIRp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 04:17:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

At 50 Mhz SD_CLK period,
the max timeout value = 2^27 * SD_CLK period ~= 2.69 sec.

If max_discard_to was not designed, for mmc card preferred erase
size should be used, for sd card just return UINT_MAX. Also add
limit for data transfer, Use max_discard_to as max data timeout value
to avoid timeout error in case data timeout was larger than
2.69 sec.

For some crappy cards, the timeout value calculate from card was
larger than UINT_MAX, in this case the timeout value write into
register was not expected.

This patch can reduce I/O error due to large timeout value for
erase(CMD38) and write(CMD25) for some crappy cards.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/core/core.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bf18b6b..b429baa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -757,6 +757,7 @@ EXPORT_SYMBOL(mmc_read_bkops_status);
  */
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	unsigned int mult;
 
 	/*
@@ -780,7 +781,12 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	if (data->flags & MMC_DATA_WRITE)
 		mult <<= card->csd.r2w_factor;
 
-	data->timeout_ns = card->csd.tacc_ns * mult;
+	/* Avoid over flow for some crappy cards. */
+	if ((UINT_MAX / mult) < card->csd.tacc_ns)
+		data->timeout_ns = UINT_MAX;
+	else
+		data->timeout_ns = card->csd.tacc_ns * mult;
+
 	data->timeout_clks = card->csd.tacc_clks * mult;
 
 	/*
@@ -842,6 +848,11 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 				data->timeout_ns =  100000000;	/* 100ms */
 		}
 	}
+
+	if (host->max_discard_to &&
+			(host->max_discard_to <
+			 (data->timeout_ns / 1000000)))
+		data->timeout_ns = host->max_discard_to * 1000000;
 }
 EXPORT_SYMBOL(mmc_set_data_timeout);
 
@@ -1816,11 +1827,14 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 		unsigned int timeout_clks = card->csd.tacc_clks * mult;
 		unsigned int timeout_us;
 
-		/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
-		if (card->csd.tacc_ns < 1000000)
-			timeout_us = (card->csd.tacc_ns * mult) / 1000;
-		else
+		/*
+		 * Avoid over flow for some crappy cards.
+		 * e.g. tacc_ns=80000000 mult=1280
+		 */
+		if ((UINT_MAX / mult) < card->csd.tacc_ns)
 			timeout_us = (card->csd.tacc_ns / 1000) * mult;
+		else
+			timeout_us = (card->csd.tacc_ns * mult) / 1000;
 
 		/*
 		 * ios.clock is only a target.  The real clock rate might be
@@ -2185,16 +2199,17 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	unsigned int max_discard, max_trim;
 
-	if (!host->max_discard_to)
-		return UINT_MAX;
-
-	/*
-	 * Without erase_group_def set, MMC erase timeout depends on clock
-	 * frequence which can change.  In that case, the best choice is
-	 * just the preferred erase size.
-	 */
-	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
-		return card->pref_erase;
+	if (!host->max_discard_to) {
+		/*
+		 * Without erase_group_def set, MMC erase timeout depends
+		 * on clock frequence which can change.  In that case, the
+		 * best choice is just the preferred erase size.
+		 */
+		if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
+			return card->pref_erase;
+		else
+			return UINT_MAX;
+	}
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
 	if (mmc_can_trim(card)) {
-- 
1.8.0


