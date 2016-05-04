From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/3] mmc: block: Always switch back to main area after RPMB access
Date: Wed,  4 May 2016 14:38:12 +0300
Message-ID: <1462361893-11897-3-git-send-email-adrian.hunter@intel.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44068 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbcEDLmJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 07:42:09 -0400
In-Reply-To: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

In preparation to support the use of the RPMB partition with transfer
modes that might require re-tuning, always switch back to the main
area after RPMB access.

RPMB is accessible only via IOCTL so only those paths are affected.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9ce679255775..a65043854458 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -618,6 +618,10 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
 
+	/* Always switch back to main area after RPMB access */
+	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
+		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
+
 	mmc_put_card(card);
 
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
@@ -685,6 +689,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	for (i = 0; i < num_of_cmds && !ioc_err; i++)
 		ioc_err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
 
+	/* Always switch back to main area after RPMB access */
+	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
+		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
+
 	mmc_put_card(card);
 
 	/* copy to user if data and response */
-- 
1.9.1

