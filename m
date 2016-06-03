From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] mmc: Set pref erase size based on size.
Date: Thu,  2 Jun 2016 17:27:18 -0700
Message-ID: <1464913638-5283-1-git-send-email-gwendal@chromium.org>
References: <1464908184-20153-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36377 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbcFCA13 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2016 20:27:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id f144so37300919pfa.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2016 17:27:28 -0700 (PDT)
In-Reply-To: <1464908184-20153-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: grundler@chromium.org, axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

If available, eMMC stack uses HC_ERASE_GRP_SIZE as preferred erase size.
However, that size is the minimal size we must use, not the optimal size.
Calculate the optimal size based on whole device size and fall back to
HC_ERASE_GRP_SIZE if too small.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 v2: fix comments

 drivers/mmc/core/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ef76b1c..b858907 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1987,17 +1987,17 @@ void mmc_init_erase(struct mmc_card *card)
 	 * to that size and alignment.
 	 *
 	 * For SD cards that define Allocation Unit size, limit erases to one
-	 * Allocation Unit at a time.  For MMC cards that define High Capacity
-	 * Erase Size, whether it is switched on or not, limit to that size.
-	 * Otherwise just have a stab at a good value.  For modern cards it
-	 * will end up being 4MiB.  Note that if the value is too small, it
-	 * can end up taking longer to erase.
+	 * Allocation Unit at a time.
+	 * For MMC, have a stab at a good value.  For modern cards it
+	 * will end up being 4MiB.
+	 * Be sure the size is at least the High Capacity Erase Size, as long
+	 * as it is defined, even if not used.
+	 * Note that if the value is too small, it can end up taking longer to
+	 * erase.
 	 */
 	if (mmc_card_sd(card) && card->ssr.au) {
 		card->pref_erase = card->ssr.au;
 		card->erase_shift = ffs(card->ssr.au) - 1;
-	} else if (card->ext_csd.hc_erase_size) {
-		card->pref_erase = card->ext_csd.hc_erase_size;
 	} else if (card->erase_size) {
 		sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
 		if (sz < 128)
@@ -2015,6 +2015,8 @@ void mmc_init_erase(struct mmc_card *card)
 			if (sz)
 				card->pref_erase += card->erase_size - sz;
 		}
+		if (card->ext_csd.hc_erase_size > card->pref_erase)
+			card->pref_erase = card->ext_csd.hc_erase_size;
 	} else
 		card->pref_erase = 0;
 }
-- 
2.8.0.rc3.226.g39d4020

