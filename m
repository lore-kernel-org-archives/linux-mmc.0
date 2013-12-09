From: <dinguyen@altera.com>
Subject: [PATCHv3 2/3] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
Date: Sun, 8 Dec 2013 22:51:07 -0600
Message-ID: <1386564668-24738-3-git-send-email-dinguyen@altera.com>
References: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.27] ([207.46.163.27]:34704 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760538Ab3LIEyM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Dec 2013 23:54:12 -0500
In-Reply-To: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Rockchip's implementation of the dw_mmc controller only requires the setting
of the SDMMC_CMD_USE_HOLD_REG on every command. With the patch to set the
SDMMC_CMD_USE_HOLD_REG by checking the slot's speed mode, this Rockchip
custom driver structure is no longer necessary.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
v3: none
v2: none
---
 drivers/mmc/host/dw_mmc-pltfm.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 5c49656..8f15d05 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -25,15 +25,6 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
-static const struct dw_mci_drv_data rockchip_drv_data = {
-	.prepare_command	= dw_mci_rockchip_prepare_command,
-};
-
 int dw_mci_pltfm_register(struct platform_device *pdev,
 			  const struct dw_mci_drv_data *drv_data)
 {
@@ -90,8 +81,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
-	{ .compatible = "rockchip,rk2928-dw-mshc",
-		.data = &rockchip_drv_data },
+	{ .compatible = "rockchip,rk2928-dw-mshc", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
-- 
1.7.9.5


