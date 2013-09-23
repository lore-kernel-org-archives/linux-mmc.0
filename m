From: <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 2/3] mmc: dw_mmc-socfpga: Clean up SOCFPGA platform specific functionality
Date: Mon, 23 Sep 2013 17:35:59 -0500
Message-ID: <1379975760-18084-2-git-send-email-dinguyen@altera.com>
References: <1379975760-18084-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379975760-18084-1-git-send-email-dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>

The SDR timing registers for the SD/MMC IP block for SOCFPGA is located
in the system manager. This system manager IP block is located outside of
the SD IP block itself. Therefore, the function to set the SDR timing
register should be in the platform specific code so that the SD driver can
be autonomous of any future System Manager changes.

Also, there is no need for "altr,dw-mshc-ciu-div" as the driver can get
the value of the CIU clock from the common clock API.

Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
---
v2:
- Let the mmc driver walk the DTB to get the SDR values
---
---
 drivers/mmc/host/dw_mmc-socfpga.c |   38 +++++++++----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..3be2e2a 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -24,16 +24,12 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
-#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
-#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
-	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+extern void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel);
 
 /* SOCFPGA implementation specific driver private data */
 struct dw_mci_socfpga_priv_data {
-	u8	ciu_div; /* card interface unit divisor */
-	u32	hs_timing; /* bitmask for CIU clock phase shift */
-	struct regmap   *sysreg; /* regmap for system manager register */
+	u32     drvsel; /*Phase shift for the Drive clock, or tx mode.*/
+	u32	smplsel; /*Phase shift for the Sample clock, or rx mode.*/
 };
 
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
@@ -45,14 +41,7 @@ static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 		dev_err(host->dev, "mem alloc failed for private data\n");
 		return -ENOMEM;
 	}
-
-	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-	if (IS_ERR(priv->sysreg)) {
-		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
-		return PTR_ERR(priv->sysreg);
-	}
 	host->priv = priv;
-
 	return 0;
 }
 
@@ -61,20 +50,15 @@ static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 
 	clk_disable_unprepare(host->ciu_clk);
-	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-		priv->hs_timing);
+	socfpga_sysmgr_set_dwmmc_drvsel_smpsel(priv->drvsel, priv->smplsel);
 	clk_prepare_enable(host->ciu_clk);
 
-	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
 static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
-	struct dw_mci_socfpga_priv_data *priv = host->priv;
-
-	if (priv->hs_timing & DRV_CLK_PHASE_SHIFT_SEL_MASK)
-		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
 static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
@@ -82,20 +66,16 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
-	u32 div = 0;
 	int ret;
 
-	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
-	if (ret)
-		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
-	priv->ciu_div = div;
-
 	ret = of_property_read_u32_array(np,
-			"altr,dw-mshc-sdr-timing", timing, 2);
+		"samsung,dw-mshc-sdr-timing", timing, 2);
 	if (ret)
 		return ret;
 
-	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
+	priv->drvsel = timing[0];
+	priv->smplsel = timing[1];
+
 	return 0;
 }
 
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
