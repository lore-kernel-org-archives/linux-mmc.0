From: =?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?=
	<hebert.marcandre@gmail.com>
Subject: [PATCH] MMC: Fix the block device read only flag
Date: Mon, 31 Jan 2011 11:42:17 -0500
Message-ID: <AANLkTin71fwTVtVY0j-VNPQpGRkwossvhN+28V=VV-pN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55581 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab1AaQmS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2011 11:42:18 -0500
Received: by yib18 with SMTP id 18so2038695yib.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2011 08:42:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

While the MMC handled the card's read only flag correctly on open,
it did not setup the flag in the allocated disk structure. The
consequence being that probing the /sys/class/block/mmcblkX/ro
attribute always reported 0.

Signed-off-by: Marc-Andre Hebert <hebert.marcandre@gmail.com>
---
 drivers/mmc/card/block.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bfc8a8a..61d233a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -621,6 +621,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct
mmc_card *card)
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = &card->dev;
+	set_disk_ro(md->disk, md->read_only);

 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.6.0.4
