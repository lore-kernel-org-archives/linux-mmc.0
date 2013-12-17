From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] mmc: core: don't decrement qty when calculating max_discard
Date: Tue, 17 Dec 2013 11:02:24 -0700
Message-ID: <1387303344-11802-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

In mmc_do_calc_max_discard(), if any value has been assigned to qty,
that value must have passed the timeout checks in the loop. Hence,
qty is the maximum number of erase blocks that fit within the timeout,
not the first value that does not fit into the timeout. In turn, this
means we don't need any special case for (qty == 1); any value of qty
needs to be multiplied by the card's erase shift, and we don't need to
decrement qty before doing so.

Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
in qty == 1, which is immediately returned. This causes discard to
operate a single sector at a time, which is chronically slow. With this
patch in place, discard operates a single erase block at a time, which
is reasonably fast.

Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Fixes: e056a1b5b67b "(mmc: queue: let host controllers specify maximum discard timeout")
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
If this makes sense, I wonder if it should be Cc: stable?
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b403bf8e..dd793cf4ef46 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2150,16 +2150,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
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
1.8.1.5
