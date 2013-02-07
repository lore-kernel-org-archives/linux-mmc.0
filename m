From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] mmc: dw_mmc: exynos: Add pinctrl support
Date: Thu,  7 Feb 2013 17:27:16 +0530
Message-ID: <1360238236-17694-2-git-send-email-sachin.kamat@linaro.org>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:61807 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab3BGMGv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Feb 2013 07:06:51 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1186645dal.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Feb 2013 04:06:50 -0800 (PST)
In-Reply-To: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Added support for pin configuration using pinctrl subsystem.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index f15b4d3..31f5f47 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -11,11 +11,13 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
@@ -36,6 +38,8 @@
 #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+static struct pinctrl	*pctrl;
+
 /* Variations in Exynos specific dw-mshc controller */
 enum dw_mci_exynos_type {
 	DW_MCI_TYPE_EXYNOS4210,
@@ -160,6 +164,10 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
 	if (!slot_np)
 		return -EINVAL;
 
+	pctrl = devm_pinctrl_get_select_default(host->dev);
+	if (!IS_ERR(pctrl))
+		return 0;
+
 	/* cmd + clock + bus-width pins */
 	for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
 		gpio = of_get_gpio(slot_np, idx);
-- 
1.7.4.1

