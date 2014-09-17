From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH] mmc: block: change stop errors to info
Date: Wed, 17 Sep 2014 09:50:42 +0200
Message-ID: <1410940242-2792-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:60877 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaIQHuz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 03:50:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Johan Rudholm <johanru@axis.com>

Stop command errors are not fatal to the transfer since we make sure
that the card returns to the transfer state and check the card status.
Change an unnecessary error to an info.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..fea0376 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -977,7 +977,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 		return ERR_CONTINUE;
 
 	/* Now for stop errors.  These aren't fatal to the transfer. */
-	pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
+	pr_info("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
 	       req->rq_disk->disk_name, brq->stop.error,
 	       brq->cmd.resp[0], status);
 
-- 
1.7.2.5

