From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/3] mmc: dw_mmc: use slot-gpio to handle cd pin
Date: Sat, 28 Dec 2013 22:34:53 +0800
Message-ID: <1388241295-20051-2-git-send-email-zhangfei.gao@linaro.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43282 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab3L1Ohv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Dec 2013 09:37:51 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so10228546pad.38
        for <linux-mmc@vger.kernel.org>; Sat, 28 Dec 2013 06:37:51 -0800 (PST)
In-Reply-To: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Suggested by Jaehoon: Use slot-gpio to handle cd-gpio
Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4bce0deec362..a776f24f4311 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -36,6 +36,7 @@
 #include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "dw_mmc.h"
 
@@ -1032,20 +1033,26 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci_board *brd = slot->host->pdata;
+	int gpio_cd = !mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
 	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
+	else if (!IS_ERR_VALUE(gpio_cd))
+		present = !!gpio_cd;
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
 
-	if (present)
+	if (present) {
+		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	else
+	} else {
+		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is not present\n");
+	}
 
 	return present;
 }
@@ -1926,10 +1933,6 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 			/* Card change detected */
 			slot->last_detect_state = present;
 
-			/* Mark card as present if applicable */
-			if (present != 0)
-				set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 			/* Clean up queue if present */
 			mrq = slot->mrq;
 			if (mrq) {
@@ -1977,8 +1980,6 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 
 			/* Power down slot */
 			if (present == 0) {
-				clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 				/* Clear down the FIFO */
 				dw_mci_fifo_reset(host);
 #ifdef CONFIG_MMC_DW_IDMAC
@@ -2079,6 +2080,26 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 
 	return gpio;
 }
+
+/* find the cd gpio for a given slot; or -1 if none specified */
+static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+					struct mmc_host *mmc)
+{
+	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
+	int gpio;
+
+	if (!np)
+		return;
+
+	gpio = of_get_named_gpio(np, "cd-gpios", 0);
+
+	/* Having a missing entry is valid; return silently */
+	if (!gpio_is_valid(gpio))
+		return;
+
+	if (mmc_gpio_request_cd(mmc, gpio, 0))
+		dev_warn(dev, "gpio [%d] request failed\n", gpio);
+}
 #else /* CONFIG_OF */
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -2096,6 +2117,11 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 {
 	return -EINVAL;
 }
+static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+					struct mmc_host *mmc)
+{
+	return;
+}
 #endif /* CONFIG_OF */
 
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
@@ -2197,12 +2223,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
 	}
 
-	if (dw_mci_get_cd(mmc))
-		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-	else
-		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
+	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-- 
1.7.9.5

