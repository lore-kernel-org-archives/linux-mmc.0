From: alim akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD error
 flag
Date: Thu, 03 Oct 2013 14:48:01 +0530
Message-ID: <1380791881-31484-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42729 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab3JCJPR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2013 05:15:17 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU300HEV5NYNRC0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 03 Oct 2013 18:14:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, cjb@laptop.org, jh80.chung@samsung.com, dianders@chromium.org, Alim Akhtar <alim.akhtar@samsung.com>

From: Alim Akhtar <alim.akhtar@samsung.com>

Hardware locked error set when the dw_mmc controller cannot load a
command issued by software. When software sets the start_cmd bit in the
CMD register, the controller tries to load the command. If the command
buffer is already filled with a command, this error is raised. Currently
driver does not handle HLE interrupt, which results in a system hang.

HLE can be simulated by quickly inserting and removing sd card in card
slot (30 ~ 40 times in say 20 secs)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0a6a512..24b4a52 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -44,7 +44,7 @@
 				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
 				 SDMMC_INT_EBE)
 #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
-				 SDMMC_INT_RESP_ERR)
+				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
 #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
 				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
 #define DW_MCI_SEND_STATUS	1
-- 
1.7.12.4

