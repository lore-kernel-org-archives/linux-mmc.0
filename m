From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] mmc: core: Fix calc_max_discard.
Date: Tue, 13 Dec 2016 11:20:18 -0800
Message-ID: <1481656818-21141-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34588 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbcLMTUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 14:20:30 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so50696775pgx.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2016 11:20:29 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dianders@chromium.org, hisanao.kinkawa@toshiba.co.jp, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Working with a SDHCI controller and a Toshiba 16GB THGBMFG7C2LBAIL.
The Toshiba part has a large erase group size and a long erase timeout.
It barely fits within the controller timeout, but mmc reports a
512B discard size to the block layer instead of the expected 4MB:
/sys/block/mmcblk0/queue/discard_max_bytes = 512

The host caps[0] is 0x...b2, so host->max_busy_timeout is set to
2684.35ms: (1 << 27 / ((0xb2 & 0x3f) * 1000).

In Toshiba EXT_CSD, HC_ERASE_GRP_SIZE is set to 7 (2100ms erase timeout)
HC_ERASE_GRP_SIZE is set to 8, (8192 512B sectors erase size).

In mmc_do_calc_max_discard(), as a safety, for eMMC device, number of
erase groups that could safely be erased with the host timeout (qty) was
reduced by 1.
This extra safety is not necessary, given these numbers are already the
worst case scenario.
Moreover, in the case of this Toshiba part, given 2100 is just below 2684,
qty was set to 1, we would only report one sector (512b) to the block
layer, making erasing/trimming painfully slow.

With this fix, using Hynix HBG4e, check that discard_max_bytes
increases from 1536kB to 2048kB (qty was set to 4: each erase group size
of 1024 sectors have a timeout of 600ms).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 64f603e..b5a1194 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2397,16 +2397,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	if (!qty)
 		return 0;
 
-	if (qty == 1)
-		return 1;
-
 	/* Convert qty to sectors */
 	if (card->erase_shift)
-		max_discard = --qty << card->erase_shift;
+		max_discard = qty << card->erase_shift;
 	else if (mmc_card_sd(card))
 		max_discard = qty;
 	else
-		max_discard = --qty * card->erase_size;
+		max_discard = qty * card->erase_size;
 
 	return max_discard;
 }
-- 
2.8.0.rc3.226.g39d4020

