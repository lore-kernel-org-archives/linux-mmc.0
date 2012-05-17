From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH v2 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 16:32:21 +0530
Message-ID: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:50904 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761607Ab2EQLEO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 07:04:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, saugata.das@linaro.org, subhashj@codeaurora.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com, linkinjeon@gmail.com

From: Saugata Das <saugata.das@linaro.org>

This patch adds the support for large sector size of 4KB by disabling emulation.
This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
mmc_blk_alloc_req.

In order to use this patch for 4KB sector size, ensure that USE_NATIVE_SECTOR
is enabled, partition table is 4KB sector size aligned and file system block
and sector size are 4KB multiples.

Signed-off-by: Saugata Das <saugata.das@linaro.org>

changes in v2:
	Updated description, added pr_err based on review feedback
---
 drivers/mmc/card/block.c |   18 ++++++++++++++++--
 drivers/mmc/core/mmc.c   |    2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 91cda75..d628c5d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1284,7 +1284,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	int ret = 1, disable_multi = 0, retry = 0, type;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
-	struct request *req;
+	struct request *req = rqc;
 	struct mmc_async_req *areq;
 
 	if (!rqc && !mq->mqrq_prev->req)
@@ -1292,6 +1292,16 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 	do {
 		if (rqc) {
+			/*
+			 * When 4KB native sector is enabled, only 8 blocks
+			 * multiple read or write is allowed
+			 */
+			if ((brq->data.blocks & 0x07) &&
+				(card->ext_csd.data_sector_size == 4096)) {
+				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
+					req->rq_disk->disk_name);
+				goto cmd_abort;
+			}
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
@@ -1539,7 +1549,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
 		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
 
-	blk_queue_logical_block_size(md->queue.queue, 512);
+	if (mmc_card_mmc(card))
+		blk_queue_logical_block_size(md->queue.queue,
+			card->ext_csd.data_sector_size);
+	else
+		blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
 	if (mmc_host_cmd23(card->host)) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7268c26..11444c6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -516,6 +516,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		} else {
 			card->ext_csd.data_tag_unit_size = 0;
 		}
+	} else {
+		card->ext_csd.data_sector_size = 512;
 	}
 
 out:
-- 
1.7.4.3

