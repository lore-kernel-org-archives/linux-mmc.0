From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/10] mmc: card: Use R1 responses for stop cmds for read requests
Date: Wed, 22 Jan 2014 16:00:21 +0100
Message-ID: <1390402824-9850-8-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:60482 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaAVPAl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:41 -0500
Received: by mail-wi0-f180.google.com with SMTP id d13so683071wiw.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:40 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

While using open ended transmission and thus ending the transfer by
sending a stop command, we shall use R1B only for writes and R1 shall
be used for reads. Previously R1B were used in both cases.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7b5424f..87cd2b0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1335,7 +1335,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	brq->data.blksz = 512;
 	brq->stop.opcode = MMC_STOP_TRANSMISSION;
 	brq->stop.arg = 0;
-	brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	brq->data.blocks = blk_rq_sectors(req);
 
 	/*
@@ -1378,9 +1377,15 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	if (rq_data_dir(req) == READ) {
 		brq->cmd.opcode = readcmd;
 		brq->data.flags |= MMC_DATA_READ;
+		if (brq->mrq.stop)
+			brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
+					MMC_CMD_AC;
 	} else {
 		brq->cmd.opcode = writecmd;
 		brq->data.flags |= MMC_DATA_WRITE;
+		if (brq->mrq.stop)
+			brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
+					MMC_CMD_AC;
 	}
 
 	if (do_rel_wr)
-- 
1.7.9.5

