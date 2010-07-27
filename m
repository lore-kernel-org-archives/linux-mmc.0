From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v4 1/3] ARM: SAMSUNG: Add the member of platdata to implement SDMMC Write Protection
Date: Tue, 27 Jul 2010 21:43:46 +0900
Message-ID: <1280234628-27303-2-git-send-email-kgene.kim@samsung.com>
References: <1280234628-27303-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1280234628-27303-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds the members of platdata which is wp_gpio.
The wp_gpio is a gpio_number which is connected with WP pin of SD Slot.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/dev-hsmmc.c          |    2 ++
 arch/arm/plat-samsung/dev-hsmmc1.c         |    2 ++
 arch/arm/plat-samsung/dev-hsmmc2.c         |    2 ++
 arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
 arch/arm/plat-samsung/include/plat/sdhci.h |    4 ++++
 5 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index b0f93f1..ce06aa6 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -65,6 +65,8 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
+	set->has_wp_gpio = pd->has_wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index 1504fd8..d2d9f72 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -65,6 +65,8 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
+	set->has_wp_gpio = pd->has_wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index b28ef17..34b1ccd 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -66,6 +66,8 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
+	set->has_wp_gpio = pd->has_wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 85aaf0f..9b88c99 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -69,6 +69,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wp_gpio = pd->wp_gpio;
+	set->has_wp_gpio = pd->has_wp_gpio;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 7c21a7c..cbf05c6 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -33,6 +33,8 @@ enum cd_types {
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @wp_gpio: The gpio number using for WP.
+ * @has_wp_gpio: Check using wp_gpio or not.
  * @ext_cd_init: Initialize external card detect subsystem. Called on
  *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
  *		 notify_func argument is a callback to the sdhci-s3c driver
@@ -62,8 +64,10 @@ struct s3c_sdhci_platdata {
 
 	char		**clocks;	/* set of clock sources */
 
+	int		wp_gpio;
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
+	bool		has_wp_gpio;
 	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
 						   int state));
 	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
-- 
1.6.2.5
