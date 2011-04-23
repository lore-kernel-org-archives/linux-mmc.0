From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/6] mmc_block: Allow more than 8 partitions per card
Date: Fri, 22 Apr 2011 18:01:38 -0700
Message-ID: <1303520502-32171-3-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49516 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757118Ab1DWBB4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 21:01:56 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0Zfwi028309
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 20:35:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3N11sj41274040
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 21:01:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11rjv010064
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 21:01:54 -0400
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, John Stultz <john.stultz@linaro.org>

From: Colin Cross <ccross@android.com>

Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
in major 259 for partitions past disk->minors.

Also remove the use of disk_devt to determine devidx from md->disk.
md->disk->first_minor is always initialized from devidx and can
always be used to recover it.

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/card/block.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index edac9ac..f69f948 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -102,11 +102,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
-		int devmaj = MAJOR(disk_devt(md->disk));
-		int devidx = MINOR(disk_devt(md->disk)) / perdev_minors;
-
-		if (!devmaj)
-			devidx = md->disk->first_minor / perdev_minors;
+		int devidx = md->disk->first_minor / perdev_minors;
 
 		blk_cleanup_queue(md->queue.queue);
 
@@ -623,6 +619,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = &card->dev;
+	md->disk->flags = GENHD_FL_EXT_DEVT;
 	set_disk_ro(md->disk, md->read_only);
 
 	/*
-- 
1.7.3.2.146.gca209

