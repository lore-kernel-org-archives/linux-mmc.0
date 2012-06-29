From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH] [MMC 4.5] Fix for checking block numbers in disable emulation mode
Date: Fri, 29 Jun 2012 12:02:34 +0530
Message-ID: <1340951554-29504-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:35310 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007Ab2F2GdH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 02:33:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, Saugata Das <saugata.das@linaro.org>

From: Saugata Das <saugata.das@linaro.org>

In 512B disable emulation patch, a check is done to ensure that size
of the data is multiple of 4KB. However, the check is done with
brq->data.blocks, which is not initialized at the point of check.
This is now changed to blk_rq_sectors.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
---
 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d628c5d..ee8b3d6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1296,7 +1296,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * When 4KB native sector is enabled, only 8 blocks
 			 * multiple read or write is allowed
 			 */
-			if ((brq->data.blocks & 0x07) &&
+			if ((blk_rq_sectors(req) & 0x07) &&
 				(card->ext_csd.data_sector_size == 4096)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					req->rq_disk->disk_name);
-- 
1.7.4.3

