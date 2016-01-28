From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] mmc: dw_mmc-rockchip: remove setup_clock for rockchip
Date: Thu, 28 Jan 2016 09:30:52 +0800
Message-ID: <1453944652-16304-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:51893 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935637AbcA1Bfd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 20:35:33 -0500
In-Reply-To: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We remove setup_clock hook and combine it into
init hook to simplify the code

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc-rockchip.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d9c92f3..9934503 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -31,13 +31,6 @@ static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
 	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
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
@@ -236,6 +229,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	/* It needs this quirk on all Rockchip SoCs */
 	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
 
+	if (of_device_is_compatible(host->dev->of_node,
+				    "rockchip,rk3288-dw-mshc"))
+		host->bus_hz /= RK3288_CLKGEN_DIV;
+
 	return 0;
 }
 
@@ -249,7 +246,6 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
-	.setup_clock    = dw_mci_rk3288_setup_clock,
 	.init			= dw_mci_rockchip_init,
 };
 
-- 
2.3.7


