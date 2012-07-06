From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH v2] Fix for checking block numbers in disable emulation mode
Date: Fri, 6 Jul 2012 19:25:04 +0530
Message-ID: <1341582904-31896-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:42423 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756018Ab2GFNzZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 09:55:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, Saugata Das <saugata.das@linaro.org>

From: Saugata Das <saugata.das@linaro.org>

In 512B disable emulation patch, a check is done to ensure that size
of the data is multiple of 4KB within mmc_blk_issue_rw_rq. However,
the check is done with brq->data.blocks, which is not initialized at
the point of check. This is now changed to blk_rq_sectors.

In addition, when retrying read transfers, the current code retries
with single block. This has been changed to 8 blocks if disable
emulation is enabled.

For hosts which are not capable to handle transfer of multiple of 4KB,
a check has been added in mmc_read_ext_csd. A check has been added for
reliable write with EN_REL_WR=0, which is not allowed.

Signed-off-by: Saugata Das <saugata.das@linaro.org>

Changes in v2 :
	- Added check in mmc_read_ext_csd
---
 drivers/mmc/card/block.c |   19 +++++++++++++------
 drivers/mmc/core/mmc.c   |    9 +++++++--
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d628c5d..69b7b03 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1114,7 +1114,10 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
 			  (req->cmd_flags & REQ_META)) &&
 		(rq_data_dir(req) == WRITE) &&
-		(md->flags & MMC_BLK_REL_WR);
+		(md->flags & MMC_BLK_REL_WR) &&
+		((card->ext_csd.data_sector_size == 512) ||
+		 ((card->ext_csd.data_sector_size == 4096) &&
+		  (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)));
 
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 	brq->mrq.cmd = &brq->cmd;
@@ -1145,7 +1148,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		 * sectors can be read successfully.
 		 */
 		if (disable_multi)
-			brq->data.blocks = 1;
+			brq->data.blocks =
+				(card->ext_csd.data_sector_size == 4096) ?
+					8 : 1;
 
 		/* Some controllers can't do multiblock reads due to hw bugs */
 		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
@@ -1296,10 +1301,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * When 4KB native sector is enabled, only 8 blocks
 			 * multiple read or write is allowed
 			 */
-			if ((brq->data.blocks & 0x07) &&
+			if ((blk_rq_sectors(req) & 0x07) &&
 				(card->ext_csd.data_sector_size == 4096)) {
-				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-					req->rq_disk->disk_name);
+				pr_err("%s: Transfer size [%d] is not 4KB sector size aligned\n",
+					req->rq_disk->disk_name,
+					blk_rq_sectors(req));
 				goto cmd_abort;
 			}
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
@@ -1364,7 +1370,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			/* Fall through */
 		}
 		case MMC_BLK_ECC_ERR:
-			if (brq->data.blocks > 1) {
+			if (brq->data.blocks >
+				(card->ext_csd.data_sector_size >> 9)) {
 				/* Redo read one sector at a time */
 				pr_warning("%s: retrying using single block read\n",
 					   req->rq_disk->disk_name);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 28fbd77..fb68f17 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -503,9 +503,14 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
 			ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
 
-		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 1)
+		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 1) {
+			if ((card->host->caps2 & MMC_CAP2_NO_MULTI_READ) ||
+				(card->host->max_blk_count & 0x07)) {
+				err = -EINVAL;
+				goto out;
+			}
 			card->ext_csd.data_sector_size = 4096;
-		else
+		} else
 			card->ext_csd.data_sector_size = 512;
 
 		if ((ext_csd[EXT_CSD_DATA_TAG_SUPPORT] & 1) &&
-- 
1.7.4.3

