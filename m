From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] mmc: cd-gpio.c: Include header to pickup exported symbol prototypes
Date: Mon, 16 Apr 2012 18:24:26 -0700
Message-ID: <201204161824.26879.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, g.liakhovetski@gmx.de
List-Id: linux-mmc@vger.kernel.org

Include the linux/mmc/cd-gpio.h header to pickup the prototypes
for the two exported symbols.

This quiets the sparse warnings:

warning: symbol 'mmc_cd_gpio_request' was not declared. Should it be static?
warning: symbol 'mmc_cd_gpio_free' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index 29de31e..da7c3f9 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/cd-gpio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
