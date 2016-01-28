From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
Date: Thu, 28 Jan 2016 09:31:11 +0800
Message-ID: <1453944671-16938-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We combine what dw_mci_exynos_setup_clock does with init
hook to simplify the code

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-exynos.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index edaa117..47d8b1d 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -115,14 +115,8 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host, bool setup_clk)
 				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
 	}
 
-	return 0;
-}
-
-static int dw_mci_exynos_setup_clock(struct dw_mci *host)
-{
-	struct dw_mci_exynos_priv_data *priv = host->priv;
-
-	host->bus_hz /= (priv->ciu_div + 1);
+	if (setup_clk)
+		host->bus_hz /= (priv->ciu_div + 1);
 
 	return 0;
 }
@@ -499,7 +493,6 @@ static unsigned long exynos_dwmmc_caps[4] = {
 static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
 	.init			= dw_mci_exynos_priv_init,
-	.setup_clock		= dw_mci_exynos_setup_clock,
 	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
-- 
2.3.7
