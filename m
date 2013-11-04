From: <dinguyen@altera.com>
Subject: [PATCHv2 3/4] mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
Date: Mon, 4 Nov 2013 14:36:04 -0600
Message-ID: <1383597364-25613-4-git-send-email-dinguyen@altera.com>
References: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:46375
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359Ab3KDUg1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 15:36:27 -0500
In-Reply-To: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The SDR timing registers for the SD/MMC IP block for SOCFPGA is located
in the system manager. This system manager IP block is located outside of
the SD IP block itself. We can use the normal clock API to set the SDR
settings.

Also, there is no need for "altr,dw-mshc-ciu-div" as the driver can get
the value of the CIU clock from the common clock API.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
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
 drivers/mmc/host/dw_mmc-socfpga.c |   80 +++++--------------------------------
 1 file changed, 10 insertions(+), 70 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..4999454 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -13,97 +13,37 @@
  * Taken from dw_mmc-exynos.c
  */
 #include <linux/clk.h>
-#include <linux/mfd/syscon.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
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
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-
-	clk_disable_unprepare(host->ciu_clk);
-	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-		priv->hs_timing);
-	clk_prepare_enable(host->ciu_clk);
-
-	host->bus_hz /= (priv->ciu_div + 1);
+	struct clk *sysmgr_clk = devm_clk_get(host->dev, "sysmgr-sdr-mmc");
+
+	if (IS_ERR(sysmgr_clk))
+		dev_err(host->dev, "sysmgr-sdr-mmc not available\n");
+	else {
+		clk_disable_unprepare(host->ciu_clk);
+		clk_prepare_enable(sysmgr_clk);
+		clk_prepare_enable(host->ciu_clk);
+	}
 	return 0;
 }
 
 static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-
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


