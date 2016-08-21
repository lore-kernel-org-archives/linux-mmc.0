From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdio: get seg_size after the check of card
Date: Sun, 21 Aug 2016 12:30:08 +0800
Message-ID: <1471753808-1087-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37311 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbcHUEe2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2016 00:34:28 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.152])
        by lucky1.263xmail.com (Postfix) with ESMTP id D9FFF63592
        for <linux-mmc@vger.kernel.org>; Sun, 21 Aug 2016 12:34:22 +0800 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

When using mmc_io_rw_extended. it's intent to avoid
null pointer of card but actually it didn't prevent
it as the seg_size already use the card. So we need
to move this after the check.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sdio_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 34f6e80..15a06b8 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -127,7 +127,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	struct scatterlist sg, *sg_ptr;
 	struct sg_table sgtable;
 	unsigned int nents, left_size, i;
-	unsigned int seg_size = card->host->max_seg_size;
+	unsigned int seg_size;
 
 	BUG_ON(!card);
 	BUG_ON(fn > 7);
@@ -137,6 +137,8 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	if (addr & ~0x1FFFF)
 		return -EINVAL;
 
+	seg_size = card->host->max_seg_size;
+
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-- 
2.3.7


