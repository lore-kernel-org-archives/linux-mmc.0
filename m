From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] arm: samsung: add wakeup platdata
Date: Tue, 18 Oct 2011 17:09:28 +0900
Message-ID: <4E9D3438.9030505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, 'kgene kim' <kgene.kim@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Wonil Choi <wonil22.choi@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/plat-samsung/dev-hsmmc.c          |    1 +
 arch/arm/plat-samsung/dev-hsmmc1.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc2.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc3.c         |    1 +
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 5 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index db7a65c..f736fab 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -65,6 +65,7 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wakeup = pd->wakeup;
 
 	if (pd->max_width)
 		set->max_width = pd->max_width;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index 2497321..5456981 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -65,6 +65,7 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wakeup = pd->wakeup;
 
 	if (pd->max_width)
 		set->max_width = pd->max_width;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index f60aedb..134d4f9 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -66,6 +66,7 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wakeup = pd->wakeup;
 
 	if (pd->max_width)
 		set->max_width = pd->max_width;
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index ede776f..09c97a2 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -69,6 +69,7 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
+	set->wakeup = pd->wakeup;
 
 	if (pd->max_width)
 		set->max_width = pd->max_width;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 058e096..d945e60 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -42,6 +42,7 @@ enum clk_types {
  * @host_caps: Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
  * @clk_type: Type of clock divider method (see clk_types enum above)
+ * @wakeup: denote whether can wakeup or not during suspend.
  * @ext_cd_init: Initialize external card detect subsystem. Called on
  *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
  *		 notify_func argument is a callback to the sdhci-s3c driver
@@ -74,6 +75,7 @@ struct s3c_sdhci_platdata {
 
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
+	bool		wakeup;
 	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
 						   int state));
 	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
