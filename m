From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: block: fix boot partition switch error path
Date: Fri, 23 Sep 2011 12:48:20 +0300
Message-ID: <1316771301-12323-2-git-send-email-adrian.hunter@intel.com>
References: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42644 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab1IWJsc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 05:48:32 -0400
In-Reply-To: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

In the case of a switch error, do not update partition
config as though the switch succeeded, and ensure
blk_end_request is called on the failed request.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f4a6e0d..2350ac9 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -448,18 +448,23 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 {
 	int ret;
 	struct mmc_blk_data *main_md = mmc_get_drvdata(card);
+
 	if (main_md->part_curr == md->part_type)
 		return 0;
 
 	if (mmc_card_mmc(card)) {
-		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
-		card->ext_csd.part_config |= md->part_type;
+		u8 part_config = card->ext_csd.part_config;
+
+		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
+		part_config |= md->part_type;
 
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_PART_CONFIG, card->ext_csd.part_config,
+				 EXT_CSD_PART_CONFIG, part_config,
 				 card->ext_csd.part_time);
 		if (ret)
 			return ret;
+
+		card->ext_csd.part_config = part_config;
 	}
 
 	main_md->part_curr = md->part_type;
@@ -1271,6 +1276,11 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
+		if (req) {
+			spin_lock_irq(&md->lock);
+			__blk_end_request_all(req, -EIO);
+			spin_unlock_irq(&md->lock);
+		}
 		ret = 0;
 		goto out;
 	}
-- 
1.7.6

