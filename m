From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] ARM: SAMSUNG: change the name from s3c-sdhci to exynos4-sdhci
Date: Thu, 23 Feb 2012 14:48:51 +0900
Message-ID: <4F45D343.6020409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, 'kgene kim' <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, thomas.abraham@linaro.org
List-Id: linux-mmc@vger.kernel.org

Thomas Arbrahams's patchset have changed the device name in sdhci-s3c.c
(mmc: sdhci-s3c: Rework platform data and add device tree support)
But didn't change the regulator_consumer name.
So maybe didn't initialize the mmc/sd card for exynos4.

This patch is fixed that (based-on linux-samsung for-next branch)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c           |    4 ++--
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index a6b9162..251dd7a 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -116,7 +116,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 };
 
 static struct regulator_consumer_supply emmc_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
+	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
 	REGULATOR_SUPPLY("vmmc", "dw_mmc"),
 };
 
@@ -415,7 +415,7 @@ static struct regulator_consumer_supply __initdata max8997_ldo12_[] = {
 	REGULATOR_SUPPLY("vddio", "6-003c"), /* HDC802 */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo13_[] = {
-	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"), /* TFLASH */
+	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.2"), /* TFLASH */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo14_[] = {
 	REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 6017a21..320cb1d 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -749,7 +749,7 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
 };
 
 static struct regulator_consumer_supply mmc0_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
+	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
 };
 
 static struct regulator_init_data mmc0_fixed_voltage_init_data = {
