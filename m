From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC] MMC: Block: Ensure hardware partitions don't mess with mmcblk device naming.
Date: Thu, 21 Apr 2011 01:07:59 -0500
Message-ID: <1303366079-2196-1-git-send-email-andreiw@motorola.com>
References: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:52045 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1DUIIV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 04:08:21 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L88iQv011159
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 04:08:44 -0400 (EDT)
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com [74.125.83.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L87rmQ010835
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 04:08:43 -0400 (EDT)
Received: by mail-pv0-f170.google.com with SMTP id 16so1147630pvg.15
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:08:18 -0700 (PDT)
In-Reply-To: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

With the hardware partitions support (which represent additional logical devices
present on MMC), devidx does not correspond with index used to form
/dev/mmcblkX names. So use an additional allocated index for device names.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9e30cf6..5572012 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -75,6 +75,7 @@ static int max_devices;
 
 /* 256 minors, so at most 256 separate devices */
 static DECLARE_BITMAP(dev_use, 256);
+static DECLARE_BITMAP(name_use, 256);
 
 /*
  * There is one mmc_blk_data per slot.
@@ -88,6 +89,7 @@ struct mmc_blk_data {
 	unsigned int	usage;
 	unsigned int	read_only;
 	unsigned int	part_type;
+	unsigned int	name_idx;
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -776,6 +778,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	}
 
 	/*
+	 * !subname implies we are creating main mmc_blk_data that will be
+	 * associated with mmc_card with mmc_set_drvdata. Due to device partitions,
+	 * devidx will not coincide with a per-physical card index anymore
+	 * so we keep track of a name index.
+	 */
+	if (!subname)
+		md->name_idx = find_first_zero_bit(name_use, max_devices);
+	else
+		md->name_idx = ((struct mmc_blk_data *)
+				dev_to_disk(parent)->private_data)->name_idx;
+
+	/*
 	 * Set the read-only status based on the supported commands
 	 * and the write protect switch.
 	 */
@@ -820,13 +834,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * messages to tell when the card is present.
 	 */
 
-	if (subname)
-		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-			 "mmcblk%d%s",
-			 mmc_get_devidx(dev_to_disk(parent)), subname);
-	else
-		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-			 "mmcblk%d", devidx);
+	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
+		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
 
 	blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
@@ -953,6 +962,7 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 	struct list_head *pos, *q;
 	struct mmc_blk_data *part_md;
 
+	__clear_bit(md->name_idx, name_use);
 	list_for_each_safe(pos, q, &md->part) {
 		part_md = list_entry(pos, struct mmc_blk_data, part);
 		list_del(pos);
-- 
1.7.0.4

