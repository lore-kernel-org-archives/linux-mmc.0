From: Sergio Valverde <vlvrdv@gmail.com>
Subject: [PATCH v2] mmc: core: optimize mmc_calc_max_discard
Date: Thu,  8 Feb 2018 11:41:43 -0600
Message-ID: <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
References: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44050 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHRnd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Feb 2018 12:43:33 -0500
In-Reply-To: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Sergio Valverde <vlvrdv@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

If the max_discard value is zero, the conditional branch that checks the
trim capabilities will never update this value with max_trim.

Change the condition statement to also check the max_discard value in order
to avoid an unnecessary call to mmc_do_calc_max_discard.

Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>
---
Changes in v2:
- Evaluate max_discard to avoid unnecessary calls to mmc_can_trim.

 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f0f44f..c32c0f4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2567,7 +2567,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 		return card->pref_erase;
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
-	if (mmc_can_trim(card)) {
+	if (max_discard && mmc_can_trim(card)) {
 		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
 		if (max_trim < max_discard)
 			max_discard = max_trim;
-- 
2.7.4

