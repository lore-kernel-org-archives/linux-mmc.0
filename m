From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 3/3] mmc: block: Pause re-tuning while switched to the RPMB partition
Date: Wed,  4 May 2016 14:38:13 +0300
Message-ID: <1462361893-11897-4-git-send-email-adrian.hunter@intel.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44068 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbcEDLmL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 07:42:11 -0400
In-Reply-To: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

Re-tuning is not possible when switched to the RPMB
partition.  However re-tuning should not be needed
if re-tuning is done immediately before switching,
a small set of operations is done, and then we
immediately switch back to the main partition.

A previous patch ensured that we immediately switch
back to the main partition.

This patch uses the new facility to "pause" re-tuning
before switching to the RPMB partition, and to "unpause"
it after switching from the RPMB partition.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a65043854458..565009b190cd 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -756,16 +756,25 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
+		if (md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
+			mmc_retune_pause(card->host);
+
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		part_config |= md->part_type;
 
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_PART_CONFIG, part_config,
 				 card->ext_csd.part_time);
-		if (ret)
+		if (ret) {
+			if (md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
+				mmc_retune_unpause(card->host);
 			return ret;
+		}
 
 		card->ext_csd.part_config = part_config;
+
+		if (main_md->part_curr == EXT_CSD_PART_CONFIG_ACC_RPMB)
+			mmc_retune_unpause(card->host);
 	}
 
 	main_md->part_curr = md->part_type;
-- 
1.9.1

