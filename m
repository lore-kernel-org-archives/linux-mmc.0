From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/7] mmc: slot-gpio: Make mmc_gpio_alloc() available for MMC core
Date: Thu, 18 Dec 2014 15:44:34 +0100
Message-ID: <1418913876-13937-6-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57489 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbaLROox (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:53 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so1809089wib.5
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:52 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

As a step in moving slot-gpio functions/structs closer to the MMC core,
let's add a local header file for slot-gpio.

In this initial step we move mmc_gpio_alloc() into the header file,
to make it available for the MMC core. Following patches will show the
utilization of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/slot-gpio.c |  4 +++-
 drivers/mmc/core/slot-gpio.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/slot-gpio.h

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index f9a0c6e..ec918c2 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -18,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include "slot-gpio.h"
+
 struct mmc_gpio {
 	struct gpio_desc *ro_gpio;
 	struct gpio_desc *cd_gpio;
@@ -38,7 +40,7 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mmc_gpio_alloc(struct mmc_host *host)
+int mmc_gpio_alloc(struct mmc_host *host)
 {
 	size_t len = strlen(dev_name(host->parent)) + 4;
 	struct mmc_gpio *ctx;
diff --git a/drivers/mmc/core/slot-gpio.h b/drivers/mmc/core/slot-gpio.h
new file mode 100644
index 0000000..8c1854d
--- /dev/null
+++ b/drivers/mmc/core/slot-gpio.h
@@ -0,0 +1,13 @@
+/*
+  * Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _MMC_CORE_SLOTGPIO_H
+#define _MMC_CORE_SLOTGPIO_H
+
+int mmc_gpio_alloc(struct mmc_host *host);
+
+#endif
-- 
1.9.1

