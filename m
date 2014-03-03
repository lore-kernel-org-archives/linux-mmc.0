From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 4/7] mmc: dw_mmc: fix minor coding style.
Date: Mon, 03 Mar 2014 11:36:44 +0900
Message-ID: <5313EABC.7070200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21957 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaCCCgU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Mar 2014 21:36:20 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1U005DS9WJPK40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Mar 2014 11:36:19 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Fixed the coding style.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V4:
	- None
Changelog V3:
	- None
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9bac3ed..ac16308 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -257,9 +257,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	    (cmd->opcode == SD_IO_RW_DIRECT &&
 	     ((cmd->arg >> 9) & 0x1FFFF) == SDIO_CCCR_ABORT))
 		cmdr |= SDMMC_CMD_STOP;
-	else
-		if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
-			cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
+	else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
+		cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		/* We expect a response, so set this bit */
-- 
1.7.9.5
