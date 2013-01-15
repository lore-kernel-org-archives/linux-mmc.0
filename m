From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] gpio: fix warning of 'struct gpio_chip' declaration
Date: Tue, 15 Jan 2013 16:37:35 +0800
Message-ID: <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:40821
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755158Ab3AOIhT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Jan 2013 03:37:19 -0500
In-Reply-To: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

The struct gpio_chip is only defined inside #ifdef CONFIG_GPIOLIB,
but it's referenced by gpiochip_add_pin_range() and
gpiochip_remove_pin_ranges() which are outside #ifdef CONFIG_GPIOLIB.
Thus, we see the following warning when building blackfin image, where
GPIOLIB is not required.

  CC      arch/blackfin/kernel/bfin_gpio.o
  CC      init/version.o
In file included from arch/blackfin/include/asm/gpio.h:321,
                 from arch/blackfin/kernel/bfin_gpio.c:15:
include/asm-generic/gpio.h:298: warning: =E2=80=98struct gpio_chip=E2=80=
=99 declared inside parameter list
include/asm-generic/gpio.h:298: warning: its scope is only this definit=
ion or declaration, which is probably not what you want
include/asm-generic/gpio.h:304: warning: =E2=80=98struct gpio_chip=E2=80=
=99 declared inside parameter list

Move pinctrl trunk into #ifdef CONFIG_GPIOLIB to fix the warning,
since it appears that pinctrl gpio range support depends on GPIOLIB.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/asm-generic/gpio.h |   74 ++++++++++++++++++++++--------------=
--------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 20ca766..2341014 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -212,6 +212,43 @@ extern void gpio_unexport(unsigned gpio);
=20
 #endif	/* CONFIG_GPIO_SYSFS */
=20
+#ifdef CONFIG_PINCTRL
+
+/**
+ * struct gpio_pin_range - pin range controlled by a gpio chip
+ * @head: list for maintaining set of pin ranges, used internally
+ * @pctldev: pinctrl device which handles corresponding pins
+ * @range: actual range of pins controlled by a gpio controller
+ */
+
+struct gpio_pin_range {
+	struct list_head node;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_gpio_range range;
+};
+
+int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_=
name,
+			   unsigned int gpio_offset, unsigned int pin_offset,
+			   unsigned int npins);
+void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
+
+#else
+
+static inline int
+gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name=
,
+		       unsigned int gpio_offset, unsigned int pin_offset,
+		       unsigned int npins)
+{
+	return 0;
+}
+
+static inline void
+gpiochip_remove_pin_ranges(struct gpio_chip *chip)
+{
+}
+
+#endif /* CONFIG_PINCTRL */
+
 #else	/* !CONFIG_GPIOLIB */
=20
 static inline bool gpio_is_valid(int number)
@@ -270,41 +307,4 @@ static inline void gpio_unexport(unsigned gpio)
 }
 #endif	/* CONFIG_GPIO_SYSFS */
=20
-#ifdef CONFIG_PINCTRL
-
-/**
- * struct gpio_pin_range - pin range controlled by a gpio chip
- * @head: list for maintaining set of pin ranges, used internally
- * @pctldev: pinctrl device which handles corresponding pins
- * @range: actual range of pins controlled by a gpio controller
- */
-
-struct gpio_pin_range {
-	struct list_head node;
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_gpio_range range;
-};
-
-int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_=
name,
-			   unsigned int gpio_offset, unsigned int pin_offset,
-			   unsigned int npins);
-void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
-
-#else
-
-static inline int
-gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name=
,
-		       unsigned int gpio_offset, unsigned int pin_offset,
-		       unsigned int npins)
-{
-	return 0;
-}
-
-static inline void
-gpiochip_remove_pin_ranges(struct gpio_chip *chip)
-{
-}
-
-#endif /* CONFIG_PINCTRL */
-
 #endif /* _ASM_GENERIC_GPIO_H */
--=20
1.7.9.5


