From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 02/22] mmc: block: Fix cmd error reset failure path
Date: Mon, 13 Mar 2017 14:36:33 +0200
Message-ID: <1489408613-26915-3-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40699 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753135AbdCMMmq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:42:46 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Commit 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
assumed the request had not completed, but in one case it had. Fix that.

Fixes: 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e59107ca512a..05afefcfb611 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1701,7 +1701,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		case MMC_BLK_CMD_ERR:
 			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 			if (mmc_blk_reset(md, card->host, type)) {
-				mmc_blk_rw_cmd_abort(card, old_req);
+				if (req_pending)
+					mmc_blk_rw_cmd_abort(card, old_req);
 				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
-- 
1.9.1

