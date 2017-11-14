From: Huijin Park <huijin.park@samsung.com>
Subject: [PATCH] mmc: card: increase wait time
Date: Tue, 14 Nov 2017 11:48:03 +0900
Message-ID: <1510627683-5209-1-git-send-email-huijin.park@samsung.com>
References: <CGME20171114024825eucas1p218873c4ff649c17d4061b6660aa6264f@eucas1p2.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49486 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdKNCsa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Nov 2017 21:48:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, bbang.huijin.park@gmail.com, Huijin Park <huijin.park@samsung.com>

Some eMMC products keep busy time a little longer intermittently.
(eg. prepare free blocks, garbage collection...)
In this case, we recommend to wait a little longer than fail.

Signed-off-by: Huijin Park <huijin.park@samsung.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4..b5b0fe6 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -584,7 +584,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * Ensure RPMB command has completed by polling CMD13
 		 * "Send Status".
 		 */
-		err = ioctl_rpmb_card_status_poll(card, &status, 5);
+		err = ioctl_rpmb_card_status_poll(card, &status, 50);
 		if (err)
 			dev_err(mmc_dev(card->host),
 					"%s: Card Status=0x%08X, error %d\n",
-- 
1.9.1

