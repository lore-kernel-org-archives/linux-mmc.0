From: <dinguyen@altera.com>
Subject: [PATCHv5 3/3] mmc: dw_mmc: Use phandle to get SDR timing values from sys-mgr
Date: Fri, 23 Aug 2013 10:44:46 -0500
Message-ID: <1377272686-13253-3-git-send-email-dinguyen@altera.com>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:48583
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754151Ab3HWPom (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 11:44:42 -0400
In-Reply-To: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update the driver to get the system manager node from a phandle. Also, the
driver can get the correct clock value from the common clock API, thus the
"altr,dw-mshc-ciu-div" binding is not needed at all.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org

v2:
- Use "altr,ciu-clk-offset" to get the correct CIU clock values to be
  set in the system manager.
---
 drivers/mmc/host/dw_mmc-socfpga.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..cfd67e1 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -24,21 +24,20 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
-#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
-#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
-	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+#define DRV_CLK_PHASE_SHIFT_SEL_MASK   0x7
 
 /* SOCFPGA implementation specific driver private data */
 struct dw_mci_socfpga_priv_data {
-	u8	ciu_div; /* card interface unit divisor */
 	u32	hs_timing; /* bitmask for CIU clock phase shift */
 	struct regmap   *sysreg; /* regmap for system manager register */
+	/* Offset for the ciu clock setting register inside the system manager.*/
+	u32     ciu_clk_offset;
 };
 
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_socfpga_priv_data *priv;
+	struct device_node *np = host->dev->of_node;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -46,9 +45,9 @@ static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 		return -ENOMEM;
 	}
 
-	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+	priv->sysreg = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr");
 	if (IS_ERR(priv->sysreg)) {
-		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
+		dev_err(host->dev, "No sysmgr phandle specified!\n");
 		return PTR_ERR(priv->sysreg);
 	}
 	host->priv = priv;
@@ -61,11 +60,8 @@ static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 
 	clk_disable_unprepare(host->ciu_clk);
-	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-		priv->hs_timing);
+	regmap_write(priv->sysreg, priv->ciu_clk_offset, priv->hs_timing);
 	clk_prepare_enable(host->ciu_clk);
-
-	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
@@ -82,20 +78,21 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
-	u32 div = 0;
+	u32 offset[3];
 	int ret;
 
-	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
-	if (ret)
-		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
-	priv->ciu_div = div;
-
 	ret = of_property_read_u32_array(np,
 			"altr,dw-mshc-sdr-timing", timing, 2);
 	if (ret)
 		return ret;
 
-	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
+	ret = of_property_read_u32_array(np, "altr,ciu-clk-offset", offset, 3);
+	if (ret)
+		return ret;
+
+	priv->ciu_clk_offset = offset[0];
+	priv->hs_timing =
+		((((timing[0]) & 0x7) << offset[2]) | (((timing[1]) & 0x7) << offset[1]));
 	return 0;
 }
 
-- 
1.7.9.5


