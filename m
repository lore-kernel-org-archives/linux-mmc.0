From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH v2] mmc: cd-gpio.c: Include header to pickup exported symbol prototypes
Date: Tue, 17 Apr 2012 13:03:38 -0700
Message-ID: <201204171303.39744.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail209.messagelabs.com ([216.82.255.3]:9178 "EHLO
	mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2DQUD7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 16:03:59 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, g.liakhovetski@gmx.de, svenkatr@ti.com

Include the linux/mmc/cd-gpio.h header to pickup the prototypes
for the two exported symbols.

This quiets the sparse warnings:

warning: symbol 'mmc_cd_gpio_request' was not declared. Should it be static?
warning: symbol 'mmc_cd_gpio_free' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Venkatraman S <svenkatr@ti.com>

---

v2: add new header alphabetically

diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index 29de31e..2c14be7 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/slab.h>
