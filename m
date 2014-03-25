From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/4] Limit max_discard_sectors to UINT_MAX>>9
Date: Tue, 25 Mar 2014 16:48:25 -0700
Message-ID: <1395791307-23727-4-git-send-email-gwendal@chromium.org>
References: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, ulf.hansson@linaro.org
Cc: linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: linux-mmc@vger.kernel.org

max_discard_sectors can not be larger than UINT_MAX>>9,
otherwise, there is a risk that discard requests would be merged
into a request larger than 4GB.
Ensure that max_discard_sectors is in unit of sectors.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b40..46e7ced 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2153,7 +2153,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	if (qty == 1)
 		return 1;
 
-	/* Convert qty to sectors */
+	/* Convert qty to bytes */
 	if (card->erase_shift)
 		max_discard = --qty << card->erase_shift;
 	else if (mmc_card_sd(card))
@@ -2170,7 +2170,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	unsigned int max_discard, max_trim;
 
 	if (!host->max_discard_to)
-		return UINT_MAX;
+		return UINT_MAX >> 9;
 
 	/*
 	 * Without erase_group_def set, MMC erase timeout depends on clock
@@ -2188,6 +2188,8 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	} else if (max_discard < card->erase_size) {
 		max_discard = 0;
 	}
+	/* convert max_discard to sectors */
+	max_discard >>= 9;
 	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
 		 mmc_hostname(host), max_discard, host->max_discard_to);
 	return max_discard;
-- 
1.9.1.423.g4596e3a
