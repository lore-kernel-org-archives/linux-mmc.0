From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2] Powerpc/eSDHC: Add limit to data and erase timeout value calculation
Date: Mon, 19 Nov 2012 11:38:29 +0800
Message-ID: <1353296310-10786-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1353296310-10786-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:38802 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752807Ab2KSD7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 22:59:00 -0500
In-Reply-To: <1353296310-10786-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

Some cards apply too larg timeout value for host to response,
So limit the maximum data transfer timeout value and maximum erase
timeout value to aviod timeout issue.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v2:
	- Add limit to data and erase timeout value calculation

 drivers/mmc/core/core.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 893144e..ed5744b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -636,6 +636,7 @@ EXPORT_SYMBOL(mmc_read_bkops_status);
  */
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	unsigned int mult;
 
 	/*
@@ -721,6 +722,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 				data->timeout_ns =  100000000;	/* 100ms */
 		}
 	}
+
+	if (host->max_discard_to &&
+		host->max_discard_to < div_u64(data->timeout_ns, 1000000))
+		data->timeout_ns = (u64)host->max_discard_to * 1000000;
 }
 EXPORT_SYMBOL(mmc_set_data_timeout);
 
@@ -1880,7 +1885,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 		return 0;
 
 	if (qty == 1)
-		return 1;
+		return 1 << card->erase_shift;
 
 	/* Convert qty to sectors */
 	if (card->erase_shift)
@@ -1898,16 +1903,17 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
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


