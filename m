From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: [PATCH] mmc: sdio: Fix to support any block size optimally
Date: Wed, 26 Oct 2011 10:52:17 +0200
Message-ID: <1319619137-17156-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:44736 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932331Ab1JZI6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2011 04:58:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

This patch allows any block size to be set on the SDIO link,
and still have an arbitrary sized packet (adjusted in size by
using sdio_align_size) transferred in an optimal way
(preferably one transfer).

Previously if the block size was larger than the default of
512 bytes and the transfer size was exactly one block size
(possibly thanks to using sdio_align_size to get an optimal
transfer size), it was sent as a number of byte transfers instead
of one block transfer. Also if the number of blocks was
(max_blocks * N) + 1, the tranfer would be conducted with a number
of blocks and finished off with a number of byte transfers.

When doing this change it was also possible to break out the quirk
for broken byte mode in a much cleaner way, and collect the logic of
when to do byte or block transfer in one function instead of two.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/sdio_io.c  |    8 ++++++--
 drivers/mmc/core/sdio_ops.c |   14 +++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 0f687cd..b20fbb4 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -195,6 +195,9 @@ static inline unsigned int sdio_max_byte_size(struct sdio_func *func)
 	else
 		mval = min(mval, func->max_blksize);
 
+	if (mmc_card_broken_byte_mode_512(func->card))
+		return min(mval, 511u);
+
 	return min(mval, 512u); /* maximum size for byte mode */
 }
 
@@ -313,7 +316,7 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
 			func->card->host->max_seg_size / func->cur_blksize);
 		max_blocks = min(max_blocks, 511u);
 
-		while (remainder > func->cur_blksize) {
+		while (remainder >= func->cur_blksize) {
 			unsigned blocks;
 
 			blocks = remainder / func->cur_blksize;
@@ -338,8 +341,9 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
 	while (remainder > 0) {
 		size = min(remainder, sdio_max_byte_size(func));
 
+		/* Indicate byte mode by setting "blocks" = 0 */
 		ret = mmc_io_rw_extended(func->card, write, func->num, addr,
-			 incr_addr, buf, 1, size);
+			 incr_addr, buf, 0, size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index b0517cc..d29e206 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -128,8 +128,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 
 	BUG_ON(!card);
 	BUG_ON(fn > 7);
-	BUG_ON(blocks == 1 && blksz > 512);
-	WARN_ON(blocks == 0);
 	WARN_ON(blksz == 0);
 
 	/* sanity check */
@@ -144,22 +142,20 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	cmd.arg |= fn << 28;
 	cmd.arg |= incr_addr ? 0x04000000 : 0x00000000;
 	cmd.arg |= addr << 9;
-	if (blocks == 1 && blksz < 512)
-		cmd.arg |= blksz;			/* byte mode */
-	else if (blocks == 1 && blksz == 512 &&
-		 !(mmc_card_broken_byte_mode_512(card)))
-		cmd.arg |= 0;				/* byte mode, 0==512 */
+	if (blocks == 0)
+		cmd.arg |= (blksz == 512) ? 0 : blksz;	/* byte mode */
 	else
 		cmd.arg |= 0x08000000 | blocks;		/* block mode */
 	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
 
 	data.blksz = blksz;
-	data.blocks = blocks;
+	/* Code in host drivers/fwk assumes that "blocks" always is >=1 */
+	data.blocks = blocks ? blocks : 1;
 	data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, buf, blksz * blocks);
+	sg_init_one(&sg, buf, data.blksz * data.blocks);
 
 	mmc_set_data_timeout(&data, card);
 
-- 
1.7.7

