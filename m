From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
Date: Thu, 31 Mar 2016 15:34:02 +0800
Message-ID: <1459409642-20388-1-git-send-email-shawn.lin@rock-chips.com>
References: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We combine what dw_mci_exynos_setup_clock does with init
hook to simplify the code

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-exynos.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0e989eb..7e3a324 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -126,13 +126,6 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
 	}
 
-	return 0;
-}
-
-static int dw_mci_exynos_setup_clock(struct dw_mci *host)
-{
-	struct dw_mci_exynos_priv_data *priv = host->priv;
-
 	host->bus_hz /= (priv->ciu_div + 1);
 
 	return 0;
@@ -500,7 +493,6 @@ static unsigned long exynos_dwmmc_caps[4] = {
 static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
 	.init			= dw_mci_exynos_priv_init,
-	.setup_clock		= dw_mci_exynos_setup_clock,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
-- 
2.3.7
