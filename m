From: sdliyong@gmail.com
Subject: [PATCH] mmc: block: disable the reliable write If the card does not support CMD23
Date: Fri, 14 Aug 2015 15:30:46 +0800
Message-ID: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43204 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbHNHcw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Aug 2015 03:32:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sdliyong@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yong Li <sdliyong@gmail.com>

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/mmc/card/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..d9e3c45 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
 			  (req->cmd_flags & REQ_META)) &&
 		(rq_data_dir(req) == WRITE) &&
-		(md->flags & MMC_BLK_REL_WR);
+		(md->flags & MMC_BLK_REL_WR) &&
+		!(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
 
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 	brq->mrq.cmd = &brq->cmd;
-- 
2.1.0

