From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] mmc: dw_mmc-rockchip: remove setup_clock for rockchip
Date: Thu, 31 Mar 2016 15:33:53 +0800
Message-ID: <1459409633-20347-1-git-send-email-shawn.lin@rock-chips.com>
References: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459409616-20306-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We remove setup_clock hook and combine it into
init hook to simplify the code

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rebase on linux-mmc next
- remove add setup_clk flag for init callback

 drivers/mmc/host/dw_mmc-rockchip.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 84e50f3..c986f2f 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -26,13 +26,6 @@ struct dw_mci_rockchip_priv_data {
 	int			default_sample_phase;
 };
 
-static int dw_mci_rk3288_setup_clock(struct dw_mci *host)
-{
-	host->bus_hz /= RK3288_CLKGEN_DIV;
-
-	return 0;
-}
-
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
@@ -231,6 +224,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	/* It needs this quirk on all Rockchip SoCs */
 	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
 
+	if (of_device_is_compatible(host->dev->of_node,
+				    "rockchip,rk3288-dw-mshc"))
+		host->bus_hz /= RK3288_CLKGEN_DIV;
+
 	return 0;
 }
 
@@ -242,7 +239,6 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
-	.setup_clock    = dw_mci_rk3288_setup_clock,
 	.init			= dw_mci_rockchip_init,
 };
 
-- 
2.3.7
