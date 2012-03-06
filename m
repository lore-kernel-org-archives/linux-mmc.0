From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 4/4] ARM: SAMSUNG: move the mmc platdata header file to
 linux/mmc/
Date: Tue, 06 Mar 2012 15:17:29 +0900
Message-ID: <4F55ABF9.4000403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/sdhci.h |   53 +-----------------
 include/linux/mmc/sdhci-s3c.h              |   84 ++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/mmc/sdhci-s3c.h

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 95a6e19..f2d4f60 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -19,58 +19,7 @@
 #define __PLAT_S3C_SDHCI_H __FILE__
 
 #include <plat/devs.h>
-
-struct platform_device;
-struct mmc_host;
-struct mmc_card;
-struct mmc_ios;
-
-enum cd_types {
-	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
-	S3C_SDHCI_CD_EXTERNAL,	/* use external callback */
-	S3C_SDHCI_CD_GPIO,	/* use external gpio pin for CD line */
-	S3C_SDHCI_CD_NONE,	/* no CD line, use polling to detect card */
-	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
-};
-
-/**
- * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
- * @max_width: The maximum number of data bits supported.
- * @host_caps: Standard MMC host capabilities bit field.
- * @cd_type: Type of Card Detection method (see cd_types enum above)
- * @ext_cd_init: Initialize external card detect subsystem. Called on
- *		 sdhci-s3c driver probe when cd_type == S3C_SDHCI_CD_EXTERNAL.
- *		 notify_func argument is a callback to the sdhci-s3c driver
- *		 that triggers the card detection event. Callback arguments:
- *		 dev is pointer to platform device of the host controller,
- *		 state is new state of the card (0 - removed, 1 - inserted).
- * @ext_cd_cleanup: Cleanup external card detect subsystem. Called on
- *		 sdhci-s3c driver remove when cd_type == S3C_SDHCI_CD_EXTERNAL.
- *		 notify_func argument is the same callback as for ext_cd_init.
- * @ext_cd_gpio: gpio pin used for external CD line, valid only if
- *		 cd_type == S3C_SDHCI_CD_GPIO
- * @ext_cd_gpio_invert: invert values for external CD gpio line
- * @cfg_gpio: Configure the GPIO for a specific card bit-width
- *
- * Initialisation data specific to either the machine or the platform
- * for the device driver to use or call-back when configuring gpio or
- * card speed information.
-*/
-struct s3c_sdhci_platdata {
-	unsigned int	max_width;
-	unsigned int	host_caps;
-	unsigned int	pm_caps;
-	enum cd_types	cd_type;
-
-	int		ext_cd_gpio;
-	bool		ext_cd_gpio_invert;
-	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
-						   int state));
-	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
-						      int state));
-
-	void	(*cfg_gpio)(struct platform_device *dev, int width);
-};
+#include <linux/mmc/sdhci-s3c.h>
 
 /* s3c_sdhci_set_platdata() - common helper for setting SDHCI platform data
  * @pd: The default platform data for this device.
diff --git a/include/linux/mmc/sdhci-s3c.h b/include/linux/mmc/sdhci-s3c.h
new file mode 100644
index 0000000..7dafaa4
--- /dev/null
+++ b/include/linux/mmc/sdhci-s3c.h
@@ -0,0 +1,84 @@
+/*
+ * include/linux/mmc/sdhci-s3c.h
+ *
+ * SDHCI declarations specific to Samsung platform
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef LINUX_MMC_SDHCI_S3C_H
+#define LINUX_MMC_SDHCI_S3C_H
+
+#include <linux/platform_device.h>
+
+struct platform_device;
+struct mmc_host;
+struct mmc_card;
+struct mmc_ios;
+enum cd_types {
+	S3C_SDHCI_CD_INTERNAL,	/* use mmc internal CD line */
+	S3C_SDHCI_CD_EXTERNAL,	/* use external callback */
+	S3C_SDHCI_CD_GPIO,	/* use external gpio pin for CD line */
+	S3C_SDHCI_CD_NONE,	/* no CD line, use polling to detect card */
+	S3C_SDHCI_CD_PERMANENT,	/* no CD line, card permanently wired to host */
+};
+
+enum clk_types {
+	S3C_SDHCI_CLK_DIV_INTERNAL,	/* use mmc internal clock divider */
+	S3C_SDHCI_CLK_DIV_EXTERNAL,	/* use external clock divider */
+};
+
+/**
+ * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
+ * @max_width: The maximum number of data bits supported.
+ * @host_caps: Standard MMC host capabilities bit field.
+ * @cd_type: Type of Card Detection method (see cd_types enum above)
+ * @clk_type: Type of clock divider method (see clk_types enum above)
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
+ * @cfg_gpio: Configure the GPIO for a specific card bit-width
+ *
+ * Initialisation data specific to either the machine or the platform
+ * for the device driver to use or call-back when configuring gpio or
+ * card speed information.
+*/
+struct s3c_sdhci_platdata {
+	unsigned int	max_width;
+	unsigned int	host_caps;
+	unsigned int	host_caps2;
+	unsigned int	pm_caps;
+	enum cd_types	cd_type;
+	enum clk_types	clk_type;
+
+	char		**clocks;	/* set of clock sources */
+
+	int		ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
+	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
+						   int state));
+	int	(*ext_cd_cleanup)(void (*notify_func)(struct platform_device *,
+						      int state));
+
+	void	(*cfg_gpio)(struct platform_device *dev, int width);
+};
+
+#endif /* LINUX_MMC_SDHCI_S3C_H */
