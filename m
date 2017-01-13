From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to include leds.h
Date: Fri, 13 Jan 2017 14:14:02 +0100
Message-ID: <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33249 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdAMNOh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:14:37 -0500
Received: by mail-lf0-f47.google.com with SMTP id k86so37146119lfi.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 05:14:37 -0800 (PST)
In-Reply-To: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org

Some of the pxa platforms, balloon3, colibri-pxa270-income, corgi,
trizeps4, vpac270, zeus and zylonite depends on leds.h. Explicitly include
it instead of relying on the public mmc header host.h.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I am seeking an ack for this change as following changes for mmc in the
series, has build-dependencies to it.

---
 arch/arm/mach-pxa/balloon3.c              | 1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c | 1 +
 arch/arm/mach-pxa/corgi.c                 | 1 +
 arch/arm/mach-pxa/trizeps4.c              | 1 +
 arch/arm/mach-pxa/vpac270.c               | 1 +
 arch/arm/mach-pxa/zeus.c                  | 1 +
 arch/arm/mach-pxa/zylonite.c              | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 8a3c409..d452a49 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <linux/fb.h>
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 8cff770..d7cf47d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 183cd34..7270f0d 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -19,6 +19,7 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/pm.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index ea78bc5..3dd13b4 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index c006ee9..70ab3ad 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/mtd/mtd.h>
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 3b94ecf..ecbcaee 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 3642389..4268552 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/leds.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-- 
1.9.1

