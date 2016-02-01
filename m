From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 09/11] mmc: sunxi-mmc: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:34 +0900
Message-ID: <1454328456-22918-10-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcBAMHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:45 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V02S8TB0QP400@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 765dfb9..05c1f81 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -860,11 +860,6 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC) {
 			cmd_val |= SDXC_DATA_EXPIRE | SDXC_WAIT_PRE_OVER;
-			if (cmd->data->flags & MMC_DATA_STREAM) {
-				imask |= SDXC_AUTO_COMMAND_DONE;
-				cmd_val |= SDXC_SEQUENCE_MODE |
-					   SDXC_SEND_AUTO_STOP;
-			}
 
 			if (cmd->data->stop) {
 				imask |= SDXC_AUTO_COMMAND_DONE;
-- 
1.9.1

