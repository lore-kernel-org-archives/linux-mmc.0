From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/12] ARM: OMAP2+: Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x EVM
Date: Thu, 14 Dec 2017 18:39:41 +0530
Message-ID: <20171214130941.26666-13-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x EVM since
UHS modes are supported only in sdhci-omap (and not in omap-hsmmc).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6b433fce65a5..92fb8828d57f 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -21,7 +21,7 @@
 #include <linux/regulator/fixed.h>
 
 #include <linux/platform_data/pinctrl-single.h>
-#include <linux/platform_data/hsmmc-omap.h>
+#include <linux/platform_data/sdhci-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/pwm_omap_dmtimer.h>
@@ -38,7 +38,7 @@
 #include "soc.h"
 #include "hsmmc.h"
 
-static struct omap_hsmmc_platform_data __maybe_unused mmc_pdata[2];
+static struct sdhci_omap_platform_data __maybe_unused mmc_pdata[2];
 
 struct pdata_init {
 	const char *compatible;
@@ -435,21 +435,21 @@ static void __init omap5_uevm_legacy_init(void)
 #endif
 
 #ifdef CONFIG_SOC_DRA7XX
-static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc1;
-static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc2;
-static struct omap_hsmmc_platform_data dra7_hsmmc_data_mmc3;
+static struct sdhci_omap_platform_data dra7_sdhci_data_mmc1;
+static struct sdhci_omap_platform_data dra7_sdhci_data_mmc2;
+static struct sdhci_omap_platform_data dra7_sdhci_data_mmc3;
 
 static void __init dra7x_evm_mmc_quirk(void)
 {
 	if (omap_rev() == DRA752_REV_ES1_1 || omap_rev() == DRA752_REV_ES1_0) {
-		dra7_hsmmc_data_mmc1.version = "rev11";
-		dra7_hsmmc_data_mmc1.max_freq = 96000000;
+		dra7_sdhci_data_mmc1.version = "rev11";
+		dra7_sdhci_data_mmc1.max_freq = 96000000;
 
-		dra7_hsmmc_data_mmc2.version = "rev11";
-		dra7_hsmmc_data_mmc2.max_freq = 48000000;
+		dra7_sdhci_data_mmc2.version = "rev11";
+		dra7_sdhci_data_mmc2.max_freq = 48000000;
 
-		dra7_hsmmc_data_mmc3.version = "rev11";
-		dra7_hsmmc_data_mmc3.max_freq = 48000000;
+		dra7_sdhci_data_mmc3.version = "rev11";
+		dra7_sdhci_data_mmc3.max_freq = 48000000;
 	}
 }
 #endif
@@ -582,12 +582,12 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 		       &omap4_iommu_pdata),
 #endif
 #ifdef CONFIG_SOC_DRA7XX
-	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x4809c000, "4809c000.mmc",
-		       &dra7_hsmmc_data_mmc1),
-	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480b4000, "480b4000.mmc",
-		       &dra7_hsmmc_data_mmc2),
-	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480ad000, "480ad000.mmc",
-		       &dra7_hsmmc_data_mmc3),
+	OF_DEV_AUXDATA("ti,dra7-sdhci", 0x4809c000, "4809c000.mmc",
+		       &dra7_sdhci_data_mmc1),
+	OF_DEV_AUXDATA("ti,dra7-sdhci", 0x480b4000, "480b4000.mmc",
+		       &dra7_sdhci_data_mmc2),
+	OF_DEV_AUXDATA("ti,dra7-sdhci", 0x480ad000, "480ad000.mmc",
+		       &dra7_sdhci_data_mmc3),
 #endif
 	/* Common auxdata */
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
-- 
2.11.0
