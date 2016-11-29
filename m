From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 12/20] mmc: block: Disable Command Queue while RPMB is used
Date: Tue, 29 Nov 2016 12:09:19 +0200
Message-ID: <1480414167-15577-13-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756239AbcK2KPT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:15:19 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

RPMB does not allow Command Queue commands. Disable and re-enable the
Command Queue when switching.

Note that the driver only switches partitions when the queue is empty.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
---
 drivers/mmc/card/block.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 646d1a1fa6ca..e84e2d8f6e31 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -725,10 +725,41 @@ static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #endif
 };
 
+static int mmc_blk_part_switch_pre(struct mmc_card *card,
+				   unsigned int part_type)
+{
+	int ret = 0;
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
+	return ret;
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
@@ -737,8 +768,9 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
-		if (md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
-			mmc_retune_pause(card->host);
+		ret = mmc_blk_part_switch_pre(card, md->part_type);
+		if (ret)
+			return ret;
 
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		part_config |= md->part_type;
@@ -747,19 +779,17 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
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

