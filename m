From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Subject: [PATCH v2 2/5] mmc: card: Do not scan RPMB partitions
Date: Wed, 11 Jul 2012 15:01:15 +0200
Message-ID: <1342011675-11221-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:53544 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754837Ab2GKNCL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jul 2012 09:02:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

From: Loic Pallardy <loic.pallardy@stericsson.com>

Do not scan rpmb partitions for "soft" partitions, since the rpmb
partition contains protected data. Silences the following
message during boot:

 mmcblkXRPMB: unknown partition table

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/card/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 276d21c..d8edb8d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1521,6 +1521,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	if (area_type & MMC_BLK_DATA_AREA_RPMB)
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.7.11.1

