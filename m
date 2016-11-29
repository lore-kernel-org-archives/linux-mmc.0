From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 01/20] mmc: block: Restore line inadvertently removed with packed commands
Date: Tue, 29 Nov 2016 12:09:08 +0200
Message-ID: <1480414167-15577-2-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19090 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbcK2KOf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:14:35 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 86ff28f84698..19597e3cefcb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1587,6 +1587,8 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		if (blocks != (u32)-1) {
 			ret = blk_end_request(req, 0, blocks << 9);
 		}
+	} else {
+		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
 	}
 	return ret;
 }
-- 
1.9.1

