From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: card: Prevent partition scan for the eMMC boot areas
Date: Wed,  3 Sep 2014 11:02:23 +0200
Message-ID: <1409734943-21376-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:39720 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbaICJCb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 05:02:31 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so463067wib.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 02:02:27 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

It seems very unlikely that eMMC devices would hold a standard
partitiontable in one of it's boot areas. Therefore, let's prevent
them from being scanned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ede41f0..b05c67f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2131,7 +2131,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
-	if (area_type & MMC_BLK_DATA_AREA_RPMB)
+	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
 	/*
-- 
1.9.1

