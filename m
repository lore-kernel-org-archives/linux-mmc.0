From: Loic Pallardy <loic.pallardy@stericsson.com>
Subject: [PATCH v1 2/5] mmc: card: Do not scan RPMB partitions
Date: Fri, 6 Jul 2012 10:44:01 +0200
Message-ID: <1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:49910 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141Ab2GFJK3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 05:10:29 -0400
In-Reply-To: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

Do not scan rpmb partitions for "soft" partitions, since the rpmb
partition contains protected data. Silences the following
message during boot:

 mmcblkXRPMB: unknown partition table

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/card/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 276d21c..1b202fe 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1521,6 +1521,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	md->disk->flags = GENHD_FL_EXT_DEVT;
+	if (area_type & MMC_BLK_DATA_AREA_RPMB)
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.7.11.1

