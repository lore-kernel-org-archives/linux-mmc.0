From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: fixes for eMMC v4.5 discard operation
Date: Thu,  5 Apr 2012 14:45:47 +0300
Message-ID: <1333626348-11170-2-git-send-email-adrian.hunter@intel.com>
References: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53497 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2DELpu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Apr 2012 07:45:50 -0400
In-Reply-To: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org

eMMC v4.5 discard operation is significantly different from the
existing trim operation because it is not guaranteed to work with
the new sanitize operation.  Consequently mmc_can_trim() is
separated from mmc_can_discard().

Also the new discard operation does not result in the sectors being
set to all-zeros, so discard_zeroes_data must not be set.

In addition, the new discard has the same timeout as trim, but from
v4.5 trim is defined to use the hc timeout.  The timeout calculation
is adjusted accordingly.

Fixes apply to linux 3.2 on.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/mmc/card/queue.c |    2 +-
 drivers/mmc/core/core.c  |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 2517547..996f8e3 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -139,7 +139,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 	q->limits.max_discard_sectors = max_discard;
-	if (card->erased_byte == 0)
+	if (card->erased_byte == 0 && !mmc_can_discard(card))
 		q->limits.discard_zeroes_data = 1;
 	q->limits.discard_granularity = card->pref_erase << 9;
 	/* granularity must not be greater than max. discard */
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 14f262e..8a9f286 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1405,7 +1405,10 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 {
 	unsigned int erase_timeout;
 
-	if (card->ext_csd.erase_group_def & 1) {
+	if (arg == MMC_DISCARD_ARG ||
+	    (arg == MMC_TRIM_ARG && card->ext_csd.rev >= 6)) {
+		erase_timeout = card->ext_csd.trim_timeout;
+	} else if (card->ext_csd.erase_group_def & 1) {
 		/* High Capacity Erase Group Size uses HC timeouts */
 		if (arg == MMC_TRIM_ARG)
 			erase_timeout = card->ext_csd.trim_timeout;
@@ -1677,8 +1680,6 @@ int mmc_can_trim(struct mmc_card *card)
 {
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
 		return 1;
-	if (mmc_can_discard(card))
-		return 1;
 	return 0;
 }
 EXPORT_SYMBOL(mmc_can_trim);
-- 
1.7.6.5

