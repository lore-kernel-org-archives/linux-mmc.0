From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 1/3] ARM: SAMSUNG: Add the member of platdata to implement SDMMC Write Protection
Date: Sat,  3 Jul 2010 10:00:42 +0900
Message-ID: <1278118844-21770-2-git-send-email-kgene.kim@samsung.com>
References: <1278118844-21770-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1278118844-21770-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, Hyuk Lee <hyuk1.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
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
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 5 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 4c05b39..a9e02b4 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -61,6 +61,8 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 
 	set->max_width = pd->max_width;
 
+	if (pd->wp_gpio)
+		set->wp_gpio = pd->wp_gpio;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..5c05ada 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -61,6 +61,8 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 
 	set->max_width = pd->max_width;
 
+	if (pd->wp_gpio)
+		set->wp_gpio = pd->wp_gpio;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..b724800 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -62,6 +62,8 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 
 	set->max_width = pd->max_width;
 
+	if (pd->wp_gpio)
+		set->wp_gpio = pd->wp_gpio;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 57bd394..e9b23dc 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -65,6 +65,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 
 	set->max_width = pd->max_width;
 
+	if (pd->wp_gpio)
+		set->wp_gpio = pd->wp_gpio;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 1314ffa..3491e18 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -24,6 +24,7 @@ struct mmc_ios;
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
+ * @wp_gpio: The gpio number using for WP.
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
  * @cfg_card: Configure the interface for a specific card and speed. This
  *            is necessary the controllers and/or GPIO blocks require the
@@ -37,6 +38,7 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	unsigned int	wp_gpio;
 
 	char		**clocks;	/* set of clock sources */
 
-- 
1.6.2.5
