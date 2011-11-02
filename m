From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/6] arm: samsung: remove all uses of clk_type member in sdhci
 platform data
Date: Thu, 03 Nov 2011 02:06:00 +0530
Message-ID: <1320266163-15292-4-git-send-email-thomas.abraham@linaro.org>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <1320266163-15292-1-git-send-email-thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, JeongHyeon Kim <jhkim-l017aS1Txqb0CLH3JO92LQ@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, Changhwan Youn <chaos.youn-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The sdhci driver is modified to be independent of clk_type member in the sdhci
platform data. Hence, all usage of clk_type in platform code is removed.

Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: JeongHyeon Kim <jhkim-l017aS1Txqb0CLH3JO92LQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Changhwan Youn <chaos.youn-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-exynos4/mach-armlex4210.c     |    3 ---
 arch/arm/mach-exynos4/mach-nuri.c           |    3 ---
 arch/arm/mach-exynos4/mach-origen.c         |    2 --
 arch/arm/mach-exynos4/mach-smdk4x12.c       |    2 --
 arch/arm/mach-exynos4/mach-smdkv310.c       |    4 ----
 arch/arm/mach-exynos4/mach-universal_c210.c |    2 --
 arch/arm/plat-samsung/devs.c                |    4 ----
 arch/arm/plat-samsung/include/plat/sdhci.h  |    7 -------
 arch/arm/plat-samsung/platformdata.c        |    2 --
 9 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index f0ca6c1..426b9d2 100644
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
index 236bbe1..4abf4e4 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -109,7 +109,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_DISABLE | MMC_CAP_ERASE),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply emmc_supplies[] = {
@@ -151,7 +150,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata = {
 	.ext_cd_gpio		= EXYNOS4_GPX3(3),	/* XEINT_27 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* WLAN */
@@ -160,7 +158,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc3_data __initdata = {
 	.host_caps		= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static void __init nuri_sdhci_init(void)
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index f80b563..47efb34 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -465,12 +465,10 @@ static struct i2c_board_info i2c0_devs[] __initdata = {
 
 static struct s3c_sdhci_platdata origen_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata origen_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* USB EHCI */
diff --git a/arch/arm/mach-exynos4/mach-smdk4x12.c b/arch/arm/mach-exynos4/mach-smdk4x12.c
index fcf2e0e..96c60df 100644
--- a/arch/arm/mach-exynos4/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos4/mach-smdk4x12.c
@@ -83,7 +83,6 @@ static struct s3c2410_uartcfg smdk4x12_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdk4x12_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -92,7 +91,6 @@ static struct s3c_sdhci_platdata smdk4x12_hsmmc2_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdk4x12_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply max8997_buck1 =
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index cec2afa..f15ae7a 100644
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
index a2a177f..ab5eeb3 100644
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
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 4ca8b57..d009ad9 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -321,7 +321,6 @@ struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
@@ -352,7 +351,6 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc1 = {
@@ -385,7 +383,6 @@ struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc2 = {
@@ -416,7 +413,6 @@ struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc3 = {
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 8daaa4d..ae23555 100644
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
 
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
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
