From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 3/5] drivers: mmc: card: Fixes WARNING braces are not necessary for single statement
Date: Mon,  2 Feb 2015 01:37:00 +0530
Message-ID: <1422821222-24079-4-git-send-email-sheetal.tigadoli@gmail.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43464 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbbBAUJt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Feb 2015 15:09:49 -0500
In-Reply-To: <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>

Patch fixes following coding style warnings.
        drivers/mmc/card/block.c:1734: WARNING: braces {} are not necessary for single statement blocks
        drivers/mmc/card/block.c:2019: WARNING: braces {} are not necessary for single statement blocks
              

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 741a1e1..2394d0b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1733,9 +1733,8 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		u32 blocks;
 
 		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
+		if (blocks != (u32)-1)
 			ret = blk_end_request(req, 0, blocks << 9);
-		}
 	} else {
 		if (!mmc_packed_cmd(mq_rq->cmd_type))
 			ret = blk_end_request(req, 0, brq->data.bytes_xfered);
@@ -2018,9 +2017,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
-		if (req) {
+		if (req)
 			blk_end_request_all(req, -EIO);
-		}
 		ret = 0;
 		goto out;
 	}
-- 
1.7.9.5

