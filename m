From: <dinguyen@altera.com>
Subject: [RESEND LIST PATCHv7 3/4] mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
Date: Mon, 16 Dec 2013 11:04:35 -0600
Message-ID: <1387213476-22122-4-git-send-email-dinguyen@altera.com>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:11487
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754536Ab3LPRGg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 12:06:36 -0500
In-Reply-To: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

It turns now that the only really platform specific code that is needed for
SOCFPGA is using the SDMMC_CMD_USE_HOLD_REG in the prepare_command function.
Since the Rockchip already has this functionality, re-use the code that is
already in dw_mmc-pltfm.c.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v7: none
v6: none
v5: none
v4: Remove dw_mmc-socfpga platform specific code
v3: none
v2: none
---
 drivers/mmc/host/Kconfig          |    8 ---
 drivers/mmc/host/dw_mmc-socfpga.c |  138 -------------------------------------
 2 files changed, 146 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..6737a4f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -567,14 +567,6 @@ config MMC_DW_EXYNOS
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on Exynos4 and Exynos5 SoC's.
 
-config MMC_DW_SOCFPGA
-	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && MFD_SYSCON
-	select MMC_DW_PLTFM
-	help
-	  This selects support for Altera SoCFPGA specific extensions to the
-	  Synopsys DesignWare Memory Card Interface driver.
-
 config MMC_DW_PCI
 	tristate "Synopsys Designware MCI support on PCI bus"
 	depends on MMC_DW && PCI
diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
deleted file mode 100644
index 3e8e53a..0000000
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * Altera SoCFPGA Specific Extensions for Synopsys DW Multimedia Card Interface
- * driver
- *
- *  Copyright (C) 2012, Samsung Electronics Co., Ltd.
- *  Copyright (C) 2013 Altera Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Taken from dw_mmc-exynos.c
- */
-#include <linux/clk.h>
-#include <linux/mfd/syscon.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/dw_mmc.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-
-#include "dw_mmc.h"
-#include "dw_mmc-pltfm.h"
-
-#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
-#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
-#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
-	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
-
-/* SOCFPGA implementation specific driver private data */
-struct dw_mci_socfpga_priv_data {
-	u8	ciu_div; /* card interface unit divisor */
-	u32	hs_timing; /* bitmask for CIU clock phase shift */
-	struct regmap   *sysreg; /* regmap for system manager register */
-};
-
-static int dw_mci_socfpga_priv_init(struct dw_mci *host)
-{
-	return 0;
-}
-
-static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
-{
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-
-	clk_disable_unprepare(host->ciu_clk);
-	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-		priv->hs_timing);
-	clk_prepare_enable(host->ciu_clk);
-
-	host->bus_hz /= (priv->ciu_div + 1);
-	return 0;
-}
-
-static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
-{
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-
-	if (priv->hs_timing & DRV_CLK_PHASE_SHIFT_SEL_MASK)
-		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
-static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
-{
-	struct dw_mci_socfpga_priv_data *priv;
-	struct device_node *np = host->dev->of_node;
-	u32 timing[2];
-	u32 div = 0;
-	int ret;
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(host->dev, "mem alloc failed for private data\n");
-		return -ENOMEM;
-	}
-
-	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-	if (IS_ERR(priv->sysreg)) {
-		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
-		return PTR_ERR(priv->sysreg);
-	}
-
-	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
-	if (ret)
-		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
-	priv->ciu_div = div;
-
-	ret = of_property_read_u32_array(np,
-			"altr,dw-mshc-sdr-timing", timing, 2);
-	if (ret)
-		return ret;
-
-	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
-	host->priv = priv;
-	return 0;
-}
-
-static const struct dw_mci_drv_data socfpga_drv_data = {
-	.init			= dw_mci_socfpga_priv_init,
-	.setup_clock		= dw_mci_socfpga_setup_clock,
-	.prepare_command	= dw_mci_socfpga_prepare_command,
-	.parse_dt		= dw_mci_socfpga_parse_dt,
-};
-
-static const struct of_device_id dw_mci_socfpga_match[] = {
-	{ .compatible = "altr,socfpga-dw-mshc",
-			.data = &socfpga_drv_data, },
-	{},
-};
-MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
-
-static int dw_mci_socfpga_probe(struct platform_device *pdev)
-{
-	const struct dw_mci_drv_data *drv_data;
-	const struct of_device_id *match;
-
-	match = of_match_node(dw_mci_socfpga_match, pdev->dev.of_node);
-	drv_data = match->data;
-	return dw_mci_pltfm_register(pdev, drv_data);
-}
-
-static struct platform_driver dw_mci_socfpga_pltfm_driver = {
-	.probe		= dw_mci_socfpga_probe,
-	.remove		= __exit_p(dw_mci_pltfm_remove),
-	.driver		= {
-		.name		= "dwmmc_socfpga",
-		.of_match_table	= dw_mci_socfpga_match,
-		.pm		= &dw_mci_pltfm_pmops,
-	},
-};
-
-module_platform_driver(dw_mci_socfpga_pltfm_driver);
-
-MODULE_DESCRIPTION("Altera SOCFPGA Specific DW-MSHC Driver Extension");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:dwmmc-socfpga");
-- 
1.7.9.5


