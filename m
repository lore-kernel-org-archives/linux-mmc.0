From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: fix failing to mount partition with "discard"
Date: Tue,  1 Mar 2016 15:12:53 +0800
Message-ID: <1456816373-32518-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Without MMC_CAP_ERASE support, we fail to mount partition
with "discard" option since mmc_queue_setup_discard is limited
for checking mmc_can_erase. Without doing mmc_queue_setup_discard,
blk_queue_discard fails to test QUEUE_FLAG_DISCARD flag, so we get
the following log from f2fs(actually similar to other file system):

mounting with "discard" option, but the device does not support discard

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 84e50f3..2eda118 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -234,11 +234,20 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	return 0;
 }
 
+/* Common capabilities of RK3288 SoC */
+static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
+	MMC_CAP_ERASE,
+	MMC_CAP_ERASE,
+	MMC_CAP_ERASE,
+	MMC_CAP_ERASE,
+};
+
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
+	.caps			= dw_mci_rk3288_dwmmc_caps,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
-- 
2.3.7
