From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] mmc: dw_mmc-exynos: wrapper prepare_command
Date: Tue, 19 Jan 2016 11:53:06 +0800
Message-ID: <1453175586-13697-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch use dw_mci_pltfm_prepare_command call to
change cmdr instead of doing it in the driver itself.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3a7e835..37a337e 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -215,10 +215,10 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
 		if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL64)))
-			*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+			dw_mci_pltfm_prepare_command(host, cmdr);
 	 } else {
 		if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
-			*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+			dw_mci_pltfm_prepare_command(host, cmdr);
 	}
 }
 
-- 
2.3.7
