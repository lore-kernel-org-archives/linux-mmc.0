From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 17/30] mmc: block: Disable Command Queue while RPMB is used
Date: Tue, 16 Aug 2016 13:44:27 +0300
Message-ID: <1471344280-16663-18-git-send-email-adrian.hunter@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27575 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbcHPKuZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:50:25 -0400
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

RPMB does not allow Command Queue commands. Disable and re-enable the
Command Queue when switching.

Note that the driver only switches partitions when the queue is empty.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5a117298c139..17ce02a0fb48 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -747,10 +747,41 @@ static const struct block_device_operations mmc_bdops = {
 #endif
 };
 
+static int mmc_blk_part_switch_pre(struct mmc_card *card,
+				   unsigned int part_type)
+{
+	int ret;
+
+	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+		if (card->ext_csd.cmdq_en) {
+			ret = mmc_cmdq_disable(card);
+			if (ret)
+				return ret;
+		}
+		mmc_retune_pause(card->host);
+	}
+
+	return 0;
+}
+
+static int mmc_blk_part_switch_post(struct mmc_card *card,
+				    unsigned int part_type)
+{
+	int ret = 0;
+
+	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+		mmc_retune_unpause(card->host);
+		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
+			ret = mmc_cmdq_enable(card);
+	}
+
+	return ret;
+}
+
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md)
 {
-	int ret;
+	int ret = 0;
 	struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
 
 	if (main_md->part_curr == md->part_type)
@@ -759,8 +790,9 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
-		if (md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
-			mmc_retune_pause(card->host);
+		ret = mmc_blk_part_switch_pre(card, md->part_type);
+		if (ret)
+			return ret;
 
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		part_config |= md->part_type;
@@ -769,19 +801,17 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				 EXT_CSD_PART_CONFIG, part_config,
 				 card->ext_csd.part_time);
 		if (ret) {
-			if (md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
-				mmc_retune_unpause(card->host);
+			mmc_blk_part_switch_post(card, md->part_type);
 			return ret;
 		}
 
 		card->ext_csd.part_config = part_config;
 
-		if (main_md->part_curr == EXT_CSD_PART_CONFIG_ACC_RPMB)
-			mmc_retune_unpause(card->host);
+		ret = mmc_blk_part_switch_post(card, main_md->part_curr);
 	}
 
 	main_md->part_curr = md->part_type;
-	return 0;
+	return ret;
 }
 
 static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
-- 
1.9.1

