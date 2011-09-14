From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 2/2] arm: samsung: remove sdhci default configuration setup
 platform helper
Date: Wed, 14 Sep 2011 12:39:18 +0530
Message-ID: <1315984158-29651-3-git-send-email-thomas.abraham@linaro.org>
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
 <1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

The sdhci platform helper function that sets up the default controller
configuration is removed for all Samsung platforms since such default
controller configuration can be handled by the driver.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/setup-sdhci.c        |   47 -----------------------
 arch/arm/mach-s3c2416/setup-sdhci.c        |   37 ------------------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   48 -----------------------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   42 --------------------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   41 --------------------
 arch/arm/plat-samsung/include/plat/sdhci.h |   57 ----------------------------
 arch/arm/plat-samsung/platformdata.c       |    2 -
 7 files changed, 0 insertions(+), 274 deletions(-)

diff --git a/arch/arm/mach-exynos4/setup-sdhci.c b/arch/arm/mach-exynos4/setup-sdhci.c
index 1e83f8c..92937b4 100644
--- a/arch/arm/mach-exynos4/setup-sdhci.c
+++ b/arch/arm/mach-exynos4/setup-sdhci.c
@@ -10,16 +10,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
@@ -29,41 +20,3 @@ char *exynos4_hsmmc_clksrcs[4] = {
 	[2] = "sclk_mmc",	/* mmc_bus */
 	[3] = NULL,
 };
-
-void exynos4_setup_sdhci_cfg_card(struct platform_device *dev, void __iomem *r,
-				  struct mmc_ios *ios, struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	/* don't need to alter anything according to card-type */
-
-	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
-
-	/* select base clock source to HCLK */
-
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-
-	/*
-	 * clear async mode, enable conflict mask, rx feedback ctrl, SD
-	 * clk hold and no use debounce count
-	 */
-
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	/* Tx and Rx feedback clock delay control */
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
diff --git a/arch/arm/mach-s3c2416/setup-sdhci.c b/arch/arm/mach-s3c2416/setup-sdhci.c
index ed34fad..cee5395 100644
--- a/arch/arm/mach-s3c2416/setup-sdhci.c
+++ b/arch/arm/mach-s3c2416/setup-sdhci.c
@@ -12,17 +12,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
@@ -32,30 +22,3 @@ char *s3c2416_hsmmc_clksrcs[4] = {
 	[2] = "hsmmc-if",
 	/* [3] = "48m", - note not successfully used yet */
 };
-
-void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
-				  void __iomem *r,
-				  struct mmc_ios *ios,
-				  struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	ctrl2 = __raw_readl(r + S3C_SDHCI_CONTROL2);
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	__raw_writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	__raw_writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci.c
index f344a22..c75a71b 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci.c
@@ -12,17 +12,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
@@ -32,41 +22,3 @@ char *s3c64xx_hsmmc_clksrcs[4] = {
 	[2] = "mmc_bus",
 	/* [3] = "48m", - note not successfully used yet */
 };
-
-void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
-				  void __iomem *r,
-				  struct mmc_ios *ios,
-				  struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	pr_debug("%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
-	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
-
-void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
-				  void __iomem *r,
-				  struct mmc_ios *ios,
-				  struct mmc_card *card)
-{
-	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
-
-	s3c6400_setup_sdhci_cfg_card(dev, r, ios, card);
-}
diff --git a/arch/arm/mach-s5pc100/setup-sdhci.c b/arch/arm/mach-s5pc100/setup-sdhci.c
index be25879..6418c6e 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci.c
@@ -11,17 +11,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
@@ -31,35 +21,3 @@ char *s5pc100_hsmmc_clksrcs[4] = {
 	[2] = "sclk_mmc",	/* mmc_bus */
 	/* [3] = "48m",		- note not successfully used yet */
 };
-
-
-void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
-				    void __iomem *r,
-				    struct mmc_ios *ios,
-				    struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	/* don't need to alter anything according to card-type */
-
-	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
-
-	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv210/setup-sdhci.c
index a83b6c9..6b8ccc4 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci.c
@@ -10,17 +10,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
@@ -30,34 +20,3 @@ char *s5pv210_hsmmc_clksrcs[4] = {
 	[2] = "sclk_mmc",	/* mmc_bus */
 	/* [3] = NULL,		- reserved */
 };
-
-void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
-				    void __iomem *r,
-				    struct mmc_ios *ios,
-				    struct mmc_card *card)
-{
-	u32 ctrl2, ctrl3;
-
-	/* don't need to alter anything according to card-type */
-
-	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
-
-	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
-		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
-
-	if (ios->clock < 25 * 1000000)
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
-			 S3C_SDHCI_CTRL3_FCSEL2 |
-			 S3C_SDHCI_CTRL3_FCSEL1 |
-			 S3C_SDHCI_CTRL3_FCSEL0);
-	else
-		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
-
-	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
-	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
-}
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 4a65520..e7b3c75 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -55,10 +55,6 @@ enum clk_types {
  *		 cd_type == S3C_SDHCI_CD_GPIO
  * @ext_cd_gpio_invert: invert values for external CD gpio line
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
- * @cfg_card: Configure the interface for a specific card and speed. This
- *            is necessary the controllers and/or GPIO blocks require the
- *	      changing of driver-strength and other controls dependent on
- *	      the card and speed of operation.
  *
  * Initialisation data specific to either the machine or the platform
  * for the device driver to use or call-back when configuring gpio or
@@ -80,10 +76,6 @@ struct s3c_sdhci_platdata {
 						      int state));
 
 	void	(*cfg_gpio)(struct platform_device *dev, int width);
