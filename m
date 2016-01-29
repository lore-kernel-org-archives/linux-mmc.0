From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 04/11] mmc: dw_mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:50 +0900
Message-ID: <1454046057-32318-5-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45205 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcA2FlC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:02 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01JR394CHQ90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:00 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7128351..40fcf9e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -290,8 +290,6 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	data = cmd->data;
 	if (data) {
 		cmdr |= SDMMC_CMD_DAT_EXP;
-		if (data->flags & MMC_DATA_STREAM)
-			cmdr |= SDMMC_CMD_STRM_MODE;
 		if (data->flags & MMC_DATA_WRITE)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
-- 
1.9.1

