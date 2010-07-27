From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] mmc: failure of block read wait for long time
Date: Tue, 27 Jul 2010 16:57:46 +0530
Message-ID: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47098 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049Ab0G0L1y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Jul 2010 07:27:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

 multi-block read failure retries in single block read one by one. It continues
 retry of subsequent blocks, even after failure. Application will not be able
 to decode the interleave data (even if few single block read success).
 This patch fixes this problem by returning at the first failure instead of
 waiting for long duration.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/card/block.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cb9fbc8..cfb0827 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 				spin_lock_irq(&md->lock);
 				ret = __blk_end_request(req, -EIO, brq.data.blksz);
 				spin_unlock_irq(&md->lock);
-				continue;
 			}
 			goto cmd_err;
 		}
