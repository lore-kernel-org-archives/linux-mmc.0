From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/3] Samsung: sdhci-s3c: add support for new card detection
 methods
Date: Wed, 09 Jun 2010 11:39:04 +0200
Message-ID: <1276076345-24370-3-git-send-email-m.szyprowski@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

On some Samsung SoCs not all SDHCI controllers have card detect (CD)
line. For some embedded designs it is not even needed, because ususally
the device (like SDIO flash memory or wifi controller) is permanently
wired to the controller. There are also systems which have a card detect
line connected to some of the external interrupt lines or the presence
of the card depends on some other actions (like enabling a power
regulator).

This patch adds support for all these cases. The following card
detection methods are possible:

1. internal sdhci host card detect line
2. external event
3. no card detect line, controller will poll for the card
4. no card detect line, card is permanently wired to the controller
(once detected host won't poll it any more)

By default, all existing code would use method #1, what is compatible
with the previous version of the driver.

In case of external event, two callbacks must be provided in platdata:
ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
function that notifies the s3c-sdhci host contoller as their argument.
That callback function should be called from the even dispatcher to let
host notice the card insertion/removal.

This patch adds all required changes to platform support code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 ++++++++++----
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 +++++++++++++++------
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 ++++++++++++++++------
 arch/arm/plat-samsung/dev-hsmmc.c          |    3 +++
 arch/arm/plat-samsung/dev-hsmmc1.c         |    3 +++
 arch/arm/plat-samsung/dev-hsmmc2.c         |    3 +++
 arch/arm/plat-samsung/include/plat/sdhci.h |   23 +++++++++++++++++++++++
 7 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index a58c0cc..54c311c 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -22,6 +22,7 @@
 
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 	unsigned int end;
 
@@ -33,12 +34,15 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(2));
+	}
 }
 
 void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 	unsigned int end;
 
@@ -50,8 +54,10 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(3));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(3));
+	}
 }
 
 void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index 7769c76..e4b6739 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -23,6 +23,7 @@
 
 void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 	unsigned int end;
 	unsigned int num;
@@ -47,12 +48,15 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 		}
 	}
 
-	s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG1(2), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PC100_GPG1(2), S3C_GPIO_SFN(2));
+	}
 }
 
 void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 	unsigned int end;
 
@@ -64,12 +68,15 @@ void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-	s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
+	}
 }
 
 void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 	unsigned int end;
 
@@ -81,6 +88,8 @@ void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-	s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
+	}
 }
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index fe7d86d..b3ad243 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -21,9 +21,11 @@
 #include <mach/gpio.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-sdhci.h>
+#include <plat/sdhci.h>
 
 void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
@@ -48,12 +50,15 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 		break;
 	}
 
-	s3c_gpio_setpull(S5PV210_GPG0(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPG0(2), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG0(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG0(2), S3C_GPIO_SFN(2));
+	}
 }
 
 void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
@@ -68,12 +73,15 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-	s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
+	}
 }
 
 void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
 	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
@@ -99,6 +107,8 @@ void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 		break;
 	}
 
-	s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
+	}
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 4c05b39..238c6a1 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -60,6 +60,9 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..1da8481 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -60,6 +60,9 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..f11b1ca 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -61,6 +61,9 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index c2044e5..6f00a76 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -20,10 +20,27 @@ struct mmc_host;
 struct mmc_card;
 struct mmc_ios;
 
+enum cd_types {
+	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
+	S3C_SDHCI_CD_EXTERNAL,	/* use external method (like GPIO interrupt) */
+	S3C_SDHCI_CD_NONE,	/* no CD line, use polling to detect card */
+	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
+};
+
 /**
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
+ * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @ext_cd_init: Initialize external card detect subsystem. Called on
+ *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
+ *		 notify_func argument is a callback to the sdhci-s3c driver
+ *		 that triggers the card detection event. Callback arguments:
+ *		 dev is pointer to platform device of the host controller,
+ *		 state is new state of the card (0 - removed, 1 - inserted).
+ * @ext_cd_cleanup: Cleanup external card detect subsystem. Called on
+ *		 sdhci-s3c driver remove when cd_type == S3C_SDHCI_CD_EXTERNAL.
+ *		 notify_func argument is the same callback as for ext_cd_init.
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
  * @cfg_card: Configure the interface for a specific card and speed. This
  *            is necessary the controllers and/or GPIO blocks require the
@@ -37,9 +54,15 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	enum cd_types	cd_type;
 
 	char		**clocks;	/* set of clock sources */
 
+	int 	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
+						   int state));
+	int 	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
+						      int state));
+
 	void	(*cfg_gpio)(struct platform_device *dev, int width);
 	void	(*cfg_card)(struct platform_device *dev,
 			    void __iomem *regbase,
-- 
1.7.1.240.g225c
