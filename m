From: <dinguyen@altera.com>
Subject: [PATCHv3 2/3] mmc: dw_mmc: Add support for SOCFPGA's platform specific implementation
Date: Mon, 17 Feb 2014 20:31:01 -0600
Message-ID: <1392690662-19106-2-git-send-email-dinguyen@altera.com>
References: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0127.outbound.protection.outlook.com ([65.55.169.127]:3843
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752226AbaBRCd1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Feb 2014 21:33:27 -0500
In-Reply-To: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: dinh.linux@gmail.com, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

From: Dinh Nguyen <dinguyen@altera.com>

Like the rockchip, Altera's SOCFPGA platform specific implementation of the
dw_mmc driver requires using the HOLD register for SD commands. This patch
renames dw_mci_rockchip_prepare_command to dw_mci_pltfm_prepare_command so
that SOCFPGA and Rockchip can use it.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>
---
v3: Renamed dw_mci_rockchip_prepare_command to
    dw_mci_pltfm_prepare_command
v2: Use dw_mci_socfpga_prepare_command instead of
    dw_mci_rockchip_prepare_command
---
 drivers/mmc/host/dw_mmc-pltfm.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 5c49656..3263327 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -25,13 +25,17 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
+static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
 	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
 static const struct dw_mci_drv_data rockchip_drv_data = {
-	.prepare_command	= dw_mci_rockchip_prepare_command,
+	.prepare_command	= dw_mci_pltfm_prepare_command,
+};
+
+static const struct dw_mci_drv_data socfpga_drv_data = {
+	.prepare_command	= dw_mci_pltfm_prepare_command,
 };
 
 int dw_mci_pltfm_register(struct platform_device *pdev,
@@ -92,6 +96,8 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
 	{ .compatible = "rockchip,rk2928-dw-mshc",
 		.data = &rockchip_drv_data },
+	{ .compatible = "altr,socfpga-dw-mshc",
+		.data = &socfpga_drv_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
-- 
1.7.9.5

