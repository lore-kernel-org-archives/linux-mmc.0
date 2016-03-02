From: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Subject: [PATCH 2/2] mmc/block: Override default max_dev_sectors.
Date: Wed,  2 Mar 2016 09:55:02 +0100
Message-ID: <d6a4eec3e416f5b6e3dd63f04812be01c037ec6a.1456847028.git.pawelx.wodkowski@intel.com>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16191 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbcCBJGs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2016 04:06:48 -0500
In-Reply-To: <cover.1456847028.git.pawelx.wodkowski@intel.com>
In-Reply-To: <cover.1456847028.git.pawelx.wodkowski@intel.com>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-block@vger.kernel.org
Cc: Mateusz Nowak <mateusz.nowak@intel.com>, linux-mmc@vger.kernel.org

From: Mateusz Nowak <mateusz.nowak@intel.com>

Fixes: ca369d51b3e1 ("block/sd: Fix device-imposed transfer length limits")
introduced max_dev_sectors as upper limit for max_hw_sectors. This caused
limitation of maximum block size to default max_dev_sectors value - 127,
causing performance degradation with higher block sizes.

This patch is overriding max_dev_sectors value, so it will be set to
maximum possible value to be used with set block count command,
so 0xffff for eMMC cards, and 0xffffffff for SD cards.

Fixes: ca369d51b3e1 ("block/sd: Fix device-imposed transfer length limits")
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Mateusz Nowak <mateusz.nowak@intel.com>
---
 drivers/mmc/card/queue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6f4323c6d653..9175b8cd54de 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -212,6 +212,16 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
+	/*
+	 * Set maximum block count accepted by the card.
+	 * For eMMC, this can be 16 bit value,
+	 * for SD, this can be 32 bit value
+	 */
+	if (mmc_card_mmc(card))
+		blk_queue_max_dev_sectors(mq->queue, 0xffff);
+	else if (mmc_card_sd(card))
+		blk_queue_max_dev_sectors(mq->queue, 0xffffffff);
+
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 	if (host->max_segs == 1) {
 		unsigned int bouncesz;
-- 
1.9.1

