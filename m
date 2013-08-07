From: Franck Jullien <franck.jullien@gmail.com>
Subject: [RESEND PATCH] mmc: block: fix null pointer use in mmc_blk_remove_req
Date: Wed,  7 Aug 2013 10:23:13 +0200
Message-ID: <1375863793-13394-1-git-send-email-franck.jullien@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:49001 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab3HGINv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Aug 2013 04:13:51 -0400
Received: by mail-wg0-f54.google.com with SMTP id e12so1216646wgh.33
        for <linux-mmc@vger.kernel.org>; Wed, 07 Aug 2013 01:13:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: taysom@chromium.org, Franck Jullien <franck.jullien@gmail.com>

A previous commit (fdfa20c1631210d0) reordered the
shutdown sequence in mmc_blk_remove_req. However,
mmc_cleanup_queue is now called before we get the
card pointer and, sadly, mmc_cleanup_queue set
mq->card to NULL.

This patch moves the card pointer assignment before
mmc_cleanup_queue.
---
 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cd0b7f4..f4a0bea 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2191,10 +2191,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * is freeing the queue that stops new requests
 		 * from being accepted.
 		 */
+		card = md->queue.card;
 		mmc_cleanup_queue(&md->queue);
 		if (md->flags & MMC_BLK_PACKED_CMD)
 			mmc_packed_clean(&md->queue);
-		card = md->queue.card;
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
-- 
1.7.1

