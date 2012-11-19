From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2 v3] Powerpc/eSDHC: Add limit to data and erase timeout value calculation
Date: Mon, 19 Nov 2012 13:30:59 +0800
Message-ID: <1353303061-16679-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:54519
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab2KSFve (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 00:51:34 -0500
Received: from mail218-co9 (localhost [127.0.0.1])	by
 mail218-co9-R.bigfish.com (Postfix) with ESMTP id ECD9560093	for
 <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 05:51:32 +0000 (UTC)
Received: from CO9EHSMHS009.bigfish.com (unknown [10.236.132.236])	by
 mail218-co9.bigfish.com (Postfix) with ESMTP id 6EA093C004A	for
 <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 05:51:30 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>

Some cards apply too larg timeout value for host to response,
So limit the maximum data transfer timeout value and maximum erase
timeout value to aviod timeout issue.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v3:
	- Add limit to data and erase timeout value calculation

 drivers/mmc/core/core.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 893144e..edb2964 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -636,6 +636,7 @@ EXPORT_SYMBOL(mmc_read_bkops_status);
  */
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	unsigned int mult;
 
 	/*
@@ -669,9 +670,9 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 		u64 timeout_us, limit_us;
 
 		timeout_us = div_u64(data->timeout_ns, 1000);
-		if (mmc_host_clk_rate(card->host))
+		if (mmc_host_clk_rate(host))
 			timeout_us += data->timeout_clks * 1000 /
-				(mmc_host_clk_rate(card->host) / 1000);
+				(mmc_host_clk_rate(host) / 1000);
 
 		if (data->flags & MMC_DATA_WRITE)
 			/*
@@ -712,7 +713,7 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	 * continuous stream of data until the internal logic
 	 * overflowed.
 	 */
-	if (mmc_host_is_spi(card->host)) {
+	if (mmc_host_is_spi(host)) {
 		if (data->flags & MMC_DATA_WRITE) {
 			if (data->timeout_ns < 1000000000)
 				data->timeout_ns = 1000000000;	/* 1s */
@@ -721,6 +722,11 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 				data->timeout_ns =  100000000;	/* 100ms */
 		}
 	}
+
+	if (host->max_discard_to &&
+			(host->max_discard_to <
+			 div_u64(data->timeout_ns, 1000000)))
+		data->timeout_ns = (u64)host->max_discard_to * 1000000;
 }
 EXPORT_SYMBOL(mmc_set_data_timeout);
 
@@ -1880,7 +1886,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 		return 0;
 
 	if (qty == 1)
-		return 1;
+		return 1 << card->erase_shift;
 
 	/* Convert qty to sectors */
 	if (card->erase_shift)
@@ -1898,16 +1904,17 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
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
+		if (mmc_card_sd(card))
+			return UINT_MAX;
+		/*
+		 * Without erase_group_def set, MMC erase timeout depends on
+		 * clock frequence which can change.  In that case, the best
+		 * choice is just the preferred erase size.
+		 */
+		if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
+			return card->pref_erase;
+	}
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
 	if (mmc_can_trim(card)) {
-- 
1.7.0.4


