From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 09/11] mmc: sunxi-mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:55 +0900
Message-ID: <1454046057-32318-10-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36357 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbcA2FlF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:05 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01GRG94D5790@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:01 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 83de82b..d61c58e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -815,11 +815,6 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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

