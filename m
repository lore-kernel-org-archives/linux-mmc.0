From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH 3/5] ARM: SAMSUNG: Modified to change of bus width and host caps
Date: Thu, 16 Sep 2010 17:37:01 +0900
Message-ID: <1284626223-18944-4-git-send-email-jeongbae.seo@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, Jeongbae Seo <jeongbae.seo@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds to change bus width and host capability of HSMMC,
when HSMMC is only configured with another value of bus width
and host capability from default one.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
---
 arch/arm/plat-samsung/dev-hsmmc.c  |    5 +++--
 arch/arm/plat-samsung/dev-hsmmc1.c |    5 +++--
 arch/arm/plat-samsung/dev-hsmmc2.c |    5 +++--
 arch/arm/plat-samsung/dev-hsmmc3.c |    5 ++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 9d2be09..5b8aacb 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -59,17 +59,18 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 {
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;
 
-	set->max_width = pd->max_width;
 	set->cd_type = pd->cd_type;
 	set->ext_cd_init = pd->ext_cd_init;
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
+	if (pd->max_width)
+		set->max_width = pd->max_width;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
-		set->host_caps = pd->host_caps;
+		set->host_caps |= pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index a6c8295..9b52828 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -59,17 +59,18 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 {
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;
 
-	set->max_width = pd->max_width;
 	set->cd_type = pd->cd_type;
 	set->ext_cd_init = pd->ext_cd_init;
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
+	if (pd->max_width)
+		set->max_width = pd->max_width;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
-		set->host_caps = pd->host_caps;
+		set->host_caps |= pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index cb0d714..df9e36b 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -60,17 +60,18 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 {
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
 
-	set->max_width = pd->max_width;
 	set->cd_type = pd->cd_type;
 	set->ext_cd_init = pd->ext_cd_init;
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
+	if (pd->max_width)
+		set->max_width = pd->max_width;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
-		set->host_caps = pd->host_caps;
+		set->host_caps |= pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
index 335bc35..ca80897 100644
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -63,15 +63,18 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 {
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc3_def_platdata;
 
-	set->max_width = pd->max_width;
 	set->cd_type = pd->cd_type;
 	set->ext_cd_init = pd->ext_cd_init;
 	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 	set->ext_cd_gpio = pd->ext_cd_gpio;
 	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
+	if (pd->max_width)
+		set->max_width = pd->max_width;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps |= pd->host_caps;
 }
-- 
1.6.2.5
