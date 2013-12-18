From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] mmc: core: don't return 1 for max_discard
Date: Wed, 18 Dec 2013 15:27:43 -0700
Message-ID: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45020 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3LRW1v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 17:27:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <dongas86@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>

From: Stephen Warren <swarren@nvidia.com>

In mmc_do_calc_max_discard(), if only a single erase block can be
discarded within the host controller's timeout, don't allow discard
operations at all.

Previously, the code allowed sector-at-a-time discard (rather than
erase-block-at-a-time), which was chronically slow.

Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
in qty == 1, which is immediately returned. This causes discard to
operate a single sector at a time, which is chronically slow. With this
patch in place, discard operates a single erase block at a time, which
is reasonably fast.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <dongas86@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Fixes: e056a1b5b67b "(mmc: queue: let host controllers specify maximum discard timeout")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/mmc/core/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b403bf8e..eb952ca634ea 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2150,8 +2150,25 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	if (!qty)
 		return 0;
 
-	if (qty == 1)
-		return 1;
+	/*
+	 * Discard operations may not be aligned to an erase block. In an
+	 * unaligned case, we need to issue 1 more discard operation to HW
+	 * than strictly calculated by:
+	 *     sectors_to_erase / sectors_per_discard_operation
+	 *
+	 * To account for this in the timeout calculations, we assume we can
+	 * actually discard one less erase block than fits into the HW
+	 * timeout. This explains the --qty below.
+	 *
+	 * When only a single discard block operation fits into the timeout,
+	 * disallow any discard operations at all. For example, discarding one
+	 * sector at a time is so chronically slow as to be useless. However,
+	 * make an exception for SD cards without an erase shift, since qty
+	 * isn't multiplied up by an erase block size in the code below for
+	 * that case.
+	 */
+	if (qty == 1 && !(!card->erase_shift && mmc_card_sd(card)))
+		return 0;
 
 	/* Convert qty to sectors */
 	if (card->erase_shift)
-- 
1.8.1.5

