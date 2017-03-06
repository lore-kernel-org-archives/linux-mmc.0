From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 05/18] mmc: block: Change mmc_apply_rel_rw() to get block address from the request
Date: Mon,  6 Mar 2017 11:11:00 +0200
Message-ID: <1488791473-24981-6-git-send-email-adrian.hunter@intel.com>
References: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753266AbdCFJRj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Mar 2017 04:17:39 -0500
In-Reply-To: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

mmc_apply_rel_rw() will be used by Command Queuing also. In that
case the command argument is not the block address so change
mmc_apply_rel_rw() to get block address from the request.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bd0defc5db3b..1dccc21e6912 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1302,7 +1302,7 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 {
 	if (!(card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)) {
 		/* Legacy mode imposes restrictions on transfers. */
-		if (!IS_ALIGNED(brq->cmd.arg, card->ext_csd.rel_sectors))
+		if (!IS_ALIGNED(blk_rq_pos(req), card->ext_csd.rel_sectors))
 			brq->data.blocks = 1;
 
 		if (brq->data.blocks > card->ext_csd.rel_sectors)
-- 
1.9.1

