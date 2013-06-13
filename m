From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v4 3/3] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Thu, 13 Jun 2013 10:58:22 +0200
Message-ID: <201306131058.23150.heiko@sntech.de>
References: <201306131055.49595.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43292 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756298Ab3FMI6Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 04:58:25 -0400
In-Reply-To: <201306131055.49595.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
always be set.

There also seem to be no other modifications (additional register etc)
present, so to keep the footprint low, add this small variant to the
pltfm driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
depends on "mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA"
 from Dinh Nguyen

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   23 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c                    |   21 +++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
new file mode 100644
index 0000000..8a3d91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -0,0 +1,23 @@
+* Rockchip specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+The Synopsis designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsis dw mshc controller properties described
+by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
+extensions to the Synopsis Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following
+
+Example:
+
+	rkdwmmc0@12200000 {
+		compatible = "rockchip,rk2928-dw-mshc";
+		reg = <0x12200000 0x1000>;
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9b05381..3923ffd 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -24,6 +24,15 @@
 
 #include "dw_mmc.h"
 
+static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
+{
+	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+}
+
+static const struct dw_mci_drv_data rockchip_drv_data = {
+	.prepare_command	= dw_mci_rockchip_prepare_command,
+};
+
 int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data)
 {
@@ -100,13 +109,23 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
+	{ .compatible = "rockchip,rk2928-dw-mshc",
+		.data = &rockchip_drv_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
 static int dw_mci_pltfm_probe(struct platform_device *pdev)
 {
-	return dw_mci_pltfm_register(pdev, NULL);
+	const struct dw_mci_drv_data *drv_data = NULL;
+	const struct of_device_id *match;
+
+	if (pdev->dev.of_node) {
+		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
+		drv_data = match->data;
+	}
+
+	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
 int dw_mci_pltfm_remove(struct platform_device *pdev)
-- 
1.7.10.4

