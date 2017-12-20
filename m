From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/2] mmc: sunxi: Reorder the headers
Date: Wed, 20 Dec 2017 11:50:34 +0100
Message-ID: <e7cdb601748b43bc6c3641c7c650327c4731b2cd.1513766964.git-series.maxime.ripard@free-electrons.com>
References: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54091 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbdLTKuv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Dec 2017 05:50:51 -0500
In-Reply-To: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
References: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Our headers sort algorithm has had pretty chaotic results. Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 43 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355dbdb9..3ce46ebd3488 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -13,36 +13,33 @@
  * the License, or (at your option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-
 #include <linux/clk.h>
 #include <linux/clk/sunxi-ng.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/scatterlist.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/slab.h>
-#include <linux/reset.h>
-#include <linux/regulator/consumer.h>
-
-#include <linux/of_address.h>
-#include <linux/of_gpio.h>
-#include <linux/of_platform.h>
-
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
-#include <linux/mmc/mmc.h>
-#include <linux/mmc/core.h>
-#include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 /* register offset definitions */
 #define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
-- 
git-series 0.9.1
