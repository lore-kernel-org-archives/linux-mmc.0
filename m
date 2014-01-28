From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 5/8] mmc: dw-mmc: fix minor coding style.
Date: Tue, 28 Jan 2014 17:24:56 +0900
Message-ID: <52E76958.8090901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48734 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaA1IY1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:24:27 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0300MH5RCPOHA0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 17:24:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

Fixed the coding style.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fed82da..2cdfccb 100644
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
