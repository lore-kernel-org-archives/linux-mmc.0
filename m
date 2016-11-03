From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 08/13] mmc: dw_mmc: remove the unnecessary mmc_data structure
Date: Thu, 03 Nov 2016 15:21:30 +0900
Message-ID: <20161103062135.10697-9-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Remove the unnecessary mmc_data structure.
Instead, cmd->data can be used.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index df151c8..bd8c5ea 100644
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
