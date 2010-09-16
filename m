From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH 4/5] ARM: SAMSUNG: Add clock types into platform data
Date: Thu, 16 Sep 2010 17:37:02 +0900
Message-ID: <1284626223-18944-5-git-send-email-jeongbae.seo@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Jeongbae Seo <jeongbae.seo@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds clock types into platform data to support
external clock divider instead of internal clock divider.
It is defined that what kinds of clock type is used in machine.

Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkc210.c      |    4 ++++
 arch/arm/mach-s5pv310/mach-smdkv310.c      |    4 ++++
 arch/arm/plat-samsung/dev-hsmmc.c          |    3 +++
 arch/arm/plat-samsung/dev-hsmmc1.c         |    3 +++
 arch/arm/plat-samsung/dev-hsmmc2.c         |    3 +++
 arch/arm/plat-samsung/dev-hsmmc3.c         |    3 +++
 arch/arm/plat-samsung/include/plat/sdhci.h |    7 +++++++
 7 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index e6d789f..54947f7 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -74,6 +74,7 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -84,12 +85,14 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc1_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -100,6 +103,7 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct platform_device *smdkc210_devices[] __initdata = {
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index c52b0c7..2ec287c 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -74,6 +74,7 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -84,12 +85,14 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
@@ -100,6 +103,7 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.ext_cd_gpio		= S5PV310_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct platform_device *smdkv310_devices[] __initdata = {
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 5b8aacb..db7a65c 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -41,6 +41,7 @@ struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
@@ -73,4 +74,6 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
+	if (pd->clk_type)
+		set->clk_type = pd->clk_type;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index 9b52828..2497321 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -41,6 +41,7 @@ struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc1 = {
@@ -73,4 +74,6 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
+	if (pd->clk_type)
+		set->clk_type = pd->clk_type;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index df9e36b..f60aedb 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -42,6 +42,7 @@ struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc2 = {
@@ -74,4 +75,6 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
+	if (pd->clk_type)
+		set->clk_type = pd->clk_type;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index ca80897..ede776f 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -45,6 +45,7 @@ struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
 	.max_width	= 4,
 	.host_caps	= (MMC_CAP_4_BIT_DATA |
 			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_type	= S3C_SDHCI_CLK_DIV_INTERNAL,
 };
 
 struct platform_device s3c_device_hsmmc3 = {
@@ -77,4 +78,6 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
+	if (pd->clk_type)
+		set->clk_type = pd->clk_type;
 }
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index d92670a..85853f8 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -28,11 +28,17 @@ enum cd_types {
 	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
 };
 
+enum clk_types {
+	S3C_SDHCI_CLK_DIV_INTERNAL,	/* use mmc internal clock divider */
+	S3C_SDHCI_CLK_DIV_EXTERNAL,	/* use external clock divider */
+};
+
 /**
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @clk_type: Type of clock divider method (see clk_types enum above)
  * @ext_cd_init: Initialize external card detect subsystem. Called on
  *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
  *		 notify_func argument is a callback to the sdhci-s3c driver
@@ -59,6 +65,7 @@ struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
 	enum cd_types	cd_type;
+	enum clk_types	clk_type;
 
 	char		**clocks;	/* set of clock sources */
 
-- 
1.6.2.5
