From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 12/12] mmc: block: don't use the OR operation for flag of data
Date: Fri, 29 Jan 2016 13:06:11 +0900
Message-ID: <1454040371-31625-13-git-send-email-jh80.chung@samsung.com>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44354 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbcA2EG0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:06:26 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P029OG4QJHIC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:06:19 +0900 (KST)
In-reply-to: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

After removed the MMC_DATA_STREAM, only two flags are remained.
(MMC_DATA_READ and MMC_DATA_WRITE)
The flags of  READ and WRITE can't be used together.
That's why it doesn't need to use "OR' operation.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/card/block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5914263..e7449cb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1525,13 +1525,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	}
 	if (rq_data_dir(req) == READ) {
 		brq->cmd.opcode = readcmd;
-		brq->data.flags |= MMC_DATA_READ;
+		brq->data.flags = MMC_DATA_READ;
 		if (brq->mrq.stop)
 			brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
 					MMC_CMD_AC;
 	} else {
 		brq->cmd.opcode = writecmd;
-		brq->data.flags |= MMC_DATA_WRITE;
+		brq->data.flags = MMC_DATA_WRITE;
 		if (brq->mrq.stop)
 			brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
 					MMC_CMD_AC;
@@ -1800,7 +1800,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 
 	brq->data.blksz = 512;
 	brq->data.blocks = packed->blocks + hdr_blocks;
-	brq->data.flags |= MMC_DATA_WRITE;
+	brq->data.flags = MMC_DATA_WRITE;
 
 	brq->stop.opcode = MMC_STOP_TRANSMISSION;
 	brq->stop.arg = 0;
-- 
1.9.1

