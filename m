From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 10/13] mmc: block: Prepare CQE data
Date: Thu, 10 Aug 2017 15:08:15 +0300
Message-ID: <1502366898-23691-11-git-send-email-adrian.hunter@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61492 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752668AbdHJMP1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Aug 2017 08:15:27 -0400
In-Reply-To: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Enhance mmc_blk_data_prep() to support CQE requests. That means adding
some things that for non-CQE requests would be encoded into the command
arguments - such as the block address, reliable-write flag, and data tag
flag. Also the request tag is needed to provide the command queue task id,
and a comment is added to explain the future possibility of defining a
priority.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bd7a899979d4..d8677b28af5c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1505,6 +1505,7 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
 	brq->mrq.data = &brq->data;
+	brq->mrq.tag = req->tag;
 
 	brq->stop.opcode = MMC_STOP_TRANSMISSION;
 	brq->stop.arg = 0;
@@ -1519,6 +1520,14 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 
 	brq->data.blksz = 512;
 	brq->data.blocks = blk_rq_sectors(req);
+	brq->data.blk_addr = blk_rq_pos(req);
+
+	/*
+	 * The command queue supports 2 priorities: "high" (1) and "simple" (0).
+	 * The eMMC will give "high" priority tasks priority over "simple"
+	 * priority tasks. Here we always set "simple" priority by not setting
+	 * MMC_DATA_PRIO.
+	 */
 
 	/*
 	 * The block layer doesn't support all sector count
@@ -1548,8 +1557,10 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 						brq->data.blocks);
 	}
 
-	if (do_rel_wr)
+	if (do_rel_wr) {
 		mmc_apply_rel_rw(brq, card, req);
+		brq->data.flags |= MMC_DATA_REL_WR;
+	}
 
 	/*
 	 * Data tag is used only during writing meta data to speed
@@ -1561,6 +1572,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		      ((brq->data.blocks * brq->data.blksz) >=
 		       card->ext_csd.data_tag_unit_size);
 
+	if (do_data_tag)
+		brq->data.flags |= MMC_DATA_DAT_TAG;
+
 	mmc_set_data_timeout(&brq->data, card);
 
 	brq->data.sg = mqrq->sg;
-- 
1.9.1

