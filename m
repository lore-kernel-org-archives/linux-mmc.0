From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 3/3] arm: samsung: remove all uses of clk_type member in sdhci
 platform data
Date: Tue, 04 Oct 2011 12:58:35 +0530
Message-ID: <1317713315-5830-4-git-send-email-thomas.abraham@linaro.org>
References: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, Kyungmin Park <kyungmin.park@samsung.com>, JeongHyeon Kim <jhkim@insignal.co.kr>, Changhwan Youn <chaos.youn@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The sdhci driver is modified to be independent of clk_type member in the sdhci
platform data. Hence, all usage of clk_type in platform code is removed.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: JeongHyeon Kim <jhkim@insignal.co.kr>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Changhwan Youn <chaos.youn@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/mach-armlex4210.c     |    3 ---
 arch/arm/mach-exynos4/mach-nuri.c           |    3 ---
 arch/arm/mach-exynos4/mach-origen.c         |    2 --
 arch/arm/mach-exynos4/mach-smdk4212.c       |    2 --
 arch/arm/mach-exynos4/mach-smdkv310.c       |    4 ----
 arch/arm/mach-exynos4/mach-universal_c210.c |    2 --
 arch/arm/plat-samsung/dev-hsmmc.c           |    1 -
 arch/arm/plat-samsung/dev-hsmmc1.c          |    1 -
 arch/arm/plat-samsung/dev-hsmmc2.c          |    1 -
 arch/arm/plat-samsung/dev-hsmmc3.c          |    1 -
 arch/arm/plat-samsung/include/plat/sdhci.h  |    7 -------
 arch/arm/plat-samsung/platformdata.c        |    2 --
 12 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index b482c62..8bb2c48 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -75,7 +75,6 @@ static struct s3c2410_uartcfg armlex4210_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata armlex4210_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -86,13 +85,11 @@ static struct s3c_sdhci_platdata armlex4210_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= EXYNOS4_GPX2(5),
 	.ext_cd_gpio_invert	= 1,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 	.max_width		= 4,
 };
 
 static struct s3c_sdhci_platdata armlex4210_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 	.max_width		= 4,
 };
 
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index bbd13f4..00b4b6f 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -101,7 +101,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_DISABLE | MMC_CAP_ERASE),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply emmc_supplies[] = {
@@ -143,7 +142,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata = {
 	.ext_cd_gpio		= EXYNOS4_GPX3(3),	/* XEINT_27 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* WLAN */
@@ -152,7 +150,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc3_data __initdata = {
 	.host_caps		= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static void __init nuri_sdhci_init(void)
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index 421294b..82dfdc3 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -80,12 +80,10 @@ static struct s3c2410_uartcfg origen_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata origen_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata origen_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* USB EHCI */
diff --git a/arch/arm/mach-exynos4/mach-smdk4212.c b/arch/arm/mach-exynos4/mach-smdk4212.c
index 8c41ae1..b460652 100644
--- a/arch/arm/mach-exynos4/mach-smdk4212.c
+++ b/arch/arm/mach-exynos4/mach-smdk4212.c
@@ -83,7 +83,6 @@ static struct s3c2410_uartcfg smdk4212_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdk4212_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -92,7 +91,6 @@ static struct s3c_sdhci_platdata smdk4212_hsmmc2_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdk4212_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply max8997_buck1 =
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index c74b2db..31a64d8 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -90,7 +90,6 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -101,12 +100,10 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= EXYNOS4_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -117,7 +114,6 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 18cf5c7..0556feb 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -737,7 +737,6 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_DISABLE),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply mmc0_supplies[] = {
@@ -778,7 +777,6 @@ static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
 	.ext_cd_gpio		= EXYNOS4_GPX3(4),      /* XEINT_28 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* WiFi */
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 06825c4..ea0291f 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -41,7 +41,6 @@ struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index 4524ef4..56dbe7a 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -41,7 +41,6 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc1 = {
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 9cede96..916e11b 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -42,7 +42,6 @@ struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc2 = {
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 0358ef4..8f06670 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -45,7 +45,6 @@ struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc3 = {
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 8f9a7d7..39a70ec 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -33,17 +33,11 @@ enum cd_types {
 	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
 };
 
-enum clk_types {
-	S3C_SDHCI_CLK_DIV_INTERNAL,	/* use mmc internal clock divider */
-	S3C_SDHCI_CLK_DIV_EXTERNAL,	/* use external clock divider */
-};
-
 /**
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
- * @clk_type: Type of clock divider method (see clk_types enum above)
  * @ext_cd_init: Initialize external card detect subsystem. Called on
  *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
  *		 notify_func argument is a callback to the sdhci-s3c driver
@@ -66,7 +60,6 @@ struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
 	enum cd_types	cd_type;
-	enum clk_types	clk_type;
 
 	char		**clocks;	/* set of clock sources */
 
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 4c9a207..88c5e7c 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -52,6 +52,4 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
-	if (pd->clk_type)
-		set->clk_type = pd->clk_type;
 }
-- 
1.6.6.rc2
