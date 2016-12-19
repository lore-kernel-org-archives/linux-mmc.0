From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] mmc: block: Avoid uninitialized warning in mmc_blk_issue_discard_rq()
Date: Mon, 19 Dec 2016 15:03:44 +0100
Message-ID: <1482156225-32517-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:33746 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbcLSODl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2016 09:03:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

With gcc-4.1.2:

    mmc/core/block.c: In function ‘mmc_blk_issue_discard_rq’:
    mmc/core/block.c:1150: warning: ‘arg’ may be used uninitialized in this function
    mmc/core/block.c:1150: warning: ‘nr’ may be used uninitialized in this function
    mmc/core/block.c:1150: warning: ‘from’ may be used uninitialized in this function

While this is a false positive, it can be avoided easily by jumping over
the checks for "err" that are always false.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bab3f07b1117ea81..8c0e0833d481cf94 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1152,7 +1152,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
-		goto out;
+		goto fail;
 	}
 
 	from = blk_rq_pos(req);
@@ -1181,6 +1181,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
+fail:
 	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
-- 
1.9.1

