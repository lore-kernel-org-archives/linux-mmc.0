From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 3/6] arm: samsung: remove all uses of clk_type member in
 sdhci platform data
Date: Tue, 31 Jan 2012 23:26:13 +0530
Message-ID: <1328032576-9269-4-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32022 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2AaRvL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 12:51:11 -0500
In-reply-to: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, JeongHyeon Kim <jhkim@insignal.co.kr>, Changhwan Youn <chaos.youn@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>

The sdhci driver is modified to be independent of clk_type member in the sdhci
platform data. Hence, all usage of clk_type in platform code is removed.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: JeongHyeon Kim <jhkim@insignal.co.kr>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Changhwan Youn <chaos.youn@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-armlex4210.c     |    3 ---
 arch/arm/mach-exynos/mach-nuri.c           |    3 ---
 arch/arm/mach-exynos/mach-origen.c         |    2 --
 arch/arm/mach-exynos/mach-smdk4x12.c       |    2 --
 arch/arm/mach-exynos/mach-smdkv310.c       |    4 ----
 arch/arm/mach-exynos/mach-universal_c210.c |    2 --
 arch/arm/plat-samsung/devs.c               |    4 ----
 arch/arm/plat-samsung/include/plat/sdhci.h |    7 -------
 arch/arm/plat-samsung/platformdata.c       |    2 --
 9 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index d726fcd..a1e7007 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -77,7 +77,6 @@ static struct s3c2410_uartcfg armlex4210_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata armlex4210_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -88,13 +87,11 @@ static struct s3c_sdhci_platdata armlex4210_hsmmc2_pdata __initdata = {
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
 
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 165c876..a45b38a 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -111,7 +111,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_DISABLE | MMC_CAP_ERASE),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply emmc_supplies[] = {
@@ -153,7 +152,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata = {
 	.ext_cd_gpio		= EXYNOS4_GPX3(3),	/* XEINT_27 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* WLAN */
@@ -162,7 +160,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc3_data __initdata = {
 	.host_caps		= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static void __init nuri_sdhci_init(void)
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index e1d87b9..1159da7 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -472,12 +472,10 @@ static struct i2c_board_info i2c0_devs[] __initdata = {
 
 static struct s3c_sdhci_platdata origen_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata origen_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 /* USB EHCI */
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index d00e4f0..4be083a 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -85,7 +85,6 @@ static struct s3c2410_uartcfg smdk4x12_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdk4x12_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -94,7 +93,6 @@ static struct s3c_sdhci_platdata smdk4x12_hsmmc2_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdk4x12_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply max8997_buck1 =
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index b2c5557..de9dd6f 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -93,7 +93,6 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -104,12 +103,10 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
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
@@ -120,7 +117,6 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
-	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index dd75101..f1c83b6 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
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
index 145580a..71bc66e 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -351,7 +351,6 @@ struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
@@ -382,7 +381,6 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc1 = {
@@ -415,7 +413,6 @@ struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc2 = {
@@ -446,7 +443,6 @@ struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc3 = {
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index e00d35a..95a6e19 100644
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
@@ -67,7 +61,6 @@ struct s3c_sdhci_platdata {
 	unsigned int	host_caps;
 	unsigned int	pm_caps;
 	enum cd_types	cd_type;
-	enum clk_types	clk_type;
 
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 0f70718..dc55eb5 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -55,6 +55,4 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
 		set->host_caps |= pd->host_caps;
 	if (pd->pm_caps)
 		set->pm_caps |= pd->pm_caps;
-	if (pd->clk_type)
-		set->clk_type = pd->clk_type;
 }
-- 
1.6.6.rc2

