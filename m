From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/4] omap4: mmc: use auxdata to pass platform function ptrs
Date: Fri, 4 Nov 2011 17:20:41 +0530
Message-ID: <1320407441-29697-5-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

mmc driver still relies on platform specific functions
being invoked from the driver by means of function pointers
being passed through platform_data structure.
use the auxdata for now to pass these the same way until
we find a way to get rid of these calls from the driver.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   19 +++++++++++++++++--
 arch/arm/mach-omap2/hsmmc.c         |    9 +++++----
 arch/arm/mach-omap2/hsmmc.h         |    5 +++++
 drivers/mmc/host/omap_hsmmc.c       |    8 ++++++++
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 62c6b2e..af2fdd9 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,14 +15,29 @@
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/mmc.h>
 #include <mach/omap4-common.h>
+#include "hsmmc.h"
+
+struct omap_mmc_platform_data omap4_mmc1_pdata = {
+	.init = twl6030_mmc_card_detect_config,
+	.slots[0] = {
+		.before_set_reg = omap4_hsmmc1_before_set_reg,
+		.after_set_reg = omap4_hsmmc1_after_set_reg,
+	},
+};
 
+struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("ti,omap-hsmmc0", 0x4809c000, "omap_hsmmc.0", &omap4_mmc1_pdata),
+	{}
+};
 
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
@@ -44,8 +59,8 @@ static void __init omap_generic_init(void)
 
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-
-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	omap2_hsmmc_init(NULL);
+	of_platform_populate(NULL, omap_dt_match_table, omap_auxdata_lookup, NULL);
 }
 
 #if defined(CONFIG_SOC_OMAP2420)
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 7708584..dc698be 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -120,7 +120,7 @@ static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
+void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
 	u32 reg;
@@ -141,7 +141,7 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 	omap4_ctrl_pad_writel(reg, control_pbias_offset);
 }
 
-static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
+void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 				 int power_on, int vdd)
 {
 	u32 reg;
@@ -495,8 +495,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		omap4_ctrl_pad_writel(reg, control_mmc1);
 	}
 
-	for (; controllers->mmc; controllers++)
-		omap_init_hsmmc(controllers, controllers->mmc);
+	if (controllers)
+		for (; controllers->mmc; controllers++)
+			omap_init_hsmmc(controllers, controllers->mmc);
 
 }
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index f757e78..543ab4d 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -34,6 +34,11 @@ struct omap2_hsmmc_info {
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 void omap2_hsmmc_init(struct omap2_hsmmc_info *);
+extern void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
+				int power_on, int vdd);
+extern void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
+				int power_on, int vdd);
+
 
 #else
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 90b4a61..5fb5a95 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1953,6 +1953,7 @@ static const struct of_device_id omap_mmc_of_match[];
 static int __init omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_mmc_platform_data *aux_pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
@@ -1964,6 +1965,13 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		pdata = of_get_hsmmc_pdata(&pdev->dev);
 		if (match->data)
 			pdata->reg_offset = *(u16 *)match->data;
+		if (aux_pdata) {
+			pdata->init = aux_pdata->init;
+			pdata->slots[0].before_set_reg =
+				 aux_pdata->slots[0].before_set_reg;
+			pdata->slots[0].after_set_reg =
+				 aux_pdata->slots[0].after_set_reg;
+		}
 	}
 
 	if (pdata == NULL) {
-- 
1.7.1

