From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] mmc: dw_mmc-rockchip: remove prepare_command hook
Date: Tue, 19 Jan 2016 11:52:53 +0800
Message-ID: <1453175573-13656-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:34883 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbcASD5i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 22:57:38 -0500
In-Reply-To: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch remove prepare_command hook from dw_mmc-rockchip
and use dw_mci_pltfm_prepare_command directly since it seems
it doesn't need any other work to be prepared.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d9c92f3..e6968cd 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -26,11 +26,6 @@ struct dw_mci_rockchip_priv_data {
 	int			default_sample_phase;
 };
 
-static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
 static int dw_mci_rk3288_setup_clock(struct dw_mci *host)
 {
 	host->bus_hz /= RK3288_CLKGEN_DIV;
@@ -240,12 +235,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 }
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
-	.prepare_command        = dw_mci_rockchip_prepare_command,
+	.prepare_command        = dw_mci_pltfm_prepare_command,
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-	.prepare_command        = dw_mci_rockchip_prepare_command,
+	.prepare_command        = dw_mci_pltfm_prepare_command,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
-- 
2.3.7



