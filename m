From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 2/2] mmc: card: Fix use of uninitialized data in mmc_blk_issue_rw_rq.
Date: Wed, 13 Apr 2011 16:32:10 -0400
Message-ID: <1302726730-17324-2-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:56368 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515Ab1DMU1m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 16:27:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

mmc_blk_issue_rw_rq did not zero out mmc_command on stack.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c209953..9e30cf6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -504,6 +504,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		struct mmc_command cmd;
 		u32 readcmd, writecmd, status = 0;
 
+		memset(&cmd, 0, sizeof(struct mmc_command));
 		memset(&brq, 0, sizeof(struct mmc_blk_request));
 		brq.mrq.cmd = &brq.cmd;
 		brq.mrq.data = &brq.data;
-- 
1.7.0.1

