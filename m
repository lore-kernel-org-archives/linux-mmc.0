From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 09/40] soc/tegra: pmc: Remove public pad voltage APIs
Date: Fri, 10 Aug 2018 21:08:11 +0300
Message-ID: <1533924522-1037-10-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Make tegra_io_pad_set_voltage() and tegra_io_pad_get_voltage() static
and remove the prototypes from pmc.h. Remove enum tegra_io_pad_voltage
and use the defines from <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
instead.

These functions aren't used outside of the pmc driver and new use cases
should use the pinctrl interface instead.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 17 ++++++++---------
 include/soc/tegra/pmc.h | 19 -------------------
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 3b844b0..de6832d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -45,6 +45,8 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
+
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
 #define  PMC_CNTRL_CPU_PWRREQ_OE	BIT(16) /* CPU pwr req enable */
@@ -1091,8 +1093,7 @@ static int tegra_io_pad_is_powered(enum tegra_io_pad id)
 	return !(value & mask);
 }
 
-int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-			     enum tegra_io_pad_voltage voltage)
+static int tegra_io_pad_set_voltage(enum tegra_io_pad id, int voltage)
 {
 	const struct tegra_io_pad_soc *pad;
 	u32 value;
@@ -1109,7 +1110,7 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 	if (pmc->soc->has_impl_33v_pwr) {
 		value = tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
 
-		if (voltage == TEGRA_IO_PAD_1800000UV)
+		if (voltage == TEGRA_IO_PAD_VOLTAGE_1V8)
 			value &= ~BIT(pad->voltage);
 		else
 			value |= BIT(pad->voltage);
@@ -1124,7 +1125,7 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 		/* update I/O voltage */
 		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
-		if (voltage == TEGRA_IO_PAD_1800000UV)
+		if (voltage == TEGRA_IO_PAD_VOLTAGE_1V8)
 			value &= ~BIT(pad->voltage);
 		else
 			value |= BIT(pad->voltage);
@@ -1138,9 +1139,8 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 
 	return 0;
 }
-EXPORT_SYMBOL(tegra_io_pad_set_voltage);
 
-int tegra_io_pad_get_voltage(enum tegra_io_pad id)
+static int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 {
 	const struct tegra_io_pad_soc *pad;
 	u32 value;
@@ -1158,11 +1158,10 @@ int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 		value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
 
 	if ((value & BIT(pad->voltage)) == 0)
-		return TEGRA_IO_PAD_1800000UV;
+		return TEGRA_IO_PAD_VOLTAGE_1V8;
 
-	return TEGRA_IO_PAD_3300000UV;
+	return TEGRA_IO_PAD_VOLTAGE_3V3;
 }
-EXPORT_SYMBOL(tegra_io_pad_get_voltage);
 
 /**
  * tegra_io_rail_power_on() - enable power to I/O rail
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 445aa66..5624268 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -141,16 +141,6 @@ enum tegra_io_pad {
 #define TEGRA_IO_RAIL_HDMI	TEGRA_IO_PAD_HDMI
 #define TEGRA_IO_RAIL_LVDS	TEGRA_IO_PAD_LVDS
 
-/**
- * enum tegra_io_pad_voltage - voltage level of the I/O pad's source rail
- * @TEGRA_IO_PAD_1800000UV: 1.8 V
- * @TEGRA_IO_PAD_3300000UV: 3.3 V
- */
-enum tegra_io_pad_voltage {
-	TEGRA_IO_PAD_1800000UV,
-	TEGRA_IO_PAD_3300000UV,
-};
-
 #ifdef CONFIG_SOC_TEGRA_PMC
 int tegra_powergate_is_powered(unsigned int id);
 int tegra_powergate_power_on(unsigned int id);
@@ -163,9 +153,6 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 
 int tegra_io_pad_power_enable(enum tegra_io_pad id);
 int tegra_io_pad_power_disable(enum tegra_io_pad id);
-int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-			     enum tegra_io_pad_voltage voltage);
-int tegra_io_pad_get_voltage(enum tegra_io_pad id);
 
 /* deprecated, use tegra_io_pad_power_{enable,disable}() instead */
 int tegra_io_rail_power_on(unsigned int id);
@@ -213,12 +200,6 @@ static inline int tegra_io_pad_power_disable(enum tegra_io_pad id)
 	return -ENOSYS;
 }
 
-static inline int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-					   enum tegra_io_pad_voltage voltage)
-{
-	return -ENOSYS;
-}
-
 static inline int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 {
 	return -ENOSYS;
-- 
2.7.4
