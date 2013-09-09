From: <dinguyen@altera.com>
Subject: [PATCH 2/3] mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
Date: Mon, 9 Sep 2013 10:33:52 -0500
Message-ID: <1378740833-4883-3-git-send-email-dinguyen@altera.com>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:4338
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753804Ab3IIPeG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 11:34:06 -0400
In-Reply-To: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Pavel Machek <pavel@denx.de>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The SDR timing registers for the SD/MMC IP block for SOCFPGA is located
in the system manager. This system manager IP block is located outside of
the SD IP block itself. Therefore, the function to set the SDR timing
register should be in the platform specific code so that the SD driver can
be autonomous of any future System Manager changes.

Also, there is no need for "altr,dw-mshc-ciu-div" as the driver can get
the value of the CIU clock from the common clock API.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/mmc/host/dw_mmc-pltfm.h   |    2 +-
 drivers/mmc/host/dw_mmc-socfpga.c |   63 ++-----------------------------------
 2 files changed, 3 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index 68e7fd2..682400f 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -16,5 +16,5 @@ extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
 extern int dw_mci_pltfm_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops dw_mci_pltfm_pmops;
-
+extern void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(void);
 #endif /* _DW_MMC_PLTFM_H_ */
diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..924a950 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -24,48 +24,14 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
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
-	struct dw_mci_socfpga_priv_data *priv;
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
-	host->priv = priv;
-
-	return 0;
-}
-
 static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 
 	clk_disable_unprepare(host->ciu_clk);
-	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-		priv->hs_timing);
+	socfpga_sysmgr_set_dwmmc_drvsel_smpsel();
 	clk_prepare_enable(host->ciu_clk);
 
-	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
@@ -73,37 +39,12 @@ static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 
-	if (priv->hs_timing & DRV_CLK_PHASE_SHIFT_SEL_MASK)
-		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
-}
-
-static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
-{
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-	struct device_node *np = host->dev->of_node;
-	u32 timing[2];
-	u32 div = 0;
-	int ret;
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
-	return 0;
+	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
 static const struct dw_mci_drv_data socfpga_drv_data = {
-	.init			= dw_mci_socfpga_priv_init,
 	.setup_clock		= dw_mci_socfpga_setup_clock,
 	.prepare_command	= dw_mci_socfpga_prepare_command,
-	.parse_dt		= dw_mci_socfpga_parse_dt,
 };
 
 static const struct of_device_id dw_mci_socfpga_match[] = {
-- 
1.7.9.5


