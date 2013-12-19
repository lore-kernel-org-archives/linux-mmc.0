From: Abbas Raza <abbas_raza@mentor.com>
Subject: [RFC PATCH] mmc: card: Skip regular block io operations for RPMB partitions
Date: Thu, 19 Dec 2013 08:50:07 +0500
Message-ID: <1387425007-31919-1-git-send-email-abbas_raza@mentor.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63192 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab3LSDuT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 22:50:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Abbas Raza <Abbas_Raza@mentor.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Chris Ball <cjb@laptop.org>

From: Abbas Raza <Abbas_Raza@mentor.com>

Idea behind this patch is to skip all the regular block io operations
for RPMB partitions because these are not regular partitions and require
a different command sequence for reading and writing. RPMB partitions
should only be accessed via ioctl. Without this patch we see following
issues with some eMMC devices

dd if=/dev/mmcblk1rpmb of=/dev/null bs=1 count=1
[  124.185513] mmcblk1rpmb: error -110 transferring data, sector 0, nr 32, cmd response 0x900, card status 0xb00
[  124.195506] mmcblk1rpmb: retrying using single block read
[  124.201035] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.208559] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.216049] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.223567] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.231087] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.238600] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  124.246012] end_request: I/O error, dev mmcblk1rpmb, sector 0
[  124.251773] Buffer I/O error on device mmcblk1rpmb, logical block 0
[  124.258065] end_request: I/O error, dev mmcblk1rpmb, sector 8
[  124.263822] Buffer I/O error on device mmcblk1rpmb, logical block 1
[  124.270102] end_request: I/O error, dev mmcblk1rpmb, sector 16
[  124.275944] Buffer I/O error on device mmcblk1rpmb, logical block 2
[  124.282222] end_request: I/O error, dev mmcblk1rpmb, sector 24
[  124.288064] Buffer I/O error on device mmcblk1rpmb, logical block 3
[  129.717711] mmcblk1rpmb: error -110 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
[  129.727590] mmcblk1rpmb: retrying using single block read
[  129.733088] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.740605] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.748121] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.755612] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.763125] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.770639] mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
[  129.778073] end_request: I/O error, dev mmcblk1rpmb, sector 0
[  129.783834] Buffer I/O error on device mmcblk1rpmb, logical block 0
dd: /dev/mmcblk1rpmb: Input/output error

Cc: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
---
 drivers/mmc/card/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a376ad1..93fbe66 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1489,6 +1489,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
 
+	if (md->area_type & MMC_BLK_DATA_AREA_RPMB) {
+		if (req)
+			blk_end_request_all(req, 0);
+		ret = 0;
+		goto out;
+	}
+
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
-- 
1.8.3.2

