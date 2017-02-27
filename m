From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: block: Fix cmd error reset failure path
Date: Mon, 27 Feb 2017 09:36:35 +0200
Message-ID: <558473bd-9fea-6f95-4eb1-9d72b5a25234@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdB0HmK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Feb 2017 02:42:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linus walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Commit 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
assumed the request had not completed, but in one case it had. Fix that.

Fixes: 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b6d1497c395f..b277ce50a391 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1708,7 +1708,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		case MMC_BLK_CMD_ERR:
 			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 			if (mmc_blk_reset(md, card->host, type)) {
-				mmc_blk_rw_cmd_abort(card, old_req);
+				if (req_pending)
+					mmc_blk_rw_cmd_abort(card, old_req);
 				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
-- 
1.9.1

