From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] CHROMIUM: mmc: Set pref erase size based on size.
Date: Fri,  3 Jun 2016 09:08:52 -0700
Message-ID: <1464970132-26197-1-git-send-email-gwendal@chromium.org>
References: <1464913638-5283-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35835 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcFCQI5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 12:08:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id xk1so15743018pac.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2016 09:08:57 -0700 (PDT)
In-Reply-To: <1464913638-5283-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: grundler@chromium.org, axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

If available, eMMC stack uses HC_ERASE_GRP_SIZE as erase size.
The perfererred erase size may need to be bigger to ensure discard
operations are not too slow.
Some high capacity eMMC (64MB) reports erase size to 512kB, resulting in
long discard time.
Calculate prefeerred erase size based on eMMC size.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 v2: fix comments
 v3: rereading the patch, we should not compare to hc_erase_size again,
     it has already been set properly in the caller function.

 drivers/mmc/core/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ef76b1c..bd881a0 100644
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
+	 * Note that if the value is too small, it can end up taking longer to
+	 * erase.
+	 * erase_size is already set to High Capacity Erase Size if available
+	 * when this function is called.
 	 */
 	if (mmc_card_sd(card) && card->ssr.au) {
 		card->pref_erase = card->ssr.au;
 		card->erase_shift = ffs(card->ssr.au) - 1;
-	} else if (card->ext_csd.hc_erase_size) {
-		card->pref_erase = card->ext_csd.hc_erase_size;
 	} else if (card->erase_size) {
 		sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
 		if (sz < 128)
-- 
2.8.0.rc3.226.g39d4020

