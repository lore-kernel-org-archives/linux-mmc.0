From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] Samsung: sdhci-s3c: add support for new card detection
 methods
Date: Wed, 16 Jun 2010 08:49:13 +0200
Message-ID: <1276670954-17652-2-git-send-email-m.szyprowski@samsung.com>
References: <1276670954-17652-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37041 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab0FPGtZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jun 2010 02:49:25 -0400
In-reply-to: <1276670954-17652-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com

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
3. external gpio interrupt
4. no card detect line, controller will poll for the card
5. no card detect line, card is permanently wired to the controller
(once detected host won't poll it any more)

By default, all existing code would use method #1, what is compatible
with the previous version of the driver.

In case of external event, two callbacks must be provided in platdata:
ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
function that notifies the s3c-sdhci host contoller as their argument.
That callback function should be called from the even dispatcher to let
host notice the card insertion/removal.

In case of external gpio interrupt, a gpio pin number must be provided
in platdata (ext_cd_gpio parameter), as well as the information about
the polarity of that gpio pin (ext_cd_gpio_invert). By default
(ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
but this can be changed to 'card has been removed' when
ext_cd_gpio_invert == 1.

This patch adds all required changes to platform support code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 ++++++++++++++-----
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 +++++++++++++++-----
 arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
 arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
 arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   29 ++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 16 deletions(-)

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
index 4c05b39..b0f93f1 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -60,6 +60,11 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
+	set->ext_cd_gpio = pd->ext_cd_gpio;
+	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..1504fd8 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -60,6 +60,11 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
+	set->ext_cd_gpio = pd->ext_cd_gpio;
+	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..b28ef17 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -61,6 +61,11 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
 
 	set->max_width = pd->max_width;
+	set->cd_type = pd->cd_type;
+	set->ext_cd_init = pd->ext_cd_init;
+	set->ext_cd_cleanup = pd->ext_cd_cleanup;
+	set->ext_cd_gpio = pd->ext_cd_gpio;
+	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
 
 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 13f9fb2..5eb261f 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -20,10 +20,31 @@ struct mmc_host;
 struct mmc_card;
 struct mmc_ios;
 
+enum cd_types {
+	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
+	S3C_SDHCI_CD_EXTERNAL,	/* use external callback */
+	S3C_SDHCI_CD_GPIO,	/* use external gpio pin for CD line */
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
+ * @ext_cd_gpio: gpio pin used for external CD line, valid only if
+ *		 cd_type == S3C_SDHCI_CD_GPIO
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
  * @cfg_card: Configure the interface for a specific card and speed. This
  *            is necessary the controllers and/or GPIO blocks require the
@@ -37,9 +58,17 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	enum cd_types	cd_type;
 
 	char		**clocks;	/* set of clock sources */
 
+	int		ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
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

