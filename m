From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
Date: Wed, 21 Sep 2011 13:33:38 -0600
Message-ID: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This centralizes all GPIO naming in one header.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
This patch series relies on various previous changes to the Tegra GPIO
driver that were made in Russell's GPIO tree. I assume this series will
go in through that tree.

This first patch is cleanup which makes the second slightly cleaner (no
need to edit board-harmony-pcie.c in patch 2). Usually, it would go in
through the Tegra tree, but I think it makes sense to merge these 3
patches all together in one place.

 arch/arm/mach-tegra/board-harmony-pcie.c |   10 ++++------
 arch/arm/mach-tegra/board-harmony.h      |    1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index 9c27b95..6db7d69 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -24,12 +24,10 @@
 
 #include <mach/pinmux.h>
 #include "board.h"
+#include "board-harmony.h"
 
 #ifdef CONFIG_TEGRA_PCI
 
-/* GPIO 3 of the PMIC */
-#define EN_VDD_1V05_GPIO	(TEGRA_NR_GPIOS + 2)
-
 static int __init harmony_pcie_init(void)
 {
 	struct regulator *regulator = NULL;
@@ -38,11 +36,11 @@ static int __init harmony_pcie_init(void)
 	if (!machine_is_harmony())
 		return 0;
 
-	err = gpio_request(EN_VDD_1V05_GPIO, "EN_VDD_1V05");
+	err = gpio_request(TEGRA_GPIO_EN_VDD_1V05_GPIO, "EN_VDD_1V05");
 	if (err)
 		return err;
 
-	gpio_direction_output(EN_VDD_1V05_GPIO, 1);
+	gpio_direction_output(TEGRA_GPIO_EN_VDD_1V05_GPIO, 1);
 
 	regulator = regulator_get(NULL, "pex_clk");
 	if (IS_ERR_OR_NULL(regulator))
@@ -68,7 +66,7 @@ err_pcie:
 	regulator_disable(regulator);
 	regulator_put(regulator);
 err_reg:
-	gpio_free(EN_VDD_1V05_GPIO);
+	gpio_free(TEGRA_GPIO_EN_VDD_1V05_GPIO);
 
 	return err;
 }
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index d85142e..280d203 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -31,6 +31,7 @@
 #define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PW2
 #define TEGRA_GPIO_INT_MIC_EN		TEGRA_GPIO_PX0
 #define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
+#define TEGRA_GPIO_EN_VDD_1V05_GPIO	HARMONY_GPIO_TPS6586X(2)
 
 void harmony_pinmux_init(void);
 int harmony_regulator_init(void);
-- 
1.7.0.4
