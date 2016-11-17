From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 7/9] mmc: dw_mmc: remove the unnecessary mmc_data structure
Date: Thu, 17 Nov 2016 16:40:39 +0900
Message-ID: <20161117074041.8641-8-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53472 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbcKQHlB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:41:01 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR0271EZZVAM70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:43 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the unnecessary mmc_data structure.
Instead, cmd->data can be used.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d2fae00..40afb45 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -236,7 +236,6 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
 
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
-	struct mmc_data	*data;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	u32 cmdr;
@@ -291,10 +290,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	if (cmd->flags & MMC_RSP_CRC)
 		cmdr |= SDMMC_CMD_RESP_CRC;
 
-	data = cmd->data;
-	if (data) {
+	if (cmd->data) {
 		cmdr |= SDMMC_CMD_DAT_EXP;
-		if (data->flags & MMC_DATA_WRITE)
+		if (cmd->data->flags & MMC_DATA_WRITE)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
 
-- 
2.10.1

