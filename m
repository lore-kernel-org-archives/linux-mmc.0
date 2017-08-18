From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdio: fix bug for IO transfer due to incorrect size check
Date: Fri, 18 Aug 2017 10:35:29 +0800
Message-ID: <1503023729-243359-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:43734 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdHRCgd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Aug 2017 22:36:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

I got some reports that some sdio-WiFis weren't able to finish
data transfer randomly in there stress test but hard to reproduce
it. However after analysing the code, I find a long standing bug
which seems could explain how that happened.

If the function drivers call sdio_memcpy_{fromio, toio}, it may
set the count to 512 Bytes. If the multiple_block in CCCR shows
it does support that, we now need to do the checking of 'size >
sdio_max_byte_size(func)'. If func->max_blksize, func->cur_blksize,
and func->max_blksize are 512, and func->card->host->max_blk_size
is larger than 512, thus we will expect sdio_max_byte_size return
512 in gerenal. Then it will fail the checking, and falls into using
byte mode for transferring 512 Bytes. Note that we use mmc_io_rw_extended
for that with zero blocks and 512 size as arguments. So cmd.arg
is zero instead of 512 that the wifi can't get this and abort the
data transfer.

To fix it, we should allow size to be equal as func's sdio_max_byte_size.
That works fine and sloves the problems I got by testing.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Hi Ulf,

Not sure whether should we add a fix tag and CC stable as it seems it has
been there since 2007. 

 drivers/mmc/core/sdio_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index d40744b..42c3424 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -313,7 +313,8 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
 		return -EINVAL;
 
 	/* Do the bulk of the transfer using block mode (if supported). */
-	if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
+	if (func->card->cccr.multi_block &&
+	    size >= sdio_max_byte_size(func)) {
 		/* Blocks per command is limited by host count, host transfer
 		 * size and the maximum for IO_RW_EXTENDED of 511 blocks. */
 		max_blocks = min(func->card->host->max_blk_count, 511u);
-- 
1.9.1


