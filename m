From: <dinguyen@altera.com>
Subject: [PATCH 2/3] mmc: dw_mmc: Add support for SOCFPGA's platform specific implementation
Date: Mon, 17 Feb 2014 01:30:43 -0600
Message-ID: <1392622244-18015-2-git-send-email-dinguyen@altera.com>
References: <1392622244-18015-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bhn0126.outbound.protection.outlook.com ([157.56.111.126]:48669
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750896AbaBQHdE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Feb 2014 02:33:04 -0500
In-Reply-To: <1392622244-18015-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: dinh.linux@gmail.com, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

From: Dinh Nguyen <dinguyen@altera.com>

Like the rockchip, Altera's SOCFPGA platform specific implementation of the
dw_mmc driver requires using the HOLD register for SD commands.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 5c49656..88047cc 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -34,6 +34,10 @@ static const struct dw_mci_drv_data rockchip_drv_data = {
 	.prepare_command	= dw_mci_rockchip_prepare_command,
 };
 
+static const struct dw_mci_drv_data socfpga_drv_data = {
+	.prepare_command	= dw_mci_rockchip_prepare_command,
+};
+
 int dw_mci_pltfm_register(struct platform_device *pdev,
 			  const struct dw_mci_drv_data *drv_data)
 {
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

