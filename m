From: Qing Xia <xiaqing17@hisilicon.com>
Subject: [PATCH] mmc: dw_mmc: fix card threshold control configuration
Date: Tue, 29 May 2018 18:38:55 +0800
Message-ID: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, x00270170 <xiaqing17@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

From: x00270170 <xiaqing17@hisilicon.com>

Card write threshold control is supposed to be set since controller
version 2.80a for data write in HS400 mode and data read in
HS200/HS400/SDR104 mode. However the current code returns without
configuring it in the case of data writing in HS400 mode.
Meanwhile the patch fixes that the current code goes to
'disable' when doing data reading in HS400 mode.

Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 29a1afa..3ee8f57 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
-		return;
+		host->timing != MMC_TIMING_MMC_HS400)
+		goto disable;
 
 	if (data->flags & MMC_DATA_WRITE)
 		enable = SDMMC_CARD_WR_THR_EN;
@@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104 &&
+	    host->timing != MMC_TIMING_MMC_HS400)
 		goto disable;
 
 	blksz_depth = blksz / (1 << host->data_shift);
-- 
2.8.1
