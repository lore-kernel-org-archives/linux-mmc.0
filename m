From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 09/22] mmc: block: Change mmc_apply_rel_rw() to get block address from the request
Date: Mon, 13 Mar 2017 14:36:40 +0200
Message-ID: <1489408613-26915-10-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21750 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbdCMMnR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:43:17 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

mmc_apply_rel_rw() will be used by Software Command Queuing also. In that
case the command argument is not the block address so change
mmc_apply_rel_rw() to get block address from the request.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 849b55654163..2750c42926d7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1309,7 +1309,7 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 {
 	if (!(card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)) {
 		/* Legacy mode imposes restrictions on transfers. */
-		if (!IS_ALIGNED(brq->cmd.arg, card->ext_csd.rel_sectors))
+		if (!IS_ALIGNED(blk_rq_pos(req), card->ext_csd.rel_sectors))
 			brq->data.blocks = 1;
 
 		if (brq->data.blocks > card->ext_csd.rel_sectors)
-- 
1.9.1

