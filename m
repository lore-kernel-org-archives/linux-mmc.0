From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] mmc: block: use mmc_req_is_special()
Date: Fri, 18 Nov 2016 13:36:14 +0100
Message-ID: <1479472576-2687-2-git-send-email-linus.walleij@linaro.org>
References: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37026 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKRMg2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 07:36:28 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so34893018wmt.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 04:36:27 -0800 (PST)
In-Reply-To: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Instead of open coding the check for the same thing that
the helper checks: use the helper.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4c397b9684e5..56209d32ca5f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1735,9 +1735,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
 		    !IS_ALIGNED(blk_rq_sectors(next), 8))
 			break;
 
-		if (req_op(next) == REQ_OP_DISCARD ||
-		    req_op(next) == REQ_OP_SECURE_ERASE ||
-		    req_op(next) == REQ_OP_FLUSH)
+		if (mmc_req_is_special(next))
 			break;
 
 		if (rq_data_dir(cur) != rq_data_dir(next))
-- 
2.7.4

