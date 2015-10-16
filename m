From: John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH] mmc_block: Allow more than 8 partitions per card
Date: Fri, 16 Oct 2015 11:40:46 -0700
Message-ID: <1445020846-529-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34519 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551AbbJPSk7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 14:40:59 -0400
Received: by pacez2 with SMTP id ez2so11670440pac.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 11:40:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Colin Cross <ccross@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org, John Stultz <john.stultz@linaro.org>

From: Colin Cross <ccross@android.com>

It is quite common for Android devices to utilize more
then 8 partitions on internal eMMC storage. This patch,
which has been carried for quite awhile in the AOSP common
tree is necessary in order to support such configurations,
so I wanted to submit it for consideration upstream.

This patch sets the GENHD_FL_EXT_DEVT flag, which will
allocate minor number in major 259 for partitions past
disk->minors.

It also removes the use of disk_devt to determine devidx
from md->disk. md->disk->first_minor is always initialized
from devidx and can always be used to recover it.

Thoughts or feedback would be greatly appreciated.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Colin Cross <ccross@android.com>
[jstultz: Added context to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/card/block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c742cfd..564436e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -172,11 +172,7 @@ static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 
 static inline int mmc_get_devidx(struct gendisk *disk)
 {
-	int devmaj = MAJOR(disk_devt(disk));
-	int devidx = MINOR(disk_devt(disk)) / perdev_minors;
-
-	if (!devmaj)
-		devidx = disk->first_minor / perdev_minors;
+	int devidx = disk->first_minor / perdev_minors;
 	return devidx;
 }
 
@@ -2162,6 +2158,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
-- 
1.9.1

