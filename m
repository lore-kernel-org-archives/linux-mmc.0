From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Date: Tue, 12 Jun 2012 22:56:09 +0200
Message-ID: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54225 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab2FLU4F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 16:56:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org

The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
command flags, and reject SD_IO_SEND_OP_COND only.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

Not supporting the MMC_SLEEP_AWAKE command makes system suspend fail if an MMC
or eMMC device supporting sleep/wake is connected. The issue has been first
noticed on the Armadillo 800 EVA board.

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 724b35e..e32da11 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -892,21 +892,15 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	switch (mrq->cmd->opcode) {
 	/* MMCIF does not support SD/SDIO command */
-	case SD_IO_SEND_OP_COND:
+	case MMC_SLEEP_AWAKE: /* = SD_IO_SEND_OP_COND (5) */
+	case MMC_SEND_EXT_CSD: /* = SD_SEND_IF_COND (8) */
+		if ((mrq->cmd->flags & MMC_CMD_MASK) != MMC_CMD_BCR)
+			break;
 	case MMC_APP_CMD:
 		host->state = STATE_IDLE;
 		mrq->cmd->error = -ETIMEDOUT;
 		mmc_request_done(mmc, mrq);
 		return;
-	case MMC_SEND_EXT_CSD: /* = SD_SEND_IF_COND (8) */
-		if (!mrq->data) {
-			/* send_if_cond cmd (not support) */
-			host->state = STATE_IDLE;
-			mrq->cmd->error = -ETIMEDOUT;
-			mmc_request_done(mmc, mrq);
-			return;
-		}
-		break;
 	default:
 		break;
 	}
-- 
Regards,

Laurent Pinchart

