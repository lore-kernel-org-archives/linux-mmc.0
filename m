From: Domenico Andreoli <dr.domenico.andreoli@gmail.com>
Subject: [PATCH 2/2] Add GPIO DT support to s3c24xx
Date: Thu, 21 Apr 2011 15:17:39 +0200
Message-ID: <20110421131739.GA15194@dandreoli.com>
References: <20110421130711.920096092@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53155 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1DUNRm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 09:17:42 -0400
Received: by wwa36 with SMTP id 36so2083903wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 06:17:41 -0700 (PDT)
Content-Disposition: inline; filename=s3c24xx-gpio-add-dt-support
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

From: Domenico Andreoli <cavokz@gmail.com>

Assign proper OF node (= with matching physical base address) to each
s3c24xx GPIO chip.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 arch/arm/plat-s3c24xx/gpiolib.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: b/arch/arm/plat-s3c24xx/gpiolib.c
===================================================================
--- a/arch/arm/plat-s3c24xx/gpiolib.c	2011-04-10 23:28:31.000000000 +0200
+++ b/arch/arm/plat-s3c24xx/gpiolib.c	2011-04-11 11:23:36.000000000 +0200
@@ -19,6 +19,8 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -210,6 +212,39 @@
 	},
 };
 
+#ifdef CONFIG_OF_GPIO
+
+static void s3c24xx_attach_of_node(struct s3c_gpio_chip *chip)
+{
+	struct device_node *dn;
+	struct resource res;
+	const char *dt_compat;
+
+	if (chip->base == S3C2410_GPACON)
+		dt_compat = "samsung,s3c2410-gpio-a";
+	else
+		dt_compat = "samsung,s3c2410-gpio";
+
+	for_each_compatible_node(dn, NULL, dt_compat) {
+		if (of_address_to_resource(dn, 0, &res) < 0) {
+			printk(KERN_ERR "%s: unable to translate DT address\n", dn->full_name);
+			continue;
+		}
+
+		if (chip->base == (res.start - S3C24XX_PA_GPIO + S3C24XX_VA_GPIO)) {
+			chip->chip.of_node = dn;
+			break;
+		}
+	}
+}
+
+#else
+
+static void s3c24xx_attach_of_node(struct s3c_gpio_chip *chip)
+{
+}
+
+#endif
 
 static __init int s3c24xx_gpiolib_init(void)
 {
@@ -220,6 +255,7 @@
 		if (!chip->config)
 			chip->config = &s3c24xx_gpiocfg_default;
 
+		s3c24xx_attach_of_node(chip);
 		s3c_gpiolib_add(chip);
 	}
 

