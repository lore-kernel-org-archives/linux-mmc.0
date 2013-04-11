From: Yong Li <sdliyong@gmail.com>
Subject: [PATCH 1/1] mmc: card: If the card does not support CMD23, disable the reliable write
Date: Thu, 11 Apr 2013 14:31:12 +0800
Message-ID: <1365661872-32300-1-git-send-email-sdliyong@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38607 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab3DKGbz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Apr 2013 02:31:55 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so692156pbc.17
        for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2013 23:31:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>
Cc: Yong Li <sdliyong@gmail.com>


Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/mmc/card/block.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 21056b9..8039a87 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1175,7 +1175,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
 			  (req->cmd_flags & REQ_META)) &&
 		(rq_data_dir(req) == WRITE) &&
-		(md->flags & MMC_BLK_REL_WR);
+		(md->flags & MMC_BLK_REL_WR) &&
+		!(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
 
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 	brq->mrq.cmd = &brq->cmd;
-- 
1.7.10.4