-	void	(*cfg_card)(struct platform_device *dev,
-			    void __iomem *regbase,
-			    struct mmc_ios *ios,
-			    struct mmc_card *card);
 };
 
 /* s3c_sdhci_set_platdata() - common helper for setting SDHCI platform data
@@ -139,17 +131,11 @@ extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 #ifdef CONFIG_S3C2416_SETUP_SDHCI
 extern char *s3c2416_hsmmc_clksrcs[4];
 
-extern void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
-
 static inline void s3c2416_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
 #endif /* CONFIG_S3C_DEV_HSMMC */
 }
 
@@ -158,7 +144,6 @@ static inline void s3c2416_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
 #endif /* CONFIG_S3C_DEV_HSMMC1 */
 }
 
@@ -172,17 +157,11 @@ static inline void s3c2416_default_sdhci1(void) { }
 #ifdef CONFIG_S3C64XX_SETUP_SDHCI
 extern char *s3c64xx_hsmmc_clksrcs[4];
 
-extern void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
-					 void __iomem *r,
-					 struct mmc_ios *ios,
-					 struct mmc_card *card);
-
 static inline void s3c6400_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -191,7 +170,6 @@ static inline void s3c6400_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -200,21 +178,14 @@ static inline void s3c6400_default_sdhci2(void)
 #ifdef CONFIG_S3C_DEV_HSMMC2
 	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
 #endif
 }
 
-extern void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
-					 void __iomem *r,
-					 struct mmc_ios *ios,
-					 struct mmc_card *card);
-
 static inline void s3c6410_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -223,7 +194,6 @@ static inline void s3c6410_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -232,7 +202,6 @@ static inline void s3c6410_default_sdhci2(void)
 #ifdef CONFIG_S3C_DEV_HSMMC2
 	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -251,17 +220,11 @@ static inline void s3c6400_default_sdhci2(void) { }
 #ifdef CONFIG_S5PC100_SETUP_SDHCI
 extern char *s5pc100_hsmmc_clksrcs[4];
 
-extern void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
-
 static inline void s5pc100_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc100_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
 #endif
 }
 
@@ -270,7 +233,6 @@ static inline void s5pc100_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
 #endif
 }
 
@@ -279,7 +241,6 @@ static inline void s5pc100_default_sdhci2(void)
 #ifdef CONFIG_S3C_DEV_HSMMC2
 	s3c_hsmmc2_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
 #endif
 }
 
@@ -295,17 +256,11 @@ static inline void s5pc100_default_sdhci2(void) { }
 #ifdef CONFIG_S5PV210_SETUP_SDHCI
 extern char *s5pv210_hsmmc_clksrcs[4];
 
-extern void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
-
 static inline void s5pv210_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv210_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -314,7 +269,6 @@ static inline void s5pv210_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -323,7 +277,6 @@ static inline void s5pv210_default_sdhci2(void)
 #ifdef CONFIG_S3C_DEV_HSMMC2
 	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -332,7 +285,6 @@ static inline void s5pv210_default_sdhci3(void)
 #ifdef CONFIG_S3C_DEV_HSMMC3
 	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
-	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -348,17 +300,11 @@ static inline void s5pv210_default_sdhci3(void) { }
 #ifdef CONFIG_EXYNOS4_SETUP_SDHCI
 extern char *exynos4_hsmmc_clksrcs[4];
 
-extern void exynos4_setup_sdhci_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
-
 static inline void exynos4_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
 	s3c_hsmmc0_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = exynos4_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -367,7 +313,6 @@ static inline void exynos4_default_sdhci1(void)
 #ifdef CONFIG_S3C_DEV_HSMMC1
 	s3c_hsmmc1_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = exynos4_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -376,7 +321,6 @@ static inline void exynos4_default_sdhci2(void)
 #ifdef CONFIG_S3C_DEV_HSMMC2
 	s3c_hsmmc2_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = exynos4_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
@@ -385,7 +329,6 @@ static inline void exynos4_default_sdhci3(void)
 #ifdef CONFIG_S3C_DEV_HSMMC3
 	s3c_hsmmc3_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = exynos4_setup_sdhci3_cfg_gpio;
-	s3c_hsmmc3_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
 #endif
 }
 
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 6de1a38..4c9a207 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -50,8 +50,6 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
 		set->max_width = pd->max_width;
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
-	if (pd->cfg_card)
-		set->cfg_card = pd->cfg_card;
 	if (pd->host_caps)
 		set->host_caps |= pd->host_caps;
 	if (pd->clk_type)
-- 
1.6.6.rc2
