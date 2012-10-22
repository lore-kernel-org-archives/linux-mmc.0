From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] mmc: sdio: To use multiple scatter gather list
Date: Mon, 22 Oct 2012 20:01:00 +0900
Message-ID: <001101cdb044$8565abf0$903103d0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23199 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab2JVLBC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Oct 2012 07:01:02 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCA009D2JXMIEP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Oct 2012 20:01:00 +0900 (KST)
Received: from DOKI0351KIM04 ([12.23.119.96])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MCA004Q4JXO8920@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Oct 2012 20:01:00 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyoungil Kim' <ki0351.kim@samsung.com>

We used only single sg entry for SDIO transfer.
This chagne is to use multiple sg entry.
In case of dwmci, it support only up to 4KB size per single sg entry.
So if we want to transfer more than 4KB, we should send more than 1 command.
This makes performance degradation for large data transfer.

Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/mmc/core/sdio_io.c  |   10 +++-------
 drivers/mmc/core/sdio_ops.c |   33 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 8f6f5ac..78cb4d5 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -188,8 +188,7 @@ EXPORT_SYMBOL_GPL(sdio_set_block_size);
  */
 static inline unsigned int sdio_max_byte_size(struct sdio_func *func)
 {
-	unsigned mval =	min(func->card->host->max_seg_size,
-			    func->card->host->max_blk_size);
+	unsigned mval =	func->card->host->max_blk_size;
 
 	if (mmc_blksz_for_byte_mode(func->card))
 		mval = min(mval, func->cur_blksize);
@@ -311,11 +310,8 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
 	/* Do the bulk of the transfer using block mode (if supported). */
 	if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
 		/* Blocks per command is limited by host count, host transfer
-		 * size (we only use a single sg entry) and the maximum for
-		 * IO_RW_EXTENDED of 511 blocks. */
-		max_blocks = min(func->card->host->max_blk_count,
-			func->card->host->max_seg_size / func->cur_blksize);
-		max_blocks = min(max_blocks, 511u);
+		 * size and the maximum for IO_RW_EXTENDED of 511 blocks. */
+		max_blocks = min(func->card->host->max_blk_count, 511u);
 
 		while (remainder >= func->cur_blksize) {
 			unsigned blocks;
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index d29e206..ac01352 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -124,7 +124,10 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
-	struct scatterlist sg;
+	struct scatterlist sg, *sg_ptr;
+	struct sg_table sgtable;
+	unsigned int nents, left_size, i;
+	unsigned int seg_size = card->host->max_seg_size;
 
 	BUG_ON(!card);
 	BUG_ON(fn > 7);
@@ -152,15 +155,37 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	/* Code in host drivers/fwk assumes that "blocks" always is >=1 */
 	data.blocks = blocks ? blocks : 1;
 	data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
-	data.sg = &sg;
-	data.sg_len = 1;
 
-	sg_init_one(&sg, buf, data.blksz * data.blocks);
+	left_size = data.blksz * data.blocks;
+	nents = (left_size - 1) / seg_size + 1;
+	if (nents > 1) {
+		if (sg_alloc_table(&sgtable, nents, GFP_KERNEL))
+			return -ENOMEM;
+
+		data.sg = sgtable.sgl;
+		data.sg_len = nents;
+
+		for_each_sg(data.sg, sg_ptr, data.sg_len, i) {
+			sg_set_page(sg_ptr, virt_to_page(buf + (i * seg_size)),
+					min(seg_size, left_size),
+					offset_in_page(buf + (i * seg_size)));
+			left_size = left_size - seg_size;
+		}
+	} else {
+		data.sg = &sg;
+		data.sg_len = 1;
+
+		sg_init_one(&sg, buf, left_size);
+	}
 
 	mmc_set_data_timeout(&data, card);
 
 	mmc_wait_for_req(card->host, &mrq);
 
+	if (nents > 1)
+		sg_free_table(&sgtable);
+
+
 	if (cmd.error)
 		return cmd.error;
 	if (data.error)
-- 
1.7.4.1


