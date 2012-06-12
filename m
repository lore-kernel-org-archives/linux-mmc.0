From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH] mmc: card: Do not scan boot partitions
Date: Tue, 12 Jun 2012 15:04:13 +0200
Message-ID: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:37610 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751168Ab2FLNEi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 09:04:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

Do not scan boot partitions for "soft" partitions, since the boot
partitions are supposed to contain boot code. Silences the following
message during boot:

 mmcblkXbootY: unknown partition table

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/card/block.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7e3f453..efdea68 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1515,6 +1515,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	if (area_type & MMC_BLK_DATA_AREA_BOOT)
+		md->disk->flags = GENHD_FL_NO_PART_SCAN;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.7.10

