From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: queue: bring discard_granularity/alignment into line with SCSI definitions
Date: Thu, 23 Jun 2011 13:40:29 +0300
Message-ID: <1308825629-27375-5-git-send-email-adrian.hunter@intel.com>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21043 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab1FWKlX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 06:41:23 -0400
In-Reply-To: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

SCSI defines discard alignment as the offset to the first
optimal discard.  In the case of SD/MMC, that is always zero
which is the default.

SCSI defines discard granularity as a hint of a optimal
discard size.  That is much better expressed by the MMC
"preferred erase size" (pref_erase) field.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 3e2db1c..6413afa 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -135,12 +135,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		mq->queue->limits.max_discard_sectors = UINT_MAX;
 		if (card->erased_byte == 0)
 			mq->queue->limits.discard_zeroes_data = 1;
-		if (!mmc_can_trim(card) && is_power_of_2(card->erase_size)) {
-			mq->queue->limits.discard_granularity =
-							card->erase_size << 9;
-			mq->queue->limits.discard_alignment =
-							card->erase_size << 9;
-		}
+		mq->queue->limits.discard_granularity = card->pref_erase << 9;
 		if (mmc_can_secure_erase_trim(card))
 			queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD,
 						mq->queue);
-- 
1.7.4.4

