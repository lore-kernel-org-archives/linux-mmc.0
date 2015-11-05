From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Remove MMC_CAP_RUNTIME_RESUME as it's redundant
Date: Thu,  5 Nov 2015 16:01:33 +0100
Message-ID: <1446735693-11542-2-git-send-email-ulf.hansson@linaro.org>
References: <1446735693-11542-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1446735693-11542-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, addy ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 8 --------
 drivers/mmc/host/mtk-sd.c          | 1 -
 include/linux/mmc/host.h           | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 9becebe..d9c92f3 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -239,20 +239,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	return 0;
 }
 
-/* Common capabilities of RK3288 SoC */
-static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
-	MMC_CAP_RUNTIME_RESUME, /* emmc */
-	MMC_CAP_RUNTIME_RESUME, /* sdmmc */
-	MMC_CAP_RUNTIME_RESUME, /* sdio0 */
-	MMC_CAP_RUNTIME_RESUME, /* sdio1 */
-};
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-	.caps			= dw_mci_rk3288_dwmmc_caps,
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 39568cc..15fcf2d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1543,7 +1543,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc->f_min = host->src_clk_freq / (4 * 255);
 
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
-	mmc->caps |= MMC_CAP_RUNTIME_RESUME;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
 	mmc->max_seg_size = BDMA_DESC_BUFLEN;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe..9b04e71 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -259,7 +259,6 @@ struct mmc_host {
 #define MMC_CAP_UHS_SDR50	(1 << 17)	/* Host supports UHS SDR50 mode */
 #define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
 #define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
-#define MMC_CAP_RUNTIME_RESUME	(1 << 20)	/* Resume at runtime_resume. */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
1.9.1

