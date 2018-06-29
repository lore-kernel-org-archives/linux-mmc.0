From: "Huanlin.Ke" <chgokhl@gmail.com>
Subject: [PATCH] mmc: dw_mmc: fix errors to use card read/write threshold for HS400 mode
Date: Fri, 29 Jun 2018 21:59:29 +0800
Message-ID: <1530280769-14114-1-git-send-email-kehuanlin@pinecone.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kehuanlin@pinecone.net, zhangbo_a <zhangbo_a@xiaomi.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO
        DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

The card write threshold is applicable for HS400 mode only, so it should
return back except HS400 timing mode.

The card read threshold is also required for HS400 mode as the host
controller incorrectly samples the data if the card clock stops within
a block transfer.

Signed-off-by: Huanlin.Ke <kehuanlin@pinecone.net>
Signed-off-by: zhangbo_a <zhangbo_a@xiaomi.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 623f4d2..d4e6983 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1065,7 +1065,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
+		(host->timing != MMC_TIMING_MMC_HS400))
 		return;
 
 	if (data->flags & MMC_DATA_WRITE)
@@ -1074,6 +1074,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
+	    host->timing != MMC_TIMING_MMC_HS400 &&
 	    host->timing != MMC_TIMING_UHS_SDR104)
 		goto disable;
 
-- 
2.7.4
